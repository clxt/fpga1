library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registre_dcc is
  Port ( clk_100 : in STD_LOGIC;
         reset : in STD_LOGIC;
         com_reg : in STD_LOGIC_VECTOR (1 downto 0);
         trame_dcc : in STD_LOGIC_VECTOR (50 downto 0);
         data : out STD_LOGIC);
end registre_dcc;

architecture Behavioral of registre_dcc is
signal tmp : std_logic_vector (50 downto 0);
begin

  process(clk_100, reset, com_reg)
  begin
    if reset = '1' then
      data <= '0';
      tmp <= "000000000000000000000000000000000000000000000000000";
    elsif rising_edge(clk_100) then

      -- commande de chargement nouvelle trame
      if com_reg(1) = '1' then
        tmp <= trame_dcc;

      -- commande decalage
      elsif com_reg(0) = '1' then
        tmp <= tmp(49 downto 0) & '0' ;
        data <= tmp(50);
      end if;

    end if;
  end process;
end Behavioral;
