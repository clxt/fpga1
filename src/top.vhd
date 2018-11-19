library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_projet is
  Port (
    clk_100 : in std_logic;
    reset : in std_logic;
    bouton_g : in  STD_LOGIC;	         ---bouton gauche	 E stop
    bouton_validation : in  STD_LOGIC;  ---bouton central VALIDATION
    bouton_d : in  STD_LOGIC;           ---bouton droit   stop
    bouton_h : in  STD_LOGIC;           ---bouton haut    monte la vitesse
    bouton_b : in  STD_LOGIC;           ---bouton bas     baisse la vitesse
    switch0 : in STD_LOGIC;   ---switch 0 fO a  f4
    switch1 : in STD_LOGIC;   ---switch 1 f5 a  f12
    switch2 : in STD_LOGIC;   ---switch 2 f13 a  f20
           --------------------------------------------f1--f2---f3
    switch3 : in STD_LOGIC; ---switch Active la fonction 0, 5 ou 13
    switch4 : in STD_LOGIC; ---switch Active la fonction 1, 6 ou 14
    switch5 : in STD_LOGIC; ---switch Active la fonction 2, 7 ou 15
    switch6 : in STD_LOGIC; ---switch Active la fonction 3, 8 ou 16
    switch7: in STD_LOGIC;  ---switch Active la fonction 4, 9 ou 17
    switch8: in STD_LOGIC;  ---switch Active la fonction 10 ou 18
    switch9: in STD_LOGIC;  ---switch Active la fonction 11 ou 19
    switch10: in STD_LOGIC; ---switch Active la fonction 12 ou 20
    switch11: in STD_LOGIC; ---switch 11 Choix train 1 ou 2
    switch12: in STD_LOGIC; --marche avant ou arriere
    switch13: in STD_LOGIC; --choix vitesse
    sortie_dcc : out std_logic;
    led_f0 : out  STD_LOGIC;  ---led 0
    led_f1 : out  STD_LOGIC;  ---led 1
    led_f2 : out  STD_LOGIC;  ---led 2
    led_f11 : out  STD_LOGIC; ---led 11 alumee = train 1 / eteinte = train 2
    led_f12 : out  STD_LOGIC  ---led 11 alumee = train marche avant / eteinte = train marche arriere
);
end top_projet;

architecture Behavioral of top_projet is

   signal clk_1 :     STD_LOGIC;
   signal go_1 :      STD_LOGIC;
   signal fin_1 :     STD_LOGIC;
   signal go_0 :      STD_LOGIC;
   signal fin_0 :     STD_LOGIC;
   signal cmd_tempo : STD_LOGIC_VECTOR (0 downto 0);
   signal fin_tempo : STD_LOGIC;
   signal cmd_reg :   STD_LOGIC_VECTOR (1 downto 0);
   signal read_reg :  STD_LOGIC;
   signal dcc_0 :     std_logic;
   signal dcc_1 :     std_logic;
   signal trame_dcc : std_logic_vector (50 downto 0);
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
    read_reg => read_reg);

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
    go_0 => go_1,
    fin_0 => fin_1,
    dcc_0 => dcc_1);    

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

  tram : entity work.gene_trames PORT MAP (
    -- input --
    clk_100 =>clk_100 ,
    reset =>reset ,
    bouton_g => bouton_g ,
    bouton_validation =>bouton_validation ,
    bouton_d =>bouton_d ,
    bouton_h =>bouton_h ,
    bouton_b =>bouton_b ,
    switch0 =>switch0 ,
    switch1 =>switch1 ,
    switch2 =>switch2 ,
    switch3 =>switch3 ,
    switch4 =>switch4 ,
    switch5 =>switch5 ,
    switch6 =>switch6 ,
    switch7 =>switch7,
    switch8 =>switch8,
    switch9 =>switch9,
    switch10 =>switch10,
    switch11 =>switch11,
    switch12 =>switch12,
    switch13 =>switch13,
    -- output --
    trame_dcc => trame_dcc ,
    led_f0 => led_f0 ,
    led_f1 =>led_f1 ,
    led_f2 => led_f2 ,
    led_f11=> led_f11 ,
    led_f12=> led_f12
  );  
    
  -- la trame est un ou logique entre la generation d'un 1 et d'un 0 
  sortie_dcc <= dcc_1 or dcc_0;

end Behavioral;
