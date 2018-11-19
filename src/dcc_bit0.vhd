library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DCC_BIT0 is
  Port ( clk_100 : in STD_LOGIC;
         clk_1 : in STD_LOGIC;
         reset : in STD_LOGIC;
         go_0 : in STD_LOGIC;
         fin_0 : out STD_LOGIC;
         dcc_0 : out STD_LOGIC);
end DCC_BIT0;

architecture Behavioral of DCC_BIT0 is

  type state is (IDLE, GEN_low, GEN_high, FIN_state);
  signal EP, EF : state;
  signal cpt    : integer:=0;
  signal seuil  : integer:=100; -- pour BIT1 := 58
  signal seuilb : integer:=200; -- pour BIT1 := 116

  signal flag: std_logic;

begin

  process(clk_1, EP, cpt)
  begin
    if rising_edge(clk_1) then
      if EP = GEN_low or EP = GEN_high then
        cpt <= cpt+1;
      end if;
      if flag='1' then
        cpt <= 0;
      end if;
    end if;
  end process;

  process(EP, go_0, clk_100, reset, cpt, seuil, seuilb)
  begin
    if reset = '1' then
      EP <= IDLE;
      dcc_0 <= '0';
      fin_0 <= '0';
      flag <= '0';
    elsif rising_edge(clk_100) then
      -- a chaque front d'horloge on passe a l'etat futur
      EP <= EF;

      -- gestion du flag
      if EP = FIN_STATE then flag <='1'; end if;
      if cpt = 0 then flag <='0'; end if;
    end if;

    case (EP) is
      when IDLE =>
        -- etat futur
        EF <= IDLE;
        if go_0 = '1' then EF <= GEN_low; end if;

        -- sorties
        fin_0 <= '0'; dcc_0 <= '0';

      when GEN_low =>
        -- calcul etat futur
        EF <= GEN_low;
        if cpt = seuil then EF <= GEN_high; end if;

        -- sorties
        fin_0 <= '0'; dcc_0 <= '0';

      when GEN_high =>
        -- etat futur
        EF <= GEN_high ;
        if cpt = seuilb then EF <= FIN_state; end if;

        -- sorties
        fin_0 <= '0'; dcc_0 <= '1';

      when FIN_state =>
        -- etat futur
        EF <= IDLE;

        -- sorties
        fin_0 <= '1'; dcc_0 <= '0';

      when others => null;
    end case;
  end process;
end Behavioral;
