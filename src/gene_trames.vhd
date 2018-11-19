library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gene_trames is
  Port ( clk_100 : in STD_LOGIC;
  reset : in STD_LOGIC;
  bouton_g : in  STD_LOGIC;	---bouton gauche	E stop
  bouton_validation : in  STD_LOGIC;    ---bouton central VALIDATION
  bouton_d : in  STD_LOGIC;    ---bouton droit	  stop
  bouton_h : in  STD_LOGIC;    ---bouton haut     monte la vitesse
  bouton_b : in  STD_LOGIC;    ---bouton bas      baisse la vitesse
  switch0 : in STD_LOGIC;   ---switch 0 fO à f4 active le premier groupe de fonction
  switch1 : in STD_LOGIC;   ---switch 1 f5 à f12 active le deuxième groupe de fonction
  switch2 : in STD_LOGIC;   ---switch 2 f13 à f20 active le troisième groupe de fonction

  -------------------------------------------------------f1--f2---f3
  switch3 : in STD_LOGIC;   ---switch Active la fonction 0 , 5 ou 13
  switch4 : in STD_LOGIC;  ---switch  Active la fonction 1, 6 ou 14
  switch5 : in STD_LOGIC;  ---switch  Active la fonction 2, 7 ou 15
  switch6 : in STD_LOGIC;  ---switch  Active la fonction 3, 8 ou 16
  switch7: in STD_LOGIC;   ---switch  Active la fonction 4, 9 ou 17
  switch8: in STD_LOGIC;   -------switch Active la fonction 10 ou 18
  switch9: in STD_LOGIC;   ------switch  Active la fonction 11 ou 19
  switch10: in STD_LOGIC;   ------switch Active la fonction 12 ou 20
  switch11: in STD_LOGIC;   --switch 11 Choix train 1 ou 2
  switch12: in STD_LOGIC;   --marche avant ou arriere
  switch13: in STD_LOGIC;   --choix vitesse

  trame_dcc : out STD_LOGIC_VECTOR (50 downto 0); ---- signal de sortie
  led_f0 : out  STD_LOGIC;	  ---led 0
  led_f1 : out  STD_LOGIC;	  ---led 1
  led_f2 : out  STD_LOGIC;	  ---led 2

  led_f11 : out  STD_LOGIC;   ---led 11 alume = train 1 eteind = train 2
  led_f12 : out  STD_LOGIC;   ---led 12 alume = train marche avant / eteind = train marche arriere
  led_f13 : out  STD_logic);  ---led 13 alumé = on peut modifié la vitesse


end gene_trames;

architecture Behavioral of gene_trames is
  signal tram_f1 : std_logic_vector (7 downto 0); --trame pour les fonctions du groupe 1
  signal tram_f2 : std_logic_vector (7 downto 0); --trame pour les fonctions du groupe 2
  signal tram_f3 : std_logic_vector (7 downto 0);--trame pour les fonctions du groupe 3
  signal tram_speed : std_logic_vector (7 downto 0); -- trame pour la vitesse du train
  signal cpt :integer:=0; -- pour gerer les 28 vitesses
  signal speed: std_logic_vector (4 downto 0); --permet de construire la tram_speed
  signal trame_adresse : std_logic_vector (7 downto 0); -- trame pour l'adresse du train
  signal old_trame_adresse : std_logic_vector (7 downto 0); --permet de voir si la trame d'adresse a
                                                            ---------------------------changé d'état
  signal constructeur_trame : std_logic_vector (50 downto 0); -- pour construire la tram de 50 bit

  signal bouton_val :  STD_LOGIC :='0';--permet de voir si le bouton a changé d'état
  signal bouton_validation_prev : std_logic;--permet de voir si le bouton a changé d'état
  signal bouton_val_prev : std_logic;--permet de voir si le bouton a changé d'état

  signal bouton_h_prev : std_logic;--permet de voir si le bouton a changé d'état
   signal bouton_g_prev : std_logic;--permet de voir si le bouton a changé d'état
    signal bouton_d_prev : std_logic;--permet de voir si le bouton a changé d'état
     signal bouton_b_prev : std_logic;--permet de voir si le bouton a changé d'état
  begin
-- process qui gère le bouton de validation qui sera mapper en bouton central sur la carte
bpval: process (clk_100, reset, bouton_validation)
    begin
      if reset ='1' then -- si le reset est actif alors on passes tout à '0'
            bouton_val<='0';
            bouton_val_prev <='0';
            bouton_validation_prev <= '0';
      elsif rising_edge(clk_100) then
     --on veut eviter le rebond du monton on regarde donc son état précédent
      if (bouton_validation_prev = not(bouton_validation)) then
       bouton_val <= not bouton_val;
        end if;

       bouton_validation_prev <= bouton_validation;
       end if;

end process;

-- process permettant d'activer le premier groupe de fonction
function1: process (clk_100, reset, switch0,switch3,switch4,switch5,switch6,switch7)
begin
-- en cas de reset on envoie un champ de bit signifiant que toute les fonctions du groupe 1 sont
  -- désactivé
  if reset='1' then tram_f1<="10000000"; led_f0 <='0'; 
    -- si le switch0 est actif alors on active le premier groupe de fonction
elsif (rising_edge (clk_100) and switch0='1') then
    led_f0<='1'; -- on alume la led correspondant au premier groupe de fonction
-- ici on assigne le champ de bit de la première fonction au swtich 3
    if (switch3='1') then tram_f1 <="10010000"; 
      elsif (switch4='1') then tram_f1 <="10000001"; -- idem
      elsif (switch5='1') then tram_f1 <="10000010";-- idem
      elsif (switch6='1') then tram_f1 <="10000100"; -- idem
      elsif (switch7='1') then tram_f1 <="10001000"; end if;-- idem
-- si aucun des switch n'est activé alors toutes les fonction du premier groupes sont désactivé par
      -- defaut
    elsif switch0='0' then tram_f1 <="10000000"; led_f0<='0'; 

end if;
end process;

-- process permettant d'activer le deuxième groupe de fonction le fonctionnement est identique au
-- process précédent
function2: process (clk_100, reset,
  switch1,switch3,switch4,switch5,switch6,switch7,switch8,switch9,switch10)
begin
  if reset='1' then tram_f2<="10100000"; led_f1 <='0';
    elsif (rising_edge (clk_100) and switch1='1') then
      led_f1<='1';
        if (switch3='1') then tram_f2 <="10110001";
          elsif (switch4='1') then tram_f2 <="10110010";
          elsif (switch5='1') then tram_f2 <="10110100";
          elsif (switch6='1') then tram_f2 <="10111000";
          elsif (switch7='1') then tram_f2 <="10100001";
          elsif (switch8='1') then tram_f2 <="10100010";
          elsif (switch9='1') then tram_f2 <="10100100";
          elsif (switch10='1') then tram_f2 <="10101000"; end if;
        elsif switch1='0' then tram_f2 <="10100000"; led_f1<='0';

end if;

end process;

-- process permettant d'activer le troisième groupe de fonction le fonctionnement est identique au
--process précédent
function3: process (clk_100, reset,
  switch2,switch3,switch4,switch5,switch6,switch7,switch8,switch9,switch10)
begin
  if reset='1' then tram_f3<="00000000"; led_f2 <='0';
    elsif(rising_edge (clk_100) and switch2='1') then
    led_f2<='1';
         if (switch3='1') then tram_f3 <="00000001";
      elsif (switch4='1') then tram_f3 <="00000010";
      elsif (switch5='1') then tram_f3 <="00000100";
      elsif (switch6='1') then tram_f3 <="00001000";
      elsif (switch7='1') then tram_f3 <="00010000";
      elsif (switch8='1') then tram_f3 <="00100000";
      elsif (switch9='1') then tram_f3 <="01000000";
      elsif (switch10='1') then tram_f3 <="10000000";end if;
    elsif switch2='0' then tram_f3 <="00000000"; led_f2<='0';

end if;

end process;


-- process permetant de gerer la vitesse du train et sa direction
vitesse: process (clk_100, reset, bouton_g, bouton_d,bouton_h,bouton_b,switch12,switch13) 

begin
-- en cas de reset on envoie un champ de bit signifiant que le train s'arrête par sécurité et on
  -- reset les led et le compteur
  if reset='1' then tram_speed<="01100000"; led_f12 <='0'; cpt<=0; led_f13 <='0'; 

elsif rising_edge (clk_100) then

  if switch13='1' then led_f13<='1'; --allume led13 si on active le switch 13 (modification de vitesse)
else led_f13<='0'; --extinction de la led 13 si on désactive le switch 13 

-- si on appuie sur le bouton gauche alors emergency stop (avec systeme anti rebond)
  if (bouton_g='1' and bouton_g_prev='0') then tram_speed<="01100001"; 
  -- si on appuie sur le bouton droite alors on active les freins (avec systeme anti rebond)
elsif (bouton_d='1' and bouton_d_prev='0') then tram_speed<="01100000";
  end if;

-- si on appuie sur le bouton haut alors on incrémente le compteur qui compte de 0 à 28 (avec
  -- systeme anti rebond)
  if ((bouton_h='1' and bouton_h_prev='0') and cpt < 28) then cpt<= cpt + 1;
  -- si on appuie sur le bouton bas alors on décrémente le compteur (avec systeme anti rebond)
elsif ((bouton_b='1' and bouton_b_prev='0') and cpt > 1) then cpt<=cpt-1; 
  end if;

  bouton_b_prev <= bouton_b; --permet d'avoir l'état précédent du bouton
  bouton_g_prev <= bouton_g;--permet d'avoir l'état précédent du bouton
  bouton_d_prev <= bouton_d;--permet d'avoir l'état précédent du bouton
  bouton_h_prev <= bouton_h;--permet d'avoir l'état précédent du bouton


  case cpt is -- case afin d'assigner chaque vitesse aux valeurs du compteur

    when 0 => speed<= "00001";-- stop
    when 1 => speed<= "00010";--vitesse1
    when 2 => speed<= "10010";--vitesse2
    when 3 => speed<= "00011";--vitesse3
    when 4 => speed<= "10011";--vitesse4
    when 5 => speed<= "00100";--v5
    when 6 => speed<= "10100";--v6
    when 7 => speed<= "00101";--v7
    when 8 => speed<= "10101";--v8
    when 9 => speed<= "00110";--v9
    when 10 => speed<="10110";--v10
    when 11 => speed<="00111";--v11
    when 12 => speed<="10111";--v12
    when 13 => speed<="01000";--v13
    when 14 => speed<="11000";--v14
    when 15 => speed<="01001";--v15
    when 16 => speed<="11001";--v16
    when 17 => speed<="01010";--v17
    when 18 => speed<="11010";--v18
    when 19 => speed<="01011";--v19
    when 20 => speed<="11011";--v20
    when 21 => speed<="01100";--v21
    when 22 => speed<="11100";--v22
    when 23 => speed<="01101";--v23
    when 24 => speed<="11101";--v24
    when 25 => speed<="01110";--v25
    when 26 => speed<="11110";--v26
    when 27 => speed<="01111";--v27
    when 28 => speed<="11111";--v28
    when others =>  speed<= "00001"; --stop si autre par précaution
    end case;

-- permet de faire avancer le train en marche avant
  if (switch12='1') then tram_speed <= "010" & speed; led_f12<='1';
  -- permet de faire avancer le train en marche arrière
elsif switch12 ='0' then tram_speed <= "011" & speed; led_f12<='0';
  end if;

end if;

end process;

---constructeur de trame ---

tramecreator: process (clk_100,reset,
  bouton_val,switch0,switch1,switch2,switch11,switch13,tram_speed,old_trame_adresse,trame_adresse)
begin
  if reset='1' then constructeur_trame<="000000000000000000000000000000000000000000000000000";
  trame_adresse<="00000010"; led_f11<='0'; -- en cas de reset on renvoie une trame pleine de '0' et
  ----------------------------------------on reset l'adresse à 2 ainsi que la led de choix de train
elsif (rising_edge (clk_100) and bouton_val='1') then
  old_trame_adresse<=trame_adresse;
--si switch 11 est à 1 alors on va contrôler le train 1 la led s'allume
  if (switch11='1') then trame_adresse <="00000001"; led_f11<='1';
--si switch 11 est à 0 alors on va contrôler le train 2 la led s'allume
elsif (switch11='0') then trame_adresse<="00000010"; led_f11<='0';
end if;
if switch0='1' then -- selection du premier groupe de fonction
  constructeur_trame <= "11111111111111111111111" & '0' & trame_adresse & '0' & tram_f1 & '0'&
                        (trame_adresse xor tram_f1) & '1'; -- préambule 23 bits car le chamt de
                     -- fonction ne comporte que 8 bits, on concatene tout pour former la trame DCC
elsif switch1='1' then -- selection du deuxième groupe de fonction
  constructeur_trame <= "11111111111111111111111" & '0' & trame_adresse & '0' & tram_f2 & '0'&
                        (trame_adresse xor tram_f2) & '1';  -- préambule 23 bits car le chamt de
   ---------------------fonction ne comporte que 8 bits, on concatene tout pour former la trame DCC
elsif switch13='1' then -- modification de la vitesse
  constructeur_trame <= "11111111111111111111111" & '0' & trame_adresse & '0' & tram_speed & '0'&
                        (trame_adresse xor tram_speed) & '1';  -- préambule 23 bits car le chamt de
  -----------------------vitesse ne comporte que 8 bits, on concatene tout pour former la trame DCC

elsif switch2='1' then  -- selection du troisième groupe de fonction
  constructeur_trame <= "11111111111111" & '0' & trame_adresse & '0' & "11011110" & '0' & tram_f3 &
                        '0' &(trame_adresse xor "11011110" xor tram_f3) & '1';  -- préambule 14 bits
  ------------car le champ de fonction comporte 16 bits, on concatene tout pour former la trame DCC
end if;

end if;

end process;

-- enfin on assigne le signal venant du process à la sortie trame dcc sur 51 bits
trame_dcc <= constructeur_trame;

end Behavioral;
