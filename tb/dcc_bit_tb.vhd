----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2018 12:55:05
-- Design Name: 
-- Module Name: dcc_bit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dcc_bit_tb is
--  Port ( );
end dcc_bit_tb;

architecture Behavioral of dcc_bit_tb is

signal clk_100 : std_logic; --in
signal reset : std_logic;   --in
signal clk_1 :std_logic;    -- out for in
signal go_0 : std_logic;    --in
signal fin_0 : std_logic;   --out
signal dcc_0 : std_logic;   --out

signal go_1 : std_logic;    --in
signal fin_1 : std_logic;   --out
signal dcc_1 : std_logic;   --out


begin
clock: entity work.clock_div port map (
    clk_100 => clk_100,
    reset => reset,
    clk_1 => clk_1);
  
dcc_bit: entity work.dcc_bit0 port map(
    clk_100 => clk_100,
    reset => reset,
    clk_1 => clk_1,
    go_0 => go_0,
    fin_0 => fin_0,
    dcc_0 => dcc_0);

dcc_bit1: entity work.dcc_bit1 port map(
    clk_100 => clk_100,
    reset => reset,
    clk_1 => clk_1,
    go_0 => go_1,
    fin_0 => fin_1,
    dcc_0 => dcc_1
    );
-- entrees    
    clk_100 <= '0', not clk_100 after 5 ns;
    reset <= '1', '0' after 10 ns;
    go_0 <= '0', '1' after 1 ms, '0' after 20 ms, '1' after 376 ms, '0' after 377 ms;
    go_1 <= '1', '0' after 1 ms, '0' after 20 ms, '0' after 376 ms, '1' after 377 ms;

end Behavioral;
