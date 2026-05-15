library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seg7display is  port(
 x : in std_logic_vector(31 downto 0);
clk : in std_logic;
SEG : out std_logic_vector(6 downto 0);
AN : out std_logic_vector (7 downto 0);
dp : out std_logic
);
end entity;

architecture behavioral of seg7display is 

signal s : std_logic_vector(2 downto 0);
signal aen : std_logic_vector(7 downto 0):="11111111";
signal clkdiv : std_logic_vector(19 downto 0) := "00000000000000000000";

begin 

dp<='1';
s<=clkdiv(19 downto 17);

process(clk)
begin
if rising_edge(clk) then 
clkdiv <= clkdiv+1;
end if;
end process;

process(clk) 
variable digit : std_logic_vector(3 downto 0);

begin
if rising_edge(clk) then
case(s) is
when "000" => 
digit:=x(3 downto 0);
when "001" =>
digit:=x(7 downto 4);

when "010" =>
digit:=x(11 downto 8);

when "011" =>
digit:=x(15 downto 12);

when "100" =>
digit:=x(19 downto 16);

when "101" =>
digit:=x(23 downto 20);

when "110" =>
digit:=x(27 downto 24);

when "111" =>
digit:=x(31 downto 28);

when others =>
digit:=x(3 downto 0);
end case;
case(digit) is 
when x"0" =>
SEG<="1000000";
when x"1" =>
SEG<="1111001";

when x"2" =>
SEG<="0100100";

when x"3" =>
SEG<="0110000";

when x"4" =>
SEG<="0011001";
when x"5" =>
SEG<="0010010";
when x"6" =>
SEG<="0000010";
when x"7" =>
SEG<="1111000";
when x"8" =>
SEG<="0000000";
when x"9" =>
SEG<="0010000";
when x"A" =>
SEG<="0001000";
when x"B" =>
SEG<="0000011";
when x"C" =>
SEG<="1000110";
when x"D" =>
SEG<="0100001";
when x"E" =>
SEG<="0000110";
when x"F" =>
SEG<="0001110";
when others => SEG<="0000000";
end case;
end if;
end process;


process(s)
begin
AN<="11111111";
if aen(conv_integer(unsigned(s))) = '1' then
AN(conv_integer(unsigned(s)))<='0';
end if;
end process;
end architecture;
