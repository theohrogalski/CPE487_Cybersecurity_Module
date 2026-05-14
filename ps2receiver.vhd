library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
entity PS2RECEIVER is port(
clk : in std_logic;
kclk : in std_logic;
kdata :in std_logic;
keycodeout : out std_logic_vector(31 downto 0)

);
end PS2receiver;

architecture keyboard of PS2RECEIVER is 
    signal datacur : std_logic_vector(7 downto 0);
    signal dataprev : std_logic_vector(7 downto 0);   
    signal keycode :std_logic_vector(31 downto 0):=X"00000000";
    signal flag : std_logic:='0';
    begin
process(kclk)
variable cnt : integer:=0;
variable release : integer :=1;
begin 
if falling_edge(kclk) then
    case(cnt) is
    when 0 =>
    cnt := cnt+1;
    when 1 => 
    datacur(0)<=kdata;
    cnt:=cnt+1;

    when 2 => 
    datacur(1)<=kdata;    
        cnt:=cnt+1;

    when 3 => 
    datacur(2)<=kdata;
        cnt:=cnt+1;

    when 4 =>
     datacur(3)<=kdata;
         cnt:=cnt+1;

    when 5 =>
     datacur(4)<=kdata;    
     cnt:=cnt+1;

    when 6 => 
    datacur(5)<=kdata;
        cnt:=cnt+1;

    when 7 => 
    datacur(6)<=kdata;
        cnt:=cnt+1;

    when 8 => 
    datacur(7)<=kdata;
        cnt:=cnt+1;

    when 9 => 
    if release /= 0 then release := release - 1;
    end if;
    if datacur = x"f0" then 
     release:=2;
    end if;
    
    if release = 0 then
    
        dataprev <= datacur;
        keycode <=  keycode(23 downto 0) & datacur;
    
    end if;
    cnt:=cnt+1;
    when 10 => 
    cnt := 0;
    
    when others => null;
    end case;
    end if;
end process;

keycodeout<=keycode;
 
end keyboard;
