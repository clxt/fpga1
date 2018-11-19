library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mae is
  Port ( clk : in STD_LOGIC;
         reset : in STD_LOGIC;
         go_1 : out STD_LOGIC;
         fin_1 : in STD_LOGIC;
         go_0 : out STD_LOGIC;
         fin_0 : in STD_LOGIC;
         cmd_tempo : out STD_LOGIC_VECTOR (0 downto 0);
         fin_tempo : in STD_LOGIC;
         cmd_reg : out STD_LOGIC_VECTOR (1 downto 0);
         read_reg : in STD_LOGIC);
end mae;

architecture Behavioral of mae is
   type etat is (READ, TEMPO, GEN1, GEN0);
   signal EP, EF : etat;
   signal cpt : integer:=0;		

begin

  process(clk, reset, EP, fin_1, fin_0, fin_tempo, read_reg)
  begin
    if reset='1' then EP <= READ; cpt <= 0;
    elsif rising_edge(clk) then
      EP <= EF;
      -- gestion compteur
      if (EP = READ) then
        cpt <= cpt +1;
      elsif (EP = TEMPO) then
        cpt <= 0;
      end if;
    end if;
  end process;

  process(EP,fin_1,fin_0,fin_tempo,cpt,read_reg)
  begin
    case (EP) is
      when GEN1 =>
        -- etat futur
        EF <= GEN1;
        if fin_1 = '1' then EF <= READ; end if;
        -- sorties
        go_1 <= '1'; go_0 <='0'; cmd_tempo <= "0" ; cmd_reg <="00";
                
      when GEN0 =>
        -- etat futur
        EF <= GEN0;
        if fin_0 = '1' then EF <= READ; end if;
        -- sorties
        go_1 <= '0'; go_0 <='1'; cmd_tempo <= "0" ; cmd_reg <="00";
                 
      when TEMPO=>
        -- etat futur
        EF <= TEMPO;
        if fin_tempo = '1' then EF <= READ; end if;
        -- sorties
        go_1 <= '0'; go_0 <='0'; cmd_tempo <= "1" ; cmd_reg <="10";
                
      when READ =>
        -- etat futur
        EF <= READ;
        if cpt = 52 then EF <= TEMPO; 
        elsif read_reg = '1' then EF <= GEN1;
        elsif read_reg = '0' then EF <= GEN0;
        end if;
        -- sorties
        go_1 <= '0'; go_0 <='0'; cmd_tempo <= "0" ; cmd_reg <="01";

    end case;
  end process;

end Behavioral;
