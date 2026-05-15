library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Top component
entity top is 
port(
    CLK100MHZ : in std_logic;
    PS2_CLK : in std_logic;
    PS2_DATA:in std_logic;
    SEG : out std_logic_vector(6 downto 0);
    AN  : out std_logic_vector(7 downto 0);
    DP : out std_logic;
    keycodeout2 : out std_logic_vector(31 downto 0);
   UART_TXD : out std_logic
  --  keycode : out std_logic_vector(31 downto 0)
);
end entity top;
--Addition
-- Keyboard component

architecture top_arc of top is 

component clk_wiz_0_clk_wiz is 
port(
clk_in1 :in std_logic;
clk_out1: out std_logic
);
end component;

component seg7display is
port (
x : in std_logic_vector(31 downto 0);
clk : in std_logic;
SEG : out std_logic_vector(6 downto 0);
AN : out std_logic_vector (7 downto 0);
DP : out std_logic
);
end component;

component ps2receiver is 
port (
clk : in std_logic;
kclk : in std_logic;
kdata :in std_logic;
keycodeout : out std_logic_vector(31 downto 0)
);

end component;
signal clocksignal : std_logic;
signal keycode_signal : std_logic_vector(31 downto 0);
begin 
clock : clk_wiz_0_clk_wiz port map (clk_in1=>clk100mhz, clk_out1=>clocksignal);
keyboard : ps2receiver port map (clk=>clocksignal, kclk=>PS2_CLK, kdata=>PS2_DATA, keycodeout=>keycode_signal);
display : seg7display port map (x=>keycode_signal,clk=>clk100mhz,DP=>DP,AN=>AN,SEG=>SEG);
keycodeout2<=keycode_signal;
end top_arc; 
