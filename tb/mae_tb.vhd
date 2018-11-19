----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2018 11:27:22
-- Design Name: 
-- Module Name: mae_tb - Behavioral
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

entity mae_tb is
--  Port ( );
end mae_tb;

architecture Behavioral of mae_tb is
   signal      clk_100 :   STD_LOGIC:='0';
   signal      clk_1 :     STD_LOGIC;
   signal      reset :     STD_LOGIC;
   signal      go_1 :      STD_LOGIC;
   signal      fin_1 :     STD_LOGIC;
   signal      go_0 :      STD_LOGIC;
   signal      fin_0 :     STD_LOGIC;
   signal      cmd_tempo : STD_LOGIC_VECTOR (0 downto 0);
   signal      fin_tempo : STD_LOGIC;
   signal      cmd_reg :   STD_LOGIC_VECTOR (1 downto 0);
   signal      read_reg :  STD_LOGIC;

   signal      dcc_0 :     std_logic;
   signal      dcc_1 :     std_logic;

   signal      trame_dcc : std_logic_vector (50 downto 0);
   
begin
mae: entity work.mae port map (
    clk => clk_100,
    reset => reset,
    go_1 => go_1,    
    fin_1 => fin_1, 
    go_0 => go_0,
    fin_0 =>  fin_0,
    cmd_tempo => cmd_tempo,
    fin_tempo => fin_tempo,
    cmd_reg => cmd_reg,
    read_reg => read_reg 
    );

clock:  entity work.clock_div port map (
    clk_100 => clk_100,
    reset => reset,
    clk_1 => clk_1);

dcc_bit0: entity work.dcc_bit0 port map(
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
        go_1 => go_1,
        fin_1 => fin_1,
        dcc_1 => dcc_1);    

tempo: entity work.tempo port map(
    clk_1 => clk_1,
    reset => reset,
    com_tempo => cmd_tempo(0),
    fin => fin_tempo);
    
reg_dcc: entity work.registre_dcc port map(
    clk_100 => clk_100,
    reset => reset,
    com_reg => cmd_reg,
    trame_dcc => trame_dcc,
    data => read_reg);

clk_100 <= not clk_100 after 5 ns;
reset <= '1', '0' after 20ns;

trame_dcc <= "100010000000001000000000000000000000000000010010001", "1010100000010000010000000001000000000000100000000111" after 50 ms;
--process (cmd_reg)
--begin       
--if rising_edge(cmd_reg(0)) then
--read_reg <= not read_reg;
--end if;
--end process;

end Behavioral;
