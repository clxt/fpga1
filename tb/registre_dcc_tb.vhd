----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.04.2018 12:57:14
-- Design Name: 
-- Module Name: registre_dcc_tb - Behavioral
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

entity registre_dcc_tb is
--  Port ( );
end registre_dcc_tb;

architecture Behavioral of registre_dcc_tb is

signal clk_100: std_logic:='0';
signal reset: std_logic;
signal com_reg: std_logic_vector(1 downto 0);
signal trame_dcc: std_logic_vector(49 downto 0);

begin

coucou: entity work.registre_dcc port map(
     clk_100 => clk_100,
           reset => reset,
           com_reg => com_reg,
           trame_dcc => trame_dcc,
           data => data
           );
           
clk_100 <= not clk_100 after 5 ns;
reset <= '1', '0' after 20 ns;
trame_dcc <= "00000000000000000000000000000000000000000010010001", "101010000001000001000000001000000000000100000000111" after 30 ms;
com_reg <= "00", "10" after 30 ns, "11" after 60 ns, "00" after 90 ns;
--end registre_dcc;

end Behavioral;
