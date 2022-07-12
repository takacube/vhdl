--half_adder
library IEEE;
use IEEE.std_logic_1164.all;
entity half_adder is
 port( A, B : in std_logic;
 S, CO : out std_logic );
end half_adder;
architecture RTL of half_adder is
 signal sig1, sig2: std_logic;
 begin
 sig1 <= A nand B;
 sig2 <= A or B;
 CO <= not sig1;
 S <= sig1 and sig2;
end RTL;
