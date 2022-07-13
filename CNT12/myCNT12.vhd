library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity CNT12 is
    port ( clk_in, stop, reset: in std_logic;
    count: out std_logic_vector(3 downto 0):="0000");
    up06_sig, up12_sig: out std_logic :='0';
end CNT12;

architecture RTL of CNT12 is
    signal stp_sig: std_logic := '0';
    signal count_sig: std_logic := '1';

begin
--stopが押されるとstp_sigをトグルする
process (stop) begin
    if (stop' event and stop='0') then stp_sig <= '1'; count_sig <= '0';
    end if;
end process;

process (clk_in, reset) begin
    --ストップボタンが押されていない時
    if(stp_sig='0') then count_sig <= '1'; count <= count + count_sig;
        --立ち下がりエッジかつ，リセットボタンが押されていない
        if(clk_in' event and clk_in='0' and reset='0')then
            if (count="1100") then up12_sig <= '1'; up06_sig <= '1';
            elsif (count="0110") then up06_sig <= '1'; up12_sig <= '0';
            elsif (count="1101") then count <= "0000";
            --countが6でも12でもないときはただcountを足すだけで出力は0となる
            else count_sig <= '1'; count <= count + count_sig; up12_sig <= '0'; up06_sig <= '0';
            end if;
        elsif (clk_in' event and clk_in='0' and reset='1') then up12_sig <= '0'; up06_sig <= '0'; count <= "0001";
        end if;
    end if;
end process;

end RTL;