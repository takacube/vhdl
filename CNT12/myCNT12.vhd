library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity CNT12 is
    port ( clk_in, stop, reset: in std_logic;
    count: out std_logic_vector(3 downto 0):="0001";
    up06_sig, up12_sig: out std_logic :='0');
end CNT12;

architecture RTL of CNT12 is
    signal stp_sig: std_logic := '0';
    signal count_sig: std_logic := '1';

begin
process (stop) begin
    if (stop' event and stop='0') then stp_sig <= NOT(stp_sig);
    end if;
end process;

process (clk_in, reset) begin
    if(clk_in' event and clk_in='0' and stp_sig='0') then count_sig <= '1'; count <= count + count_sig;
        if(clk_in' event and clk_in='0' and reset='0')then
            if (count="1011") then up12_sig <= '1'; up06_sig <= '1';
        elsif(count="1100") then count <= "0001"; up06_sig <= '0'; up12_sig <= '0';
            elsif (count="0101") then up06_sig <= '1'; up12_sig <= '0';
            else count_sig <= '1'; count <= count + count_sig; up12_sig <= '0'; up06_sig <= '0';
            end if;
        elsif (clk_in' event and clk_in='0' and reset='1') then up12_sig <= '0'; up06_sig <= '0'; count <= "0001";
        end if;
    end if;
    if (clk_in' event and clk_in='0' and reset='1') then count_sig <= '1'; count <= "0001";
    end if;
end process;

end RTL;
