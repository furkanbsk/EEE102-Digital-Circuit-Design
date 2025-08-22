
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
entity main is 
Port (  
           clk             : in std_logic; 
           sensor          : in std_logic; 
           p1_pin1         : out std_logic; 
           p1_pin2         : out std_logic; 
           p2_pin1         : out std_logic; 
           p2_pin2         : out std_logic; 
           p3_pin1         : out std_logic; 
           p3_pin2         : out std_logic; 
           pump_out_1      : out std_logic; ------  
           pump_out_2      : out std_logic; -- Just to observe pump state on Basys led's 
           pump_out_3      : out std_logic; ------ 
           buton_right     : in std_logic; 
           buton_select    : in std_logic; 
           buton_left      : in std_logic; 
           lcd_e           : out std_logic; 
           lcd_rs          : out std_logic; 
           lcd_rw          : out std_logic; 
           lcd_db          : out std_logic_vector(7 downto 0) 
);                      
            
end main; 
 
architecture Behavioral of main is 
 
 
COMPONENT disp_write IS 
   PORT( 
           clk            : in std_logic; 
     lcd_e          : out std_logic; 
     lcd_rs         : out std_logic; 
     lcd_rw         : out std_logic; 
     lcd_db         : out std_logic_vector(7 downto 0); 
     btn_right      : in std_logic; 
     btn_select     : in std_logic; 
     btn_left       : in std_logic; 
     start_state_out : out std_logic_vector(2 downto 0) 
     ); 
 END COMPONENT; 
  
  
 
COMPONENT pump_driver IS 
    Port ( clk : in STD_LOGIC; 
           reset : in STD_LOGIC; 
           p1_pin1 : out STD_LOGIC; 
           p1_pin2 : out STD_LOGIC; 
           p2_pin1 : out STD_LOGIC; 
           p2_pin2 : out STD_LOGIC; 
           p3_pin1 : out STD_LOGIC; 
           p3_pin2 : out STD_LOGIC; 
           pump_out_1 : out STD_LOGIC; 
           pump_out_2 : out STD_LOGIC; 
           pump_out_3 : out STD_LOGIC; 
           S_A : in std_logic; 
           S_B : in std_logic; 
           S_C : in std_logic; 
           S_D : in std_logic; 
           S_E : in std_logic; 
           S_F : in std_logic; 
           S_G : in std_logic 
            
);            
end COMPONENT; 
    signal state_a, state_b, state_c, state_d, state_e, state_f, state_g : std_logic; 
    signal start_state_outt : std_logic_vector(2 downto 0) :="000";  
    signal count : INTEGER RANGE 0 TO 50000000 := 0; 
begin 
 
Display: disp_write port map( 
 clk            => clk, 
 lcd_e          => lcd_e, 
 lcd_rs         => lcd_rs, 
 lcd_rw         => lcd_rw, 
 lcd_db         => lcd_db, 
 btn_right      => buton_right, 
 btn_select     => buton_select, 
 btn_left       => buton_left, 
 start_state_out => start_state_outt 
); 
 
 
 
Pumps: pump_driver port map( 
clk           =>  clk       , 
reset         =>  sensor , 
p1_pin1       =>  p1_pin1   , 
p1_pin2       =>  p1_pin2   , 
p2_pin1       =>  p2_pin1   , 
p2_pin2       =>  p2_pin2   , 
p3_pin1       =>  p3_pin1   , 
p3_pin2       =>  p3_pin2   , 
pump_out_1    =>  pump_out_1, 
pump_out_2    =>  pump_out_2, 
pump_out_3    =>  pump_out_3, 
S_A           =>  state_a       , 
S_B           =>  state_b       , 
S_C           =>  state_c       , 
S_D           =>  state_d       , 
S_E           =>  state_e       , 
S_F           =>  state_f       , 
S_G           =>  state_g        
); 
  
process(clk, buton_select) 
begin 
    if rising_edge(clk) then 
        if start_state_outt = "000" then -- Pump State Activation 
            count <= 0; 
            state_a <= '0'; 
            state_b <= '0'; 
            state_c <= '0'; 
            state_d <= '0'; 
            state_e <= '0'; 
            state_f <= '0'; 
            state_g <= '0'; 
        elsif start_state_outt = "001" then -- State A (S_A) Activation 
            state_a <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_a <= '0'; 
            end if; 
        elsif start_state_outt = "010" then -- State B (S_B) Activation 
            state_b <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_b <= '0'; 
            end if; 
        elsif start_state_outt = "011" then -- State C (S_C) Activation 
            state_c <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_c <= '0'; 
            end if; 
        elsif start_state_outt = "100" then -- State D (S_D) Activation 
            state_d <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_d <= '0'; 
            end if; 
        elsif start_state_outt = "101" then -- State E (S_E) Activation 
            state_e <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_e <= '0'; 
            end if; 
        elsif start_state_outt = "110" then -- State F (S_F) Activation 
            state_f <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_f <= '0'; 
            end if; 
        elsif start_state_outt = "111" then -- State G (S_G) Activation 
            state_g <= '1'; 
            count <= count +1; 
            if count = 50000000 then 
                state_g <= '0'; 
            end if; 
        end if; 
    end if; 
end process; 
    
 
end Behavioral; 