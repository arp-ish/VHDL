-- USN VHDL 101 course
-- template for FSM development
-- author | date

library ieee;
use ieee.std_logic_1164.all;

entity edice is
   port (   clk, rst, cheat, run: in std_logic;
            R: in std_logic_vector(2 downto 0);
            an: out std_logic_vector(3 downto 0);
            led: out std_logic_vector(7 downto 0)
	    );
end edice;

architecture arch of edice is
type state is (S0, S1, S2, S3, S4, S5, S6, S7);
signal prest, nxtst: state;  -- present state, next state

begin
-- state register
process (clk, rst)
begin
   if (rst = '1') then
	  prest <= S0; -- initial state
   elsif rising_edge(clk) then
	  prest <= nxtst;
   end if;
end process;

-- next-state logic
process (prest, R, cheat, run)
begin
   nxtst <= prest; -- stay in current state by default

   case prest is
      when S0 =>
         if run='1' then nxtst <= S1;
         end if;
      when S1 =>
         if run='1' then nxtst <= S2;
         end if;
      when S2 =>
         if run='1' then nxtst <= S3;
         end if;
      when S3 =>
         if run='1' then nxtst <= S4;
         end if;
      when S4 =>
         if run='1' then nxtst <= S5;
         end if;
      when S5 =>
         if ((run='1' and cheat='0') or (run='1' and cheat='1' and (R="000" or R="111"))) then nxtst <= S0;
         elsif ((run='1' and cheat='1') and (R/="000" and R/="111")) then nxtst <= S6;
         end if;
      when S6 =>
         if run='1' then nxtst <= S7;
         end if;
      when S7 =>
         if run='1' then nxtst <= S0;
         end if;
   end case;
end process;

process (prest)
begin
   case prest is 
      when S0 =>  
         led <= "10011111"; -- 1
      when S1 =>  
         led <= "00100101"; -- 2
      when S2 =>  
         led <= "00001101"; -- 3
      when S3 =>  
         led <= "10011001"; -- 4
      when S4 =>  
         led <= "01001001"; -- 5         
      when S5 =>  
         led <= "01000001"; -- 6
      when S6 =>  
        if R="001" then led<="10011111";
        elsif R="010" then led<="00100101";
        elsif R="011" then led<="00001101";
        elsif R="100" then led<="10011001";
        elsif R="101" then led<="01001001";
        else led<="01000001";
        end if;
      when S7 =>  
        if R="001" then led<="10011111";
        elsif R="010" then led<="00100101";
        elsif R="011" then led<="00001101";
        elsif R="100" then led<="10011001";
        elsif R="101" then led<="01001001";
        else led<="01000001";
        end if;        
   end case;
end process;

an <= "0110";
       
end arch;










