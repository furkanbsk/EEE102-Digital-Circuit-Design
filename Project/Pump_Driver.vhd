library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
entity pump_driver is 
    Port ( clk : in std_logic; 
           reset : in std_logic; 
           p1_pin1 : out std_logic; 
           p1_pin2 : out std_logic; 
           p2_pin1 : out std_logic; 
           p2_pin2 : out std_logic; 
           p3_pin1 : out std_logic; 
           p3_pin2 : out std_logic; 
           pump_out_1 : out std_logic; 
           pump_out_2 : out std_logic; 
           pump_out_3 : out std_logic; 
           S_A : in std_logic;  --only p1 10 sec 
           S_B : in std_logic;  --only p2 10 sec 
           S_C : in std_logic;  --only p3 10 sec 
           S_D : in std_logic;  --p1 and p2 5 sec 
           S_E : in std_logic;  --p1 and p3 5 sec 
           S_F : in std_logic;  --p2 and p3 5 sec 
           S_G : in std_logic); --all pumps 3 sec 
end pump_driver; 
 
architecture Behavioral of pump_driver is 
    signal current_state : STD_LOGIC_VECTOR(2 downto 0) :="000";  
    signal counter : INTEGER RANGE 0 TO (100000000 * 10)  := 0; --100M clock cycles at 100MHz clock 
begin 
 
 
     
    process (clk, reset, S_A, S_B, S_C, S_D, S_E, S_F, S_G) 
    begin 
        if reset = '1' then 
            current_state <= "000"; 
            counter <= 0; 
        elsif rising_edge(clk) then 
            case current_state is 
                when "000" =>  --initial state 
                    pump_out_1 <= '0'; 
                    pump_out_2 <= '0'; 
                    pump_out_3 <= '0'; 
                    p1_pin1 <= '0'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '0'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '0'; 
                    p3_pin2 <= '0'; 
------------------------------------------------------------------------------------------------                     
                    if S_A = '1' then 
                        current_state <= "001"; 
                    elsif S_B = '1' then 
                        current_state <= "010"; 
                    elsif S_C = '1' then 
                        current_state <= "011"; 
                    elsif S_D = '1' then 
                        current_state <= "100";     --State selection 
                    elsif S_E = '1' then 
                        current_state <= "101"; 
                    elsif S_F = '1' then 
                        current_state <= "110"; 
                    elsif S_G = '1' then 
                        current_state <= "111";                 
                    end if; 
------------------------------------------------------------------------------------------------                      
                    counter <= 0; 
                --behaviour of situations   
                when "001" =>  --only p1 10 sec 
                    pump_out_1 <= '1'; 
                    pump_out_2 <= '0'; 
                    pump_out_3 <= '0'; 
                    p1_pin1 <= '1'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '0'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '0'; 
                    p3_pin2 <= '0'; 
                    counter <= counter + 1; 
                    if counter = (100000000 * 10) then 
                        current_state <= "000"; 
                    end if; 
 
                when "010" =>  --only p2 10 sec 
                    pump_out_1 <= '0'; 
                    pump_out_2 <= '1'; 
                    pump_out_3 <= '0'; 
                    p1_pin1 <= '0'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '1'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '0'; 
                    p3_pin2 <= '0'; 
                    counter <= counter + 1; 
                    if counter = (100000000 * 10) then 
                        current_state <= "000"; 
                    end if; 
 
                when "011" =>  --only p3 10 sec 
                    pump_out_1 <= '0'; 
                    pump_out_2 <= '0'; 
                    pump_out_3 <= '1'; 
                    p1_pin1 <= '0'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '0'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '1'; 
                    p3_pin2 <= '0'; 
                    counter <= counter + 1; 
                    if counter = (100000000 * 10) then 
                        current_state <= "000"; 
                    end if; 
                     
                when "100" =>  --p1 and p2 5 sec 
                    pump_out_1 <= '1'; 
                    pump_out_2 <= '1'; 
                    pump_out_3 <= '0'; 
                    p1_pin1 <= '1'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '1'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '0'; 
                    p3_pin2 <= '0'; 
                    counter <= counter + 1; 
                    if counter = (100000000 * 5) then 
                        current_state <= "000"; 
                    end if;  
                     
                when "101" =>  --p1 and p3 5 sec 
                    pump_out_1 <= '1'; 
                    pump_out_2 <= '0'; 
                    pump_out_3 <= '1'; 
                    p1_pin1 <= '1'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '0'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '1'; 
                    p3_pin2 <= '0'; 
                    counter <= counter + 1; 
                    if counter = (100000000 * 5) then 
                        current_state <= "000"; 
                    end if; 
                     
                when "110" =>  --p2 and p3 5 sec 
                    pump_out_1 <= '0'; 
                    pump_out_2 <= '1'; 
                    pump_out_3 <= '1'; 
                    p1_pin1 <= '0'; 
                    p1_pin2 <= '0'; 
                    p2_pin1 <= '1'; 
                    p2_pin2 <= '0'; 
                    p3_pin1 <= '1'; 
                    p3_pin2 <= '0'; 
                    counter <= counter + 1; 
                    if counter = (100000000 * 5) then 
                        current_state <= "000"; 
                    end if; 
                when "111" =>  --all pump 3 sec 
                   pump_out_1 <= '1'; 
                   pump_out_2 <= '1'; 
                   pump_out_3 <= '1'; 
                   p1_pin1 <= '1'; 
                   p1_pin2 <= '0'; 
                   p2_pin1 <= '1'; 
                   p2_pin2 <= '0'; 
                   p3_pin1 <= '1'; 
                   p3_pin2 <= '0'; 
                   counter <= counter + 1; 
                   if counter = (100000000 * 3) then 
                       current_state <= "000"; 
                   end if;    
                    
------------------------------------------------------------------------------------------------                      
                when others => 
                    current_state <= "000"; 
                    counter <= 0; 
            end case; 
        end if; 
    end process; 
end Behavioral;