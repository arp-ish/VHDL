----------------------------------------------------------------------------------
-- Top design module 
----------------------------------------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;

entity top_multiplier is
    port ( 
        clk, rst: in std_logic;
		din_A, din_B: in std_logic_vector(3 downto 0);
        dout:   out std_logic_vector(7 downto 0)
        );
end top_multiplier;

architecture arch of top_multiplier is
    signal zero, load, decr: std_logic;  
    signal clear, update1, update2: std_logic;
    signal adder_out, psum: std_logic_vector(7 downto 0);

----------------------------------------------------------------------------------
begin

-- down counter
    module1: entity work.counter(Behavioral)
        port map (  clk=>clk, rst=>rst, din=>din_B,
        zero=>zero, q=>open, load=>load, decr=>decr );

-- adder 
    module2: entity work.adder(Behavioral)
        port map (  din1(7 downto 4)=>"0000", din1(3 downto 0)=>din_A, 
                    din2=>psum, dout=>adder_out );
					
-- adder register
    module3: entity work.gen_reg(Behavioral)
        port map (  clk=>clk, rst=>rst, din=>adder_out,
                    clear=>clear, update=>update1, dout=>psum );
					
-- output register
    module4: entity work.gen_reg(Behavioral)
        port map (  clk=>clk, rst=>rst, din=>psum,
                    clear=>'0', update=>update2, dout=>dout );
					
-- control path
    module5: entity work.ctr_path(arch)
        port map (  clk=>clk, rst=>rst, zero=>zero, load=>load,
                    decr=>decr, clear=>clear, update1=>update1, update2=>update2 );


end arch;