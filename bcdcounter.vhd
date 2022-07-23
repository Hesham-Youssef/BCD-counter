library IEEE;
use IEEE.std_logic_1164.all;

entity t_ff is
  port(
     clk : in STD_LOGIC;
     t : in STD_LOGIC;
     reset : in STD_LOGIC;
     qout : out STD_LOGIC;
     qin : in STD_LOGIC);
end t_ff;

architecture t_ff_arc of t_ff is    
  signal qout_i : STD_LOGIC := qin;
begin

tff : process (clk,reset) is
begin
    if (reset='1') then
        qout_i <= '0';
    elsif (rising_edge (clk)) then
        qout_i <= t xor qout_i;
    end if;
end process tff;

qout <= qout_i;

end t_ff_arc;

library IEEE;
use IEEE.std_logic_1164.all;
library work;

entity eoz is
port(
	clk : in STD_LOGIC;
    x : in STD_LOGIC;
    reset  : in STD_LOGIC;
    counter: out STD_LOGIC_VECTOR(3 downto 0);
    initial : in STD_LOGIC_VECTOR(3 downto 0));
end eoz;
architecture hesh of eoz is    
begin
eq0: entity work.t_ff port map(clk,not counter(3) or counter(0) or (not counter(2) and not counter(1)),reset,counter(0),initial(0));
eq1: entity work.t_ff port map(clk,(counter(1) and counter(3)) or (counter(0) and not x and not counter(3)) or (not counter(0) and x and (counter(1) or (counter(2) xor counter(3)))),reset,counter(1),initial(1));
eq2: entity work.t_ff port map(clk,(counter(0) and counter(1) and not x and not counter(3)) or (x and not counter(0) and not counter(1) and (counter(2) or counter(3))) or (counter(2) and counter(3)),reset,counter(2),initial(2));
eq3: entity work.t_ff port map(clk,(counter(0) and (counter(3) or (counter(1) and counter(2))) and not x) or (not counter(0) and not counter(1) and not counter(2) and x) or (counter(3) and (counter(1) or counter(2))),reset,counter(3),initial(3));

end hesh;
