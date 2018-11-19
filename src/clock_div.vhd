library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_div is
  Port ( clk_100 : in STD_LOGIC;
         reset : in STD_LOGIC;
         clk_1 : out STD_LOGIC);
end clock_div;

architecture Behavioral of clock_div is

signal cpt : integer;
signal clock: std_logic;

begin
  process (clk_100)
  begin
    if reset='1' then
      cpt <= 0;
      clock <= '0';
    else
      if rising_edge (clk_100) then
        cpt <= cpt+1;
        if cpt = 49 then -- divise la fréquence par 100
          clock <= not clock;
          cpt <= 0;
        end if ;
      end if;
    end if;
  end process;

  clk_1 <= clock;

end Behavioral;
