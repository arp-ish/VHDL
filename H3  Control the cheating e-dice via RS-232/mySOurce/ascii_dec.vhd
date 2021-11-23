
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ascii_dec is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           rx_done_tick : in STD_LOGIC;
           ascii_in : in STD_LOGIC_VECTOR (7 downto 0);
           R : out STD_LOGIC_VECTOR (2 downto 0);
           cheat : out STD_LOGIC;
           run : out STD_LOGIC);
end ascii_dec;

architecture Behavioral of ascii_dec is
signal res_reg, res_nxt: std_logic_vector(2 downto 0);
signal cheat_reg, cheat_nxt: std_logic;
signal run_reg, run_nxt: std_logic;
begin

    process(clk, rst) begin
        if rst = '1' then
            res_reg <= (others=>'0'); 
            cheat_reg <= '0';
            run_reg <= '0';
        elsif rising_edge(clk) then
            res_reg <= res_nxt;
            cheat_reg <= cheat_nxt;
            run_reg <= run_nxt;
        end if;
    end process;


res_nxt <= ascii_in(2 downto 0) when (rx_done_tick='1' and (ascii_in>=x"31" and ascii_in<=x"36")) else res_reg;
cheat_nxt <= not cheat_reg when (rx_done_tick='1' and (ascii_in=x"63" or ascii_in=x"43")) else cheat_reg;   
run_nxt <= not run_reg when (rx_done_tick='1' and ascii_in=x"20") else run_reg;        
           
R <= res_reg;
cheat <= cheat_reg;
run <= run_reg;

end Behavioral;
