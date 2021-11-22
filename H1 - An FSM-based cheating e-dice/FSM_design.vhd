-- USN VHDL 101 course
-- template for FSM development
-- author | date

library ieee;
use ieee.std_logic_1164.all;

entity _name_ is
   port ( clk, rst, _din1_, _din2_, ...: in std_logic;
          _dout1_, _dout2_, ...: out std_logic
	    );
end _name_;

architecture arch of _name_ is
type state is (S0, S1, S2, ...);
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
process (prest, _din_, _din_, ...)
begin
   nxtst <= prest; -- stay in current state by default

   case prest is
      when S0 =>
         if _condition_ then nxtst <= _st_;
            else nxtst <= _st_; -- unnecessary if the same
         end if;
      when S1 =>
         if _condition_ then nxtst <= _st_;
            else nxtst <= _st_;
         end if;

      ...

         end if;
   end case;
end process;

-- Moore outputs logic
process (prest)
begin
   case prest is 
      when _st_ | _st_ | _st_ | ... =>  
         _dout_ <= '0';
      when _st_ | _st_ | ... =>
         _dout_ <= '1'; 
   end case;
end process;
       
-- Mealy outputs logic 
process (prest, _din_, _din_, ...)
begin
   case prest is 
      when _st_ =>
         if _condition_ then 
            _dout_ <= '0';
         else
            _dout_ <= '1';
      when _st_ =>
         if _condition_ then 
            _dout_ <= '0';
         else
            _dout_ <= '1';
      ...

   end case;
end process;

end arch;










