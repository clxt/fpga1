

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tempo_tb is
end tempo_tb;

architecture Behavioral of tempo_tb is

signal clk_100 : std_logic:='0';
signal reset : std_logic;
signal clk_1 :std_logic;
signal com_tempo : std_logic:='0';
signal fin : std_logic;



begin
clock: entity work.clock_div port map (
    clk_100 => clk_100,
    reset => reset,
    clk_1 => clk_1);
  
dcc_bit: entity work.tempo port map(
    clk_1 => clk_1,
    reset => reset,
    com_tempo => com_tempo,
    fin => fin);

-- entrees    
    clk_100 <= not clk_100 after 5 ns;
    reset <= '1', '0' after 20 ns;
    com_tempo <= '1' after 1 ms, '0' after 8 ms; --'1' after 11 ms, '0' after 12 ms;

end Behavioral;
