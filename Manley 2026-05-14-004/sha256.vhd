LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
--USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--SHA256: secure hashing algorithm with 256 bit output
--based off: https://www.boot.dev/blog/computer-science/how-sha-2-works-step-by-step-sha-256/
ENTITY sha256 IS
    PORT (
        clk : IN STD_LOGIC; -- system clock
        -- right button btnr: reset
        reset : IN STD_LOGIC;
        --step 1
        -- 512-64-8 = 440 bits
        plaintext : in std_logic_vector(439 downto 0);
        --bit length of message: where message ends and padding starts
        bits_used : in unsigned(63 downto 0);
        --decides when is set
        btn0 : IN STD_LOGIC;
        --btnr : IN STD_LOGIC;
        --SEG7_anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); -- anodes of four 7-seg displays
        --SEG7_seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        -- hash output: 8 bitstrings appended each 8 bits long
        hash_output : out std_logic_vector(255 downto 0)
    ); 
END sha256;

ARCHITECTURE Behavioral OF sha256 IS
    signal plaintext_length : integer range 0 to 63;
    --step 1 preproecessing first
    type chunkType is array (63 downto 0) of unsigned(7 downto 0);
    signal chunk : chunkType := (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00");
    --first 32 bits of fractional parts of the sqrts of the fist 8 primes
    --step 2
    constant h0_orig : unsigned(31 downto 0) := x"6a09e667";
    constant h1_orig : unsigned(31 downto 0) := x"bb67ae85";
    constant h2_orig : unsigned(31 downto 0) := x"3c6ef372";
    constant h3_orig : unsigned(31 downto 0) := x"a54ff53a";
    constant h4_orig : unsigned(31 downto 0) := x"510e527f";
    constant h5_orig : unsigned(31 downto 0) := x"9b05688c";
    constant h6_orig : unsigned(31 downto 0) := x"1f83d9ab";
    constant h7_orig : unsigned(31 downto 0) := x"5be0cd19";
    
    signal h0 : unsigned(31 downto 0);
    signal h1 : unsigned(31 downto 0);
    signal h2 : unsigned(31 downto 0);
    signal h3 : unsigned(31 downto 0);
    signal h4 : unsigned(31 downto 0);
    signal h5 : unsigned(31 downto 0);
    signal h6 : unsigned(31 downto 0);
    signal h7 : unsigned(31 downto 0);
    
    signal a : unsigned(31 downto 0);
    signal b : unsigned(31 downto 0);
    signal c : unsigned(31 downto 0);
    signal d : unsigned(31 downto 0);
    signal e : unsigned(31 downto 0);
    signal f : unsigned(31 downto 0);
    signal g : unsigned(31 downto 0);
    signal h : unsigned(31 downto 0);
    
    --first 32 bits of fractional parts cube roots of the first 32 primes
    --step 3
    type words64_32 is array (63 downto 0) of unsigned(31 downto 0);
    constant roundConstants : words64_32 := (x"428a2f98",x"71374491",x"b5c0fbcf",x"e9b5dba5",x"3956c25b",x"59f111f1",x"923f82a4",x"ab1c5ed5",x"d807aa98",x"12835b01",x"243185be",x"550c7dc3",x"72be5d74",x"80deb1fe",x"9bdc06a7",x"c19bf174",x"e49b69c1",x"efbe4786",x"0fc19dc6",x"240ca1cc",x"2de92c6f",x"4a7484aa",x"5cb0a9dc",x"76f988da",x"983e5152",x"a831c66d",x"b00327c8",x"bf597fc7",x"c6e00bf3",x"d5a79147",x"06ca6351",x"14292967",x"27b70a85",x"2e1b2138",x"4d2c6dfc",x"53380d13",x"650a7354",x"766a0abb",x"81c2c92e",x"92722c85",x"a2bfe8a1",x"a81a664b",x"c24b8b70",x"c76c51a3",x"d192e819",x"d6990624",x"f40e3585",x"106aa070",x"19a4c116",x"1e376c08",x"2748774c",x"34b0bcb5",x"391c0cb3",x"4ed8aa4a",x"5b9cca4f",x"682e6ff3",x"748f82ee",x"78a5636f",x"84c87814",x"8cc70208",x"90befffa",x"a4506ceb",x"bef9a3f7",x"c67178f2");
    --type outputType is array (63 downto 0) of std_logic_vector(31 downto 0);
    --type messageScheduleType is array (15 downto 0) of std_logic_vector(31 downto 0);
    --signal messageSchedule : words64_32 := (x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00",x"00");
    signal messageSchedule : words64_32 := (others => x"00000000");
    --step 8
    signal outputIntermediate : std_logic_vector(255 downto 0) := x"0000000000000000000000000000000000000000000000000000000000000000";
    
    type state_type is (READY, ADD1PADAPPENDLENGTH, RESETHASHES, MSGSCHEDULESTART, MSGSCHEDULELOOP, SETLETTERS, COMPRESSIONLOOP, MODIFYCONCAT, STATERESET);
    signal PS : state_type := READY;
    signal NS : state_type := READY;
    --6 bits, 63 values: 0 to 63
    signal msgScheduleIter : integer range 0 to 63 := 16; --starts at 16
    signal compressionIter : integer range 0 to 63 := 0; --start at 0
    --signal btn0_pressed : std_logic := '0';
    
    --some helper functions because my FSM definition is extremely cluttered
    --ch := (e and f) xor ((not e) and g);
    FUNCTION chHelp(eArg, fArg, gArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return (eArg and fArg) xor ((not eArg) and gArg);
    END FUNCTION;
    --maj := (a and b) xor (a and c) xor (b and c);
    FUNCTION majHelp(aArg, bArg, cArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return (aArg and bArg) xor (aArg and cArg) xor (bArg and cArg);
    END FUNCTION;
    --s0 := unsigned(m15_7 xor m15_18 xor m15_3);
    FUNCTION s0Help(m15Arg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(m15Arg,7) xor rotate_right(m15Arg,18) xor shift_right(m15Arg,3);
    END FUNCTION;
    --s1 := unsigned(m2_17 XOR m2_19 XOR m2_10);
    FUNCTION s1Help(m2Arg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(m2Arg,17) xor rotate_right(m2Arg,19) xor shift_right(m2Arg,10);
    END FUNCTION;
    --big_S0 := rotate_right(a, 2) xor rotate_right(a, 13) xor rotate_right(a, 22);
    FUNCTION big_S0Help(aArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(aArg,2) xor rotate_right(aArg,13) xor rotate_right(aArg,22);
    END FUNCTION;
    --big_S1 := rotate_right(e, 6) xor rotate_right(e, 11) xor rotate_right(e, 25);
    FUNCTION big_S1Help(eArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(eArg,6) xor rotate_right(eArg,11) xor rotate_right(eArg,25);
    END FUNCTION;
BEGIN
--type state_type is (READY, ADD1PADAPPENDLENGTH, RESETHASHES, MSGSCHEDULESTART, 
--MSGSCHEDULELOOP, SETLETTERS, COMPRESSIONLOOP, MODIFYCONCAT);
    clockAndReset: process(CLK, RESET)
    begin
        if (RESET = '1') then PS <= STATERESET;
        elsif (rising_edge(CLK)) then PS <= NS;
        end if;
    end process clockAndReset;
    plaintext_length <= 4;
    stateAndOutputLogic : process(PS,btn0)
        --variable numBitsUsed : std_logic_vector(63 downto 0);
        variable s0 : unsigned(31 downto 0);
        variable s1 : unsigned(31 downto 0);
        variable m16: unsigned(31 downto 0);
        variable m15: unsigned(31 downto 0);
--        variable m15_7: std_logic_vector(31 downto 0);
--        variable m15_18: std_logic_vector(31 downto 0);
--        variable m15_3: std_logic_vector(31 downto 0);
        variable m7: unsigned(31 downto 0);
        variable m2: unsigned(31 downto 0);
--        variable m2_17: std_logic_vector(31 downto 0);
--        variable m2_19: std_logic_vector(31 downto 0);
--        variable m2_10: std_logic_vector(31 downto 0);
        --variable zeros : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
        variable big_S0 : unsigned(31 downto 0);
        variable big_S1 : unsigned(31 downto 0);
        variable ch : unsigned(31 downto 0);
        variable temp1 : unsigned(31 downto 0);
        variable maj : unsigned(31 downto 0);
        variable temp2 : unsigned(31 downto 0);
        
        variable h0_to_set : std_logic_vector(31 downto 0);
        variable h1_to_set : std_logic_vector(31 downto 0);
        variable h2_to_set : std_logic_vector(31 downto 0);
        variable h3_to_set : std_logic_vector(31 downto 0);
        variable h4_to_set : std_logic_vector(31 downto 0);
        variable h5_to_set : std_logic_vector(31 downto 0);
        variable h6_to_set : std_logic_vector(31 downto 0);
        variable h7_to_set : std_logic_vector(31 downto 0);
    begin         
            case PS is
                when STATERESET =>
                     NS <= READY;
            
                        h0 <= (others => '0');
                        h1 <= (others => '0');
                        h2 <= (others => '0');
                        h3 <= (others => '0');
                        h4 <= (others => '0');
                        h5 <= (others => '0');
                        h6 <= (others => '0');
                        h7 <= (others => '0');
                    
                        a <= (others => '0');
                        b <= (others => '0');
                        c <= (others => '0');
                        d <= (others => '0');
                        e <= (others => '0');
                        f <= (others => '0');
                        g <= (others => '0');
                        h <= (others => '0');
                    
                        msgScheduleIter <= 16;
                        compressionIter <= 0;
                    
                        outputIntermediate <= (others => '0');
                    
                        messageSchedule <= (others => x"00000000");
                when READY =>
                    if btn0 = '1' then 
                        NS <= ADD1PADAPPENDLENGTH;
                    end if;
                    --PS <= ADD1PADAPPENDLENGTH;
                --step 1
                when ADD1PADAPPENDLENGTH =>
                    --take in plaintext : in std_logic_vector(440 downto 0);
                    --assumes that the message in only 55 characters long
                    for i in 0 to 54 loop
                        if i < plaintext_length then
                            chunk(i) <= unsigned(plaintext((i+1)*8-1 downto i*8));
                        elsif i = plaintext_length then
                            chunk(i) <= x"80";--leading 1
                        else
                            chunk(i) <= x"00";--pure padding
                        end if;
                    end loop;
                    --numBitsUsed := std_logic_vector(bits_used);
                    --chunk(63) <= numBitsUsed;
                    for i in 56 to 63 loop
                        --chunk(i) <= numBitsUsed(56-(8*(i-56))+7 downto 56-(8*(i-56)));
                        chunk(i) <= bits_used(63-(8*(i-56)) downto 56-(8*(i-56)));
                    end loop;
                    NS <= RESETHASHES;
                when RESETHASHES =>
                    h0 <= h0_orig;
                    h1 <= h1_orig;
                    h2 <= h2_orig;
                    h3 <= h3_orig;
                    h4 <= h4_orig;
                    h5 <= h5_orig;
                    h6 <= h6_orig;
                    h7 <= h7_orig;
                    NS <= MSGSCHEDULESTART;
                when MSGSCHEDULESTART =>
--                    for i in 0 to 63 loop
--                        messageSchedule(i) <= x"00000000";
--                    end loop;
                    messageSchedule <= (others => x"00000000");
                    --messageSchedule <= (x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000",x"00000000");
                    for i in 0 to 15 loop--loads the 16 32-bit words
                        messageSchedule(i) <= chunk(i*4) & chunk(i*4+1) & chunk(i*4+2) & chunk(i*4+3);
                    end loop;
                    msgScheduleIter <= 16;
                    NS <= MSGSCHEDULELOOP;
                when MSGSCHEDULELOOP =>
                    --s0 := conv_unsigned((messageSchedule(msgScheduleIter-15) ror 7));
                    --messageSchedule(msgScheduleIter) <= (unsigned(messageSchedule(msgScheduleIter-16)) + s0 + unsigned(messageSchedule(msgScheduleIter-7)) + s1);
                    m16 := messageSchedule(msgScheduleIter-16);
                    m7 := messageSchedule(msgScheduleIter-7);
                    
                    m15 := messageSchedule(msgScheduleIter-15);
                    m2 := messageSchedule(msgScheduleIter-2);
                    
--                    m15_7 := std_logic_vector(rotate_right(unsigned(m15), 7));
--                    m15_18 := std_logic_vector(rotate_right(unsigned(m15), 18));
--                    m15_3 := std_logic_vector(shift_right(unsigned(m15), 3));
                    
--                    m2_17 := std_logic_vector(rotate_right(unsigned(m2), 17));
--                    m2_19 := std_logic_vector(rotate_right(unsigned(m2), 19));
--                    m2_10 := std_logic_vector(shift_right(unsigned(m2), 10));
                    
--                    s0 := unsigned(m15_7 xor m15_18 xor m15_3);
--                    s1 := unsigned(m2_17 XOR m2_19 XOR m2_10);
                    s0 := s0Help(m15);
                    s1 := s1Help(m2);
                    
                    messageSchedule(msgScheduleIter) <= m16 + s0 + m7 + s1;
                     
                    if msgScheduleIter = 63 then NS <= SETLETTERS;
                    else msgScheduleIter <= msgScheduleIter + 1;
                    end if;
                when SETLETTERS =>
                    a <= h0;
                    b <= h1;
                    c <= h2;
                    d <= h3;
                    e <= h4;
                    f <= h5;
                    g <= h6;
                    h <= h7;
                    
                    compressionIter <= 0;
                    NS <= COMPRESSIONLOOP;
                when COMPRESSIONLOOP =>
                    --mutates the values of a...h
--                    big_S1 := rotate_right(e, 6) xor rotate_right(e, 11) xor rotate_right(e, 25);
                    big_S1 := big_S1Help(e);
--                    ch := (e and f) xor ((not e) and g);
                    ch := chHelp(e,f,g);
--                    temp1 := h + big_S1 + ch + unsigned(roundConstants(compressionIter)) + unsigned(messageSchedule(compressionIter));
                    temp1 := h + big_S1 + ch + (roundConstants(compressionIter)) + (messageSchedule(compressionIter));
--                    big_S0 := rotate_right(a, 2) xor rotate_right(a, 13) xor rotate_right(a, 22);
                    big_S0 := big_S0Help(a);
--                    maj := (a and b) xor (a and c) xor (b and c);
                    maj := majHelp(a,b,c);
--                    temp2 := big_S0 + maj;
                    temp2 := big_S0 + maj;
                    
                    h <= g;
                    g <= f;
                    f <= e;
                    e <= d + temp1;
                    d <= c;
                    c <= b;
                    b <= a;
                    a <= temp1 + temp2;
                     
                    if compressionIter = 63 then NS <= MODIFYCONCAT;
                    else compressionIter <= compressionIter + 1;
                    end if;
                when MODIFYCONCAT =>
--                    h0_to_set := std_logic_vector((h0) + a);
--                    h1_to_set := std_logic_vector((h1) + b);
--                    h2_to_set := std_logic_vector((h2) + c);
--                    h3_to_set := std_logic_vector((h3) + d);
--                    h4_to_set := std_logic_vector((h4) + e);
--                    h5_to_set := std_logic_vector((h5) + f);
--                    h6_to_set := std_logic_vector((h6) + g);
--                    h7_to_set := std_logic_vector((h7) + h);
                    
                    outputIntermediate <= std_logic_vector((h0) + a) & std_logic_vector((h1) + b) & std_logic_vector((h2) + c) & std_logic_vector((h3) + d) & std_logic_vector((h4) + e) & std_logic_vector((h5) + f) & std_logic_vector((h6) + g) & std_logic_vector((h7) + h);
                    
--                    h0 <= h0 + a;
--                    h1 <= h1 + b;
--                    h2 <= h2 + c;
--                    h3 <= h3 + d;
--                    h4 <= h4 + e;
--                    h5 <= h5 + f;
--                    h6 <= h6 + g;
--                    h7 <= h7 + g;
                    
                    NS <= READY;
            end case;
    end process stateAndOutputLogic;
    
    hash_output <= outputIntermediate;--x"abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcd
END Behavioral;