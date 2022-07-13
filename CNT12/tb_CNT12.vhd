library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity tb_CNT12 is
end    tb_CNT12;

architecture SIM of tb_CNT12 is
    component CNT12
        port(clk_in, reset, stop: in std_logic;
			up06_sig, up12_sig: out std_logic;
                        count: out std_logic_vector(3 downto 0));
    end component;

    signal clk_in: std_logic :='1';
    signal reset: std_logic :='1';
    signal stop,up06_sig, up12_sig: std_logic :='0';
    signal count:  std_logic_vector(3 downto 0);
begin
    DUT: CNT12 port map(clk_in,reset,stop,up06_sig, up12_sig, count);

process begin
    wait for 1.0 us; clk_in <= NOT(clk_in);
end process;

process begin
    wait for 5.7 us; stop <= '0'; wait for 1.0 us; stop <= '1'; wait for 4.8 us; stop <= '0'; wait for 1.0 us; stop <= '1'; wait for 24.5 us;
    assert false severity failure;
    end process;

process begin
    wait for 2.8 us; reset <= '1'; wait for 1.0 us; reset <= '0'; wait for 3.9 us; reset <= '1'; wait for 1.4 us; reset <= '0'; wait for 27.9 us;
    assert false severity failure;
    end process;
end SIM;


configuration cfg_tb_CNT12 of tb_CNT12 is
    for SIM
    end for;
end cfg_tb_CNT12;