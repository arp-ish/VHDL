-- USN VHDL 101 course
-- template for test bench development
-- author | date

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_multiplier is
end tb_top_multiplier;

architecture tb of tb_top_multiplier is

    component top_multiplier
        port (clk, rst : in std_logic;
              din_A, din_B   : in std_logic_vector(3 downto 0);
              dout   : out std_logic_vector(7 downto 0)
			  );
    end component;

    signal clk, rst : std_logic;
    signal din_A, din_B   : std_logic_vector(3 downto 0); -- module inputs
    signal dout   : std_logic_vector(7 downto 0); -- module outputs

    constant clk_period : time := 10 ns;

begin

    uut : top_multiplier
    port map (clk => clk, rst => rst,
              din_A => din_A, din_B => din_B,
              dout => dout);

clk_process: process 
   begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
   end process;

-- Stimuli process 
   stim_proc: process
      begin
         din_A <= "0010";
		 din_B <= "0110";
         rst <= '1';      
         wait for clk_period;
         rst <= '0';      
         wait for clk_period*25;        
      end process ;

end tb;
