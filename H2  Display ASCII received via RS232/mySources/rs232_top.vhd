----------------------------------------------------------------------------------
-- Top design module 
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity top_rs232 is
    port ( 
        clk, reset, rx: in std_logic;
		led: out std_logic_vector(7 downto 0)
        );
end top_rs232;

architecture arch of top_rs232 is
    signal tick1, tick2: std_logic;  
    signal dout, led_reg, led_nxt: std_logic_vector(7 downto 0);

----------------------------------------------------------------------------------
begin

-- modulus counter
    module1: entity work.mod_m_counter(arch)
        port map (  clk=>clk, reset=>reset, 
                    max_tick => tick1, q => open );

-- UART 
    module2: entity work.uart_rx(arch)
        port map (  clk=>clk, reset=>reset, s_tick=>tick1,
        rx=>rx, rx_done_tick=>tick2, dout=>dout );
					
-- other statements at the top level
   process(clk,reset)
   begin
      if (reset='1') then
         led_reg <= (others=>'0');
      elsif (clk'event and clk='1') then
         led_reg <= led_nxt;
      end if;
   end process;
   
   led_nxt <= dout when tick2='1' else led_reg;
   led <= led_reg;
    
end arch;