LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY crypto_head IS
    PORT (
        CLK100MHZ : IN STD_LOGIC; -- system clock
        btnl : IN STD_LOGIC;
        PS2_DATA : in std_logic;
        PS2_CLK : in std_logic;
        btnr : IN STD_LOGIC;
        btn0 : IN STD_LOGIC;
        AN : OUT STD_LOGIC_VECTOR (7 DOWNTO 0); -- anodes of four 7-seg displays
        SEG : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        DP : OUT STD_LOGIC;
        UART_TXD  : OUT STD_LOGIC;
        VGA_R : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- VGA outputs
        VGA_G : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        VGA_B : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        VGA_HS : OUT STD_LOGIC;
        VGA_VS : OUT STD_LOGIC
    ); 
END crypto_head;

ARCHITECTURE Behavioral OF crypto_head IS
    SIGNAL pxl_clk : STD_LOGIC := '0'; -- 25 MHz clock to VGA sync module
    -- internal signals to connect modules
    SIGNAL S_red, S_green, S_blue : STD_LOGIC; --_VECTOR (3 DOWNTO 0);
    SIGNAL S_vsync : STD_LOGIC;
    SIGNAL S_pixel_row, S_pixel_col : STD_LOGIC_VECTOR (10 DOWNTO 0);
    --SIGNAL batpos : STD_LOGIC_VECTOR (10 DOWNTO 0); -- 9 downto 0
    SIGNAL count : STD_LOGIC_VECTOR (20 DOWNTO 0);
    SIGNAL display : std_logic_vector (15 DOWNTO 0); -- value to be displayed
    --SIGNAL led_mpx : STD_LOGIC_VECTOR (2 DOWNTO 0); -- 7-seg multiplexing clock
    --signal current_score : std_logic_vector (3 downto 0); -- added by Manley
    signal plaintext_signal : std_logic_vector (31 downto 0);
    signal plaintext_signal_to_hash : std_logic_vector (439 downto 0);
    signal hash_signal : std_logic_vector (255 downto 0);
    
    
    COMPONENT clk_wiz_0 is
        PORT (
            clk_in1  : in std_logic;
            clk_out1 : out std_logic
        );
    END COMPONENT;
--    COMPONENT leddec16 IS
--        PORT (
--            dig : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
--            data : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
--            anode : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
--            seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
--        );
--    END COMPONENT; 
    COMPONENT sha256 IS
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
    END COMPONENT;
  component top is 
    port (
      CLK100MHZ : in std_logic;
    PS2_CLK : in std_logic;
    PS2_DATA:in std_logic;
    SEG : out std_logic_vector(6 downto 0);
    AN  : out std_logic_vector(7 downto 0);
    DP : out std_logic;
    keycodeout2 : out std_logic_vector(31 downto 0);
    UART_TXD : out std_logic
    );
    end component;
    COMPONENT vga_output_top is
--  Port ( );
    PORT (
        plaintext: IN std_logic_vector (439 downto 0);
        hash: IN std_logic_vector (255 downto 0);
        -- Clock input from board oscillator
        pxl_clk : IN STD_LOGIC; -- 100 MHz system clock
        
        -- VGA display outputs (4-bit color depth for 4096 colors)
        VGA_Red : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);   -- Red color channel
        VGA_Green : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- Green color channel
        VGA_Blue : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);  -- Blue color channel
        VGA_HSync : OUT STD_LOGIC;  -- Horizontal sync signal
        VGA_VSync : OUT STD_LOGIC -- Vertical sync signal
    );
    END COMPONENT;
BEGIN

topmod : top port map (
    CLK100MHZ=>pxl_clk, 
    PS2_CLK=>PS2_CLK,
    PS2_DATA=>PS2_DATA,
    SEG=>SEG,
    AN=>AN,
    DP=>DP,
    keycodeout2=>plaintext_signal,
    UART_TXD=>UART_TXD
    );
    --VGA_vsync <= S_vsync; --connect output vsync
    plaintext_signal_to_hash <= plaintext_signal & x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    
    clk_wiz_0_inst : clk_wiz_0
    port map (
      clk_in1 => CLK100MHZ,
      clk_out1 => pxl_clk
    );
--    clk_wiz_0_inst_keyboard : clk_wiz_0
--    port map (
--      clk_in1 => clk_in,
--      clk_out1 => pxl_clk
--    );
    sha256_module : sha256
    port map (
        clk => pxl_clk,
        reset => btnr,
        plaintext => plaintext_signal_to_hash,
        bits_used => to_unsigned(32,64),
        btn0 => btn0,
        hash_output => hash_signal
    );
    vga_top : vga_output_top
    port map (
        plaintext => plaintext_signal_to_hash,
        hash => hash_signal,
        pxl_clk => pxl_clk,
        VGA_Red => VGA_R,
        VGA_Green => VGA_G,
        VGA_Blue => VGA_B,
        VGA_HSync => VGA_HS,
        VGA_VSync => VGA_VS
    );
END Behavioral;
