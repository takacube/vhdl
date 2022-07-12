library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity peripheral_half is
    port(CLK, A, B:   in  std_logic;
         S_in, CO_in: in  std_logic;
	 A_out,B_out: out std_logic;
	 LED0, LED1, LED2, LED3 : out std_logic_vector(6 downto 0));
end peripheral_half;

architecture RTL of peripheral_half is
  component chattering
    port (CLK,SW_in: in  std_logic;
          SW_out:    out std_logic );
  end component;
  component Bit_7segLED
    port(sin: in  std_logic;
	 seg: out std_logic_vector(6 downto 0));
  end component;
  
  signal a_chat, b_chat: std_logic;
  signal s_sig, co_sig:  std_logic;

begin
  CHT_A : chattering  port map (CLK, A, a_chat);
  CHT_B : chattering  port map (CLK, B, b_chat);
  A_out  <=  a_chat;
  B_out  <=  b_chat;
  DECD0:  Bit_7segLED port map (sin => S_in,   seg => LED0 ); 
  DECD1:  Bit_7segLED port map (sin => CO_in,  seg => LED1 ); 
  DECD2:  Bit_7segLED port map (sin => a_chat, seg => LED2 ); 
  DECD3:  Bit_7segLED port map (sin => b_chat, seg => LED3 ); 
end RTL;


--chattering --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity chattering is 
  port (CLK, SW_in : in  std_logic;
        SW_out :     out std_logic );
end chattering;

architecture RTL of chattering is
  signal counter:        std_logic_vector(11 downto 0);
  signal sampling, sig : std_logic;

begin
  process(clk) begin
  if(clk'event and clk='1') then
    if (counter(11)='1') then  sampling <= '0';  counter  <= counter + '1';
    else  counter  <= counter + '1';  sampling <= '1';
    end if;
  end if; 
  end process;

  process(sampling) begin
    if(sampling'event and sampling='1') then sig <= SW_in;
    end if;
  end process;
  SW_out <= sig;
end RTL;

--decoder
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Bit_7segLED is 
  port( sin : in  std_logic;
        seg : out std_logic_vector(6 downto 0));
end Bit_7segLED;

architecture RTL of Bit_7segLED is  begin  
  process(sin)  begin
    case sin is
		when '0'    => seg <="1000000"; -- 0
		when '1'    => seg <="1111001"; -- 1
		when others => seg <="1111111";
	 end case;
  end process;
end RTL;

