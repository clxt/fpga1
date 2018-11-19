library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_div_tb is
 --   Port ( clk_100 : in STD_LOGIC;
  --         reset : in STD_LOGIC;
  --         clk_1 : out STD_LOGIC);
end clock_div_tb;

architecture Behavioral of clock_div_tb is

--component clock_div 
--            Port ( clk_100: in std_logic,
--                   reset: in std_logic,
--                   clk_1: out std_logic);
--end component;
signal clk_100 : std_logic:='0';
signal reset : std_logic;
signal clk_1 :std_logic;
begin

clock: entity work.clock_div port map (
clk_100 => clk_100,
reset => reset,
clk_1 => clk_1);

    clk_100 <= not clk_100 after 5 ns;
    reset <= '1', '0' after 100 ns;
end Behavioral;
