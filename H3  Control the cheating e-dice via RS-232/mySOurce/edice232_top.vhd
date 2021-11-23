----------------------------------------------------------------------------------
-- Top design module 
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity top_edice232 is
    port ( 
        clk, reset, rx: in std_logic;
		seg: out std_logic_vector(7 downto 0);
		an: out std_logic_vector(3 downto 0)
        );
end top_edice232;

architecture arch of top_edice232 is
    signal tick1, tick2, cheat, run: std_logic;  
    signal R: std_logic_vector(2 downto 0);
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

-- ASCII decoder 
    module3: entity work.ascii_dec(Behavioral)
        port map (  clk=>clk, rst=>reset, ascii_in=>dout, 
        rx_done_tick=>tick2, R=>R, cheat=>cheat, run=>run );
        
-- e-dice 
    module4: entity work.edice(arch)
        port map (  clk=>clk, rst=>reset, cheat=>cheat,
        run=>run, R=>R, an=>an, led=>seg );
                					

    
end arch;