library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tempo is
  Port ( clk_1 : in STD_LOGIC;
         reset : in STD_LOGIC;
         com_tempo : in STD_LOGIC;
         fin : out STD_LOGIC);
end tempo;

architecture Behavioral of tempo is

signal cpt : integer;
signal signal_fin: std_logic;

begin
  process (clk_1,reset,com_tempo)
  begin
    if reset='1' then
      cpt<=0;
      signal_fin<='0';
    else
      if com_tempo = '1' then

        if rising_edge (clk_1) then
          -- increment a chaque front d'horloge
          cpt <= cpt+1;

          -- apres 6ms signal = 1
          -- compteur a zero
          if cpt=6000 then
            signal_fin <= '1';
            cpt<=0;
          end if ;

        end if;
      else
        signal_fin <='0';
      end if;
    end if;
  end process;
  -- sortie
  fin<=signal_fin;
end Behavioral;
