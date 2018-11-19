library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gene_trames_tb is

end gene_trames_tb;


architecture Behavioral of gene_trames_tb is

  ---input---
  signal clk_100 : STD_LOGIC :='0';
  signal reset : STD_LOGIC :='1';
  signal bouton_g : STD_LOGIC :='0';	---bouton gauche	E stop
  signal bouton_validation : STD_LOGIC :='0';    ---bouton central VALIDATION
  signal bouton_d : STD_LOGIC :='0';    ---bouton droit	   step 28
  signal bouton_h : STD_LOGIC :='0';    ---bouton haut     stop
  signal bouton_b : STD_LOGIC :='0';    ---bouton bas      step 14
  signal switch0 : STD_LOGIC :='0';   ---switch 0 f0
  signal switch1 : STD_LOGIC :='0';   ---switch 1 f1
  signal switch2 : STD_LOGIC :='0';   ---switch 2 f2
  signal switch3 : STD_LOGIC :='0';   ---switch 3 f8
  signal switch4 : STD_LOGIC :='0';  ---switch 4 f11
  signal switch5 : STD_LOGIC :='0';  ---switch 5 f13
  signal switch6 : STD_LOGIC :='0';  ---switch 6 f15
  signal switch7 : STD_LOGIC :='0';   ---switch 7 Choic train 1 ou 2
  signal switch8 : STD_LOGIC :='0';
  signal switch9 : STD_LOGIC :='0';
  signal switch10 : STD_LOGIC :='0';
  signal switch11 : STD_LOGIC :='0';
  signal switch12 : STD_LOGIC :='0';


  --output---
  signal trame_dcc : STD_LOGIC_VECTOR (50 downto 0); ---- signal de sortie
  signal led_f0 : STD_LOGIC;	  ---led 0
  signal led_f1 : STD_LOGIC;	  ---led 1
  signal led_f2 :   STD_LOGIC;	  ---led 2

  signal led_f11 :   STD_LOGIC;   ---led 11 alumé = train 1 éteind = train 2
  signal led_f12 :   STD_LOGIC  ;   ---led 11 alumé = train marche avant / éteind = train marche arrière

  begin

    tram : entity work.gene_trames PORT MAP (
    ---input---
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


    ---output---
    trame_dcc => trame_dcc ,
    led_f0 => led_f0 ,
    led_f1 =>led_f1 ,
    led_f2 => led_f2 ,
    led_f11=> led_f11 ,
    led_f12=> led_f12 );


    -- entrees
    clk_100 <= not clk_100 after 5 ns;
    reset <= '1', '0' after 500 ns;
    bouton_g<= '1' after 1 us, '0' after 2 us;
    bouton_validation <= '1' after 500 ns;
    bouton_d <= '1' after 2 us, '0' after 3 us;
    bouton_h <= not bouton_h after 1 us;
    bouton_b <= not bouton_b after 3 us;
    switch0 <= '1' after 4 us, '0' after 6 us;
    switch1 <= '1' after 7 us, '0' after 8 us;
    switch2 <= '1' after 9 us, '0' after 11 us;
    switch3 <= '1' after 4 us, '0' after 5 us;
    switch4 <= '1' after 5 us, '0' after 6 us;
    switch5 <= '1' after 7 us, '0' after 8 us;
    switch6 <= '1' after 9 us, '0' after 10 us;
    switch11 <= not switch11 after 1.3 us;
    switch12 <= '1' after 500 ns;

  end Behavioral;
