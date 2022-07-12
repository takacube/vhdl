--full adder
library IEEE;
use IEEE.std_logic_1164.all;
entity full_adder is port(A,B,CIN : in std_logic;
    S,CO: out std_logic);
end full_adder;
architecture RTL of full_adder is
    component half_adder port(A,B : in std_logic;
    S,CO: out std_logic);
    end component;

    signal sig1, sig2, sig3 : std_logic;

    begin
        H1: half_adder port map (A,B,sig2,sig1);
        H2: half_adder port map (sig2, CIN, S, sig3);
        CO <= sig1 or sig3;
end RTL;