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

architecture Behavioral of sha256 is
    --some helper functions to help declutter the FSM syntax
    FUNCTION chHelp(eArg, fArg, gArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return (eArg and fArg) xor ((not eArg) and gArg);
    END FUNCTION;

    FUNCTION majHelp(aArg, bArg, cArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return (aArg and bArg) xor (aArg and cArg) xor (bArg and cArg);
    END FUNCTION;

    FUNCTION s0Help(m15Arg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(m15Arg,7)
             xor rotate_right(m15Arg,18)
             xor shift_right(m15Arg,3);
    END FUNCTION;

    FUNCTION s1Help(m2Arg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(m2Arg,17)
             xor rotate_right(m2Arg,19)
             xor shift_right(m2Arg,10);
    END FUNCTION;

    FUNCTION big_S0Help(aArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(aArg,2)
             xor rotate_right(aArg,13)
             xor rotate_right(aArg,22);
    END FUNCTION;

    FUNCTION big_S1Help(eArg : unsigned(31 DOWNTO 0)) RETURN unsigned IS
    begin
        return rotate_right(eArg,6)
             xor rotate_right(eArg,11)
             xor rotate_right(eArg,25);
    END FUNCTION;

    type state_type is (
        READY,
        ADD1PADAPPENDLENGTH,
        RESETHASHES,
        MSGSCHEDULESTART,
        MSGSCHEDULEINITWAIT,
        MSGSCHEDULELOOP,
        SETLETTERS,
        COMPRESSIONLOOP,
        MODIFYCONCAT
    );

    signal PS, NS : state_type := READY;
    type chunkType is array (63 downto 0) of unsigned(7 downto 0);
    type words64_32 is array (63 downto 0) of unsigned(31 downto 0);

    --these are the fractional parts of the square roots of the first 8 primes
    constant h0_orig : unsigned(31 downto 0) := x"6a09e667";
    constant h1_orig : unsigned(31 downto 0) := x"bb67ae85";
    constant h2_orig : unsigned(31 downto 0) := x"3c6ef372";
    constant h3_orig : unsigned(31 downto 0) := x"a54ff53a";
    constant h4_orig : unsigned(31 downto 0) := x"510e527f";
    constant h5_orig : unsigned(31 downto 0) := x"9b05688c";
    constant h6_orig : unsigned(31 downto 0) := x"1f83d9ab";
    constant h7_orig : unsigned(31 downto 0) := x"5be0cd19";
    --these are the fractional parts of the cube roots of the first 64 primes
    constant roundConstants : words64_32 := (x"428a2f98",x"71374491",x"b5c0fbcf",x"e9b5dba5",x"3956c25b",x"59f111f1",x"923f82a4",x"ab1c5ed5",x"d807aa98",x"12835b01",x"243185be",x"550c7dc3",x"72be5d74",x"80deb1fe",x"9bdc06a7",x"c19bf174",x"e49b69c1",x"efbe4786",x"0fc19dc6",x"240ca1cc",x"2de92c6f",x"4a7484aa",x"5cb0a9dc",x"76f988da",x"983e5152",x"a831c66d",x"b00327c8",x"bf597fc7",x"c6e00bf3",x"d5a79147",x"06ca6351",x"14292967",x"27b70a85",x"2e1b2138",x"4d2c6dfc",x"53380d13",x"650a7354",x"766a0abb",x"81c2c92e",x"92722c85",x"a2bfe8a1",x"a81a664b",x"c24b8b70",x"c76c51a3",x"d192e819",x"d6990624",x"f40e3585",x"106aa070",x"19a4c116",x"1e376c08",x"2748774c",x"34b0bcb5",x"391c0cb3",x"4ed8aa4a",x"5b9cca4f",x"682e6ff3",x"748f82ee",x"78a5636f",x"84c87814",x"8cc70208",x"90befffa",x"a4506ceb",x"bef9a3f7",x"c67178f2");

    signal chunk : chunkType := (others => x"00");
    signal messageSchedule : words64_32 := (others => x"00000000");
    signal h0,h1,h2,h3,h4,h5,h6,h7 : unsigned(31 downto 0);
    signal a,b,c,d,e,f,g,h : unsigned(31 downto 0);
    signal msgScheduleIter : integer range 0 to 63 := 16;
    signal compressionIter : integer range 0 to 63 := 0;
    signal outputIntermediate : std_logic_vector(255 downto 0);
    signal plaintext_bytes : integer range 0 to 55;
    --I received output from a large language model, ChatGPT, that implementing button bounce detection may help with my issues
    --I do not believe that this is the case, but I have kept it here to show that I tried many avenues to fixing the issues here
    --I was advised to query a large language model by Professor Bernard Yett.  I would not have done so otherwise.
    signal btn0_d : std_logic := '0';
    signal btn0_rise : std_logic := '0';

begin

    plaintext_bytes <= to_integer(bits_used) / 8;
    --I was received output from a large language model indicating that splitting my operations into 3 processes would be beneficial
    --and prevent the using of stale information.  I have tried several avenues to making my hash outputs resemble those of SHA256
    process(clk)
    begin
        if rising_edge(clk) then
            btn0_rise <= btn0 and not btn0_d;
            btn0_d <= btn0;
        end if;
    end process;
    
    process(
        PS,
        btn0_rise,
        msgScheduleIter,
        compressionIter
    )
    begin
        --I realize this syntax is different from that which Professor Yett helped me assemble
        --I have jumbled around my code in an effort to have this component work
        NS <= PS;
        case PS is
            when READY =>
                if btn0_rise = '1' then
                    NS <= ADD1PADAPPENDLENGTH;
                end if;
            when ADD1PADAPPENDLENGTH =>
                NS <= RESETHASHES;
            when RESETHASHES =>
                NS <= MSGSCHEDULESTART;
            when MSGSCHEDULESTART =>
                NS <= MSGSCHEDULEINITWAIT;
            --I received advision from a large language model, ChatGPT, to include this waiting state
            --In order to allow values to update
            when MSGSCHEDULEINITWAIT =>
                NS <= MSGSCHEDULELOOP;
            when MSGSCHEDULELOOP =>
                if msgScheduleIter = 63 then
                    NS <= SETLETTERS;
                else
                    NS <= MSGSCHEDULELOOP;
                end if;
            when SETLETTERS =>
                NS <= COMPRESSIONLOOP;
            when COMPRESSIONLOOP =>
                if compressionIter = 63 then
                    NS <= MODIFYCONCAT;
                else
                    NS <= COMPRESSIONLOOP;
                end if;
            when MODIFYCONCAT =>
                NS <= READY;
        end case;
    end process;

    process(clk, reset)
        --variables for compression stage
        variable s0 : unsigned(31 downto 0);
        variable s1 : unsigned(31 downto 0);
        variable big_S0 : unsigned(31 downto 0);
        variable big_S1 : unsigned(31 downto 0);
        variable ch : unsigned(31 downto 0);
        variable maj : unsigned(31 downto 0);
        variable temp1 : unsigned(31 downto 0);
        variable temp2 : unsigned(31 downto 0);
        --variables for making sure letters are assigned properly within the process
        --rather than only updating in the next run
        variable new_a : unsigned(31 downto 0);
        variable new_b : unsigned(31 downto 0);
        variable new_c : unsigned(31 downto 0);
        variable new_d : unsigned(31 downto 0);
        variable new_e : unsigned(31 downto 0);
        variable new_f : unsigned(31 downto 0);
        variable new_g : unsigned(31 downto 0);
        variable new_h : unsigned(31 downto 0);
        --variables for making sure hashes are assigned properly within the process
        --rather than using stale values
        variable final_h0 : unsigned(31 downto 0);
        variable final_h1 : unsigned(31 downto 0);
        variable final_h2 : unsigned(31 downto 0);
        variable final_h3 : unsigned(31 downto 0);
        variable final_h4 : unsigned(31 downto 0);
        variable final_h5 : unsigned(31 downto 0);
        variable final_h6 : unsigned(31 downto 0);
        variable final_h7 : unsigned(31 downto 0);
    begin
        if reset = '1' then
            PS <= READY;
            --fills chunk and message schedule with all 0's
            chunk <= (others => x"00");
            messageSchedule <= (others => x"00000000");
            --resets all the working hash and letter values for transfer between state runnings
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
            --resets iterators for completionism
            msgScheduleIter <= 16;
            compressionIter <= 0;
            --responsible for output-zeroing behavior
            outputIntermediate <= (others => '0');
        elsif rising_edge(clk) then
            PS <= NS;
            case PS is
                when ADD1PADAPPENDLENGTH =>
                    for i in 0 to 63 loop
                        chunk(i) <= x"00";
                    end loop;

                    for i in 0 to 54 loop
                        if i < plaintext_bytes then
                            chunk(i) <= unsigned(
                                --copies the plaintext, possibly incorrectly
                                --though this should work properly with the index reversal in crypto_head.vhd
                                plaintext((i+1)*8-1 downto i*8)
                            );
                        elsif i = plaintext_bytes then
                            chunk(i) <= x"80";--appendation of 1
                        else
                            chunk(i) <= x"00";--pure padding
                        end if;
                    end loop;

                    for i in 56 to 63 loop
                        chunk(i) <= bits_used(63-(8*(i-56)) downto 56-(8*(i-56)));
                    end loop;
                when RESETHASHES =>
                    h0 <= h0_orig;
                    h1 <= h1_orig;
                    h2 <= h2_orig;
                    h3 <= h3_orig;
                    h4 <= h4_orig;
                    h5 <= h5_orig;
                    h6 <= h6_orig;
                    h7 <= h7_orig;
                when MSGSCHEDULESTART =>
                    for i in 0 to 63 loop
                        messageSchedule(i) <= (others => '0');
                    end loop;

                    for i in 0 to 15 loop
                        messageSchedule(i) <= chunk(i*4+3) & chunk(i*4+2) & chunk(i*4+1) & chunk(i*4);
                        --messageSchedule(i) <= chunk(i*4) & chunk(i*4+1) & chunk(i*4+2) & chunk(i*4+3);
                    end loop;
                    --resets msgScheduleIter again, just in case
                    --this is very paranoid
                    msgScheduleIter <= 16;
                when MSGSCHEDULELOOP =>
                    s0 := s0Help(messageSchedule(msgScheduleIter-15));
                    s1 := s1Help(messageSchedule(msgScheduleIter-2));

                    messageSchedule(msgScheduleIter) <= messageSchedule(msgScheduleIter-16) + s0 + messageSchedule(msgScheduleIter-7) + s1;

                    if msgScheduleIter < 63 then
                        msgScheduleIter <= msgScheduleIter + 1;
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
                    --resets compressionIter even though it is reset in its definition and in the resetting
                    compressionIter <= 0;
                when COMPRESSIONLOOP =>
                    big_S1 := big_S1Help(e);
                    ch := chHelp(e,f,g);
                    temp1 := h + big_S1 + ch + roundConstants(compressionIter) + messageSchedule(compressionIter);
                    big_S0 := big_S0Help(a);
                    maj := majHelp(a,b,c);
                    temp2 := big_S0 + maj;
                    
                    new_h := g;
                    new_g := f;
                    new_f := e;
                    new_e := d + temp1;
                    new_d := c;
                    new_c := b;
                    new_b := a;
                    new_a := temp1 + temp2;
                
                    h <= new_h;
                    g <= new_g;
                    f <= new_f;
                    e <= new_e;
                    d <= new_d;
                    c <= new_c;
                    b <= new_b;
                    a <= new_a;
                
                    if compressionIter < 63 then
                        compressionIter <= compressionIter + 1;
                    end if;
                when MODIFYCONCAT =>

                    final_h0 := h0 + a;
                    final_h1 := h1 + b;
                    final_h2 := h2 + c;
                    final_h3 := h3 + d;
                    final_h4 := h4 + e;
                    final_h5 := h5 + f;
                    final_h6 := h6 + g;
                    final_h7 := h7 + h;
                    
                    h0 <= final_h0;
                    h1 <= final_h1;
                    h2 <= final_h2;
                    h3 <= final_h3;
                    h4 <= final_h4;
                    h5 <= final_h5;
                    h6 <= final_h6;
                    h7 <= final_h7;
                    
                    outputIntermediate <= std_logic_vector(final_h0) & std_logic_vector(final_h1) & std_logic_vector(final_h2) & std_logic_vector(final_h3) & std_logic_vector(final_h4) & std_logic_vector(final_h5) & std_logic_vector(final_h6) & std_logic_vector(final_h7);
                when others =>
                    null;
            end case;
        end if;
    end process;
    hash_output <= outputIntermediate;
end Behavioral;