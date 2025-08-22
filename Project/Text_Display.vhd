
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
entity disp_write is 
    Port ( clk : in std_logic; 
     lcd_e        : out std_logic; 
     lcd_rs       : out std_logic; 
     lcd_rw       : out std_logic; 
     lcd_db       : out std_logic_vector(7 downto 0); 
     btn_right : in std_logic; 
     btn_select: in std_logic; 
     btn_left : in std_logic; 
     start_state_out : out std_logic_vector(2 downto 0) 
     ); 
end disp_write; 
 
architecture Behavioral of disp_write is 
 
COMPONENT lcd_controller IS 
   Port( 
   clk        : in    std_logic;  --system clock 
   reset_n    : in    std_logic;  --active low reinitializes lcd 
   rw, rs, e  : out   std_logic;  --read/write, setup/data, and enable for lcd 
   lcd_data   : out   std_logic_vector(7 downto 0); --data signals for lcd 
   line1_buffer : in std_logic_vector(127 downto 0); -- Data for the top line of the LCD 
   line2_buffer : in std_logic_vector(127 downto 0)); -- Data for the bottom line of the 
LCD 
 end component; 
  
 signal top_line : std_logic_vector(127 downto 0); 
 signal bottom_line : std_logic_vector(127 downto 0); 
    signal text_state : std_logic_vector(2 downto 0) := "000"; 
    signal start_state : INTEGER := 0; 
    signal count_disp : INTEGER RANGE 0 TO (100000000 * 10) := 0; 
    signal count_rst : INTEGER RANGE 0 TO 50000000 := 0;   
    signal rst : std_logic := '0'; 
     
     
begin 
 
Disptext: lcd_controller port map( 
 clk => clk, 
 reset_n => rst, 
 e => lcd_e, 
 rs => lcd_rs, 
 rw => lcd_rw, 
 lcd_data => lcd_db, 
 line1_buffer => top_line, 
 line2_buffer => bottom_line  
); 
 
process(clk,btn_right,btn_left) 
    variable debounce_count : integer:= 0; 
    variable debounce_limit : integer:= 50; 
begin 
    if rising_edge(clk) then 
        if start_state = 0 then 
          if btn_right = '1' or btn_left = '1' or btn_select = '1' then 
              if debounce_count <= debounce_limit then 
                  debounce_count := debounce_count +1; 
              end if; 
          else 
              if debounce_count > 0 then 
                  debounce_count := 0; 
              end if; 
          end if; 
          if debounce_count = debounce_limit then 
            if btn_right = '1' then-- right button menu transitions 
                case text_state is 
                    when "000" => 
                        text_state <= "001"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "001" => 
                        text_state <= "010"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "010" => 
                        text_state <= "011"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "011" => 
                        text_state <= "100"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "100" => 
                        text_state <= "101"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "101" => 
                        text_state <= "110"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "110" => 
                        text_state <= "111"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "111" => 
                        text_state <= "001"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when others => 
                        text_state <= "000"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                  end case; 
             
                  
            elsif btn_left = '1' then --left button menu transitions 
                case text_state is 
                    when "000" => 
                        text_state <= "111"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "111" => 
                        text_state <= "110"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "110" => 
                        text_state <= "101"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "101" => 
                        text_state <= "100"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "100" => 
                        text_state <= "011"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "011" => 
                        text_state <= "010"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "010" => 
                        text_state <= "001"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when "001" => 
                        text_state <= "111"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                    when others => 
                        text_state <= "000"; 
                        rst <= '1'; 
                        count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
                  end case; 
            elsif btn_select = '1' then -- confirm / select button action 
                start_state <= 1; 
                rst <= '1'; 
                count_rst <= count_rst +1; 
                        if count_rst = 50000000 then 
                            rst <= '0'; 
                        end if; 
            else start_state <= 0; 
            end if; 
          elsif btn_right = '0' and btn_left = '0' and btn_select = '0' then --beverage menu 
                case text_state is 
                    when "000" => 
                        top_line    <= x"20202020434F434B5441494C20202020"; -- COCKTAIL      
                        bottom_line <= x"204D414348494E452062792042534B20"; -- MACHINE by BSK 
                    when "001" => 
                        top_line    <= x"20204F72616E6765204A756963652020"; -- Orange Juice      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT 
                    when "010" => 
                        top_line    <=  x"50696E656170706C65204A7569636520"; -- Pineapple Juice      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT 
                    when "011" => 
                        top_line    <= x"2020436865727279204A756963652020"; -- Cherry Juice      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT         
                    when "100" => 
                        top_line    <= x"4F72616E67652D50696E656170706C65"; -- Orange-Pineapple      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT 
                    when "101" => 
                        top_line    <= x"204F72616E67652D4368657272792020"; -- Orange-Cherry      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT 
                    when "110" => 
                        top_line    <= x"50696E656170706C652D436865727279"; -- Pineapple-Cherry      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT 
                    when "111" => 
                        top_line    <= x"20204D697820436F636B7461696C2020"; -- Mix Cocktail      
                        bottom_line <= x"202020202053454C4543542020202020"; -- SELECT  
                end case; 
            end if; 
        elsif start_state = 1 then -- Beverage preparation screen 
          if text_state = "001" then 
            start_state_out <= "001";--s_a 
            top_line <=    x"202020507265706172696E6720202020"; -- Preparing      
            bottom_line <= x"20506C6561736520576169742E2E2E20"; -- Please Wait... 
            count_disp <= count_disp +1; 
            if count_disp = (100000000 * 10) then 
               text_state <= "000"; 
               start_state_out <= "000"; 
               start_state<= 0; 
               count_disp <= 0;  
            end if; 
                
          elsif text_state = "010" then 
            start_state_out <= "010";--s_b 
            top_line <=    x"202020507265706172696E6720202020"; -- Preparing      
            bottom_line <= x"20506C6561736520576169742E2E2E20"; -- Please Wait... 
            count_disp <= count_disp +1; 
            if count_disp = (100000000 * 10) then 
               text_state <= "000"; 
               start_state_out <= "000"; 
               start_state<= 0; 
               count_disp <= 0; 

                           end if; 
          elsif text_state = "110" then 
            start_state_out <= "110";--s_e 
            top_line <=    x"202020507265706172696E6720202020"; -- Preparing      
            bottom_line <= x"20506C6561736520576169742E2E2E20"; -- Please Wait... 
            count_disp <= count_disp +1; 
            if count_disp = (100000000 * 5) then 
               text_state <= "000"; 
               start_state_out <= "000"; 
               start_state<= 0; 
               count_disp <= 0;  
            end if; 
          elsif text_state = "111" then 
            start_state_out <= "111";--s_g 
            top_line <=    x"202020507265706172696E6720202020"; -- Preparing      
            bottom_line <= x"20506C6561736520576169742E2E2E20"; -- Please Wait... 
            count_disp <= count_disp +1; 
            if count_disp = (100000000 * 3) then 
               text_state <= "000"; 
               start_state_out <= "000"; 
               start_state<= 0; 
               count_disp <= 0; 
            end if; 
          else 
            start_state_out <= "000"; 
            count_disp <= 0; 
            text_state <= "000"; 
          end if;         
        end if;  
      end if; 
end process; 
end Behavioral;  