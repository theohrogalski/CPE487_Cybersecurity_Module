-- ============================================================================
-- Text Display adapated from Galaga Game Logic
-- ============================================================================

-- ============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY vga_font IS
    PORT (
        -- VGA synchronization and pixel coordinates
        v_sync : IN STD_LOGIC;  -- Vertical sync pulse (60Hz) - triggers game logic updates
        pixel_row : IN STD_LOGIC_VECTOR(10 DOWNTO 0);  -- Current pixel row (0-599)
        pixel_col : IN STD_LOGIC_VECTOR(10 DOWNTO 0);  -- Current pixel column (0-799)
        
        plaintext : IN STD_LOGIC_VECTOR(439 DOWNTO 0);
        hash : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
        
        -- Color outputs (1-bit each, converted to 4-bit in top level)
        red : OUT STD_LOGIC;   -- Red color component
        green : OUT STD_LOGIC; -- Green color component
        blue : OUT STD_LOGIC  -- Blue color component
    );
END vga_font;

ARCHITECTURE Behavioral OF vga_font IS
    
    CONSTANT SPRITE_SCALE : INTEGER := 1;   -- Scale factor: 16×16 sprites rendered as 32×32
    
    SIGNAL text_on : STD_LOGIC;         

    -- Font 5x7 Definitions
    TYPE font_char IS ARRAY(0 TO 6) OF STD_LOGIC_VECTOR(4 DOWNTO 0);
    CONSTANT CHAR_A : font_char := ("01110", "10001", "10001", "11111", "10001", "10001", "10001");
    CONSTANT CHAR_B : font_char := ("11110", "10001", "10001", "11110", "10001", "10001", "11110");
    CONSTANT CHAR_C : font_char := ("11111", "10000", "10000", "10000", "10000", "10000", "11111");
    CONSTANT CHAR_D : font_char := ("11110", "10001", "10001", "10001", "10001", "10001", "11110");
    CONSTANT CHAR_E : font_char := ("11111", "10000", "10000", "11110", "10000", "10000", "11111");
    CONSTANT CHAR_F : font_char := ("11111", "10000", "10000", "11110", "10000", "10000", "10000");
    CONSTANT CHAR_G : font_char := ("01110", "10000", "10000", "10111", "10001", "10001", "01110");
    CONSTANT CHAR_H : font_char := ("10001", "10001", "10001", "11111", "10001", "10001", "10001");
    CONSTANT CHAR_I : font_char := ("01110", "00100", "00100", "00100", "00100", "00100", "01110");
    CONSTANT CHAR_J : font_char := ("00111", "00001", "00001", "00001", "10001", "10001", "01110");
    CONSTANT CHAR_K : font_char := ("10001", "10010", "10100", "11000", "10100", "10010", "10001");
    CONSTANT CHAR_L : font_char := ("10000", "10000", "10000", "10000", "10000", "10000", "11111");
    CONSTANT CHAR_M : font_char := ("10001", "11011", "10101", "10001", "10001", "10001", "10001");
    CONSTANT CHAR_N : font_char := ("10001", "11001", "10101", "10011", "10001", "10001", "10001");
    CONSTANT CHAR_O : font_char := ("01110", "10001", "10001", "10001", "10001", "10001", "01110");
    CONSTANT CHAR_P : font_char := ("11110", "10001", "10001", "11110", "10000", "10000", "10000");
    CONSTANT CHAR_Q : font_char := ("01110", "10001", "10001", "10001", "10101", "10010", "01101");
    CONSTANT CHAR_R : font_char := ("11110", "10001", "10001", "11110", "10100", "10010", "10001");
    CONSTANT CHAR_S : font_char := ("01111", "10000", "10000", "01110", "00001", "00001", "11110");
    CONSTANT CHAR_T : font_char := ("11111", "00100", "00100", "00100", "00100", "00100", "00100");
    CONSTANT CHAR_U : font_char := ("10001", "10001", "10001", "10001", "10001", "10001", "01110");
    CONSTANT CHAR_V : font_char := ("10001", "10001", "10001", "10001", "10001", "01010", "00100");
    CONSTANT CHAR_W : font_char := ("10001", "10001", "10101", "10101", "10101", "01010", "01010");
    CONSTANT CHAR_X : font_char := ("10001", "10001", "01010", "00100", "01010", "10001", "10001");
    CONSTANT CHAR_Y : font_char := ("10001", "10001", "01010", "00100", "00100", "00100", "00100");
    CONSTANT CHAR_Z : font_char := ("11111", "00001", "00010", "00100", "01000", "10000", "11111");
    CONSTANT CHAR_EX: font_char := ("00100", "00100", "00100", "00100", "00000", "00100", "00000"); -- !
    CONSTANT CHAR_SP: font_char := ("00000", "00000", "00000", "00000", "00000", "00000", "00000");
    CONSTANT CHAR_0 : font_char := ("01110", "10001", "10001", "10001", "10001", "10001", "01110");
    CONSTANT CHAR_1 : font_char := ("00100", "01100", "00100", "00100", "00100", "00100", "01110");
    CONSTANT CHAR_2 : font_char := ("01110", "10001", "00001", "00010", "00100", "01000", "11111");
    CONSTANT CHAR_3 : font_char := ("01110", "10001", "00001", "00110", "00001", "10001", "01110");
    CONSTANT CHAR_4 : font_char := ("00010", "00110", "01010", "10010", "11111", "00010", "00010");
    CONSTANT CHAR_5 : font_char := ("11111", "10000", "11110", "00001", "00001", "10001", "01110");
    CONSTANT CHAR_6 : font_char := ("01110", "10000", "10000", "11110", "10001", "10001", "01110");
    CONSTANT CHAR_7 : font_char := ("11111", "00001", "00010", "00100", "00100", "00100", "00100");
    CONSTANT CHAR_8 : font_char := ("01110", "10001", "10001", "01110", "10001", "10001", "01110");
    CONSTANT CHAR_9 : font_char := ("01110", "10001", "10001", "01111", "00001", "00001", "01110");
    CONSTANT CHAR_COLON: font_char := ("00000", "00100", "00000", "00000", "00000", "00100", "00000"); -- :
    CONSTANT CHAR_SEMICOLON: font_char := ("00000", "00100", "00000", "00000", "00000", "00100", "01000"); -- ;
    CONSTANT CHAR_PCT: font_char := ("11001", "11010", "00100", "01000", "10011", "00011", "00000"); -- %
    
    
    FUNCTION iso8859_to_font(c : STD_LOGIC_VECTOR(7 DOWNTO 0)) RETURN font_char IS
    BEGIN
    CASE c IS

        -- Numbers
        WHEN x"30" => RETURN CHAR_0;
        WHEN x"31" => RETURN CHAR_1;
        WHEN x"32" => RETURN CHAR_2;
        WHEN x"33" => RETURN CHAR_3;
        WHEN x"34" => RETURN CHAR_4;
        WHEN x"35" => RETURN CHAR_5;
        WHEN x"36" => RETURN CHAR_6;
        WHEN x"37" => RETURN CHAR_7;
        WHEN x"38" => RETURN CHAR_8;
        WHEN x"39" => RETURN CHAR_9;

        -- Uppercase letters
        WHEN x"41" => RETURN CHAR_A;
        WHEN x"42" => RETURN CHAR_B;
        WHEN x"43" => RETURN CHAR_C;
        WHEN x"44" => RETURN CHAR_D;
        WHEN x"45" => RETURN CHAR_E;
        WHEN x"46" => RETURN CHAR_F;
        WHEN x"47" => RETURN CHAR_G;
        WHEN x"48" => RETURN CHAR_H;
        WHEN x"49" => RETURN CHAR_I;
        WHEN x"4A" => RETURN CHAR_J;
        WHEN x"4B" => RETURN CHAR_K;
        WHEN x"4C" => RETURN CHAR_L;
        WHEN x"4D" => RETURN CHAR_M;
        WHEN x"4E" => RETURN CHAR_N;
        WHEN x"4F" => RETURN CHAR_O;
        WHEN x"50" => RETURN CHAR_P;
        WHEN x"51" => RETURN CHAR_Q;
        WHEN x"52" => RETURN CHAR_R;
        WHEN x"53" => RETURN CHAR_S;
        WHEN x"54" => RETURN CHAR_T;
        WHEN x"55" => RETURN CHAR_U;
        WHEN x"56" => RETURN CHAR_V;
        WHEN x"57" => RETURN CHAR_W;
        WHEN x"58" => RETURN CHAR_X;
        WHEN x"59" => RETURN CHAR_Y;
        WHEN x"5A" => RETURN CHAR_Z;

        -- Space
        WHEN x"20" => RETURN CHAR_SP;

        -- Punctuation
        WHEN x"21" => RETURN CHAR_EX;
        WHEN x"3A" => RETURN CHAR_COLON;
        WHEN x"3B" => RETURN CHAR_SEMICOLON;
        WHEN x"25" => RETURN CHAR_PCT;

        WHEN OTHERS => RETURN CHAR_SP;
        END CASE;
    END FUNCTION;
    
    FUNCTION hex_digit_to_font(c : STD_LOGIC_VECTOR(3 DOWNTO 0)) RETURN font_char IS
    BEGIN
    CASE c IS

        -- Numbers
        WHEN x"0" => RETURN CHAR_0;
        WHEN x"1" => RETURN CHAR_1;
        WHEN x"2" => RETURN CHAR_2;
        WHEN x"3" => RETURN CHAR_3;
        WHEN x"4" => RETURN CHAR_4;
        WHEN x"5" => RETURN CHAR_5;
        WHEN x"6" => RETURN CHAR_6;
        WHEN x"7" => RETURN CHAR_7;
        WHEN x"8" => RETURN CHAR_8;
        WHEN x"9" => RETURN CHAR_9;

        -- Uppercase letters
        WHEN x"a" => RETURN CHAR_A;
        WHEN x"b" => RETURN CHAR_B;
        WHEN x"c" => RETURN CHAR_C;
        WHEN x"d" => RETURN CHAR_D;
        WHEN x"e" => RETURN CHAR_E;
        WHEN x"f" => RETURN CHAR_F;
        
        WHEN OTHERS => RETURN CHAR_SP;
        END CASE;
    END FUNCTION;
    
BEGIN
    
    red <= text_on;
    green <= text_on;
    blue <= text_on;
    
    -- Process to draw text
    text_draw : PROCESS (pixel_row, pixel_col, plaintext)
        VARIABLE x_rel, y_rel : INTEGER;
        VARIABLE char_col, char_row : INTEGER;
        VARIABLE char_idx : INTEGER;
        VARIABLE bit_val : STD_LOGIC;
        CONSTANT SCALE : INTEGER := 1;
        CONSTANT CHAR_WIDTH : INTEGER := 6; -- 5 + 1 spacing
        CONSTANT CHAR_HEIGHT : INTEGER := 7;
        VARIABLE digit_tens, digit_ones : INTEGER;
        VARIABLE d1, d2, d3, d4 : INTEGER;

        VARIABLE ascii_char : STD_LOGIC_VECTOR(7 DOWNTO 0);
        VARIABLE current_font : font_char;
        
        VARIABLE hex_digit_of_char : std_logic_vector(3 downto 0);
        
        -- Helper to get bit from char
        FUNCTION get_char_bit(c : font_char; r, c_idx : INTEGER) RETURN STD_LOGIC IS
        BEGIN
            IF c_idx >= 0 AND c_idx < 5 THEN
                RETURN c(r)(4 - c_idx);
            ELSE
                RETURN '0';
            END IF;
        END FUNCTION;
        
        -- Helper to get char from digit
        FUNCTION get_digit_char(d : INTEGER) RETURN font_char IS
        BEGIN
            CASE d IS
                WHEN 0 => RETURN CHAR_0;
                WHEN 1 => RETURN CHAR_1;
                WHEN 2 => RETURN CHAR_2;
                WHEN 3 => RETURN CHAR_3;
                WHEN 4 => RETURN CHAR_4;
                WHEN 5 => RETURN CHAR_5;
                WHEN 6 => RETURN CHAR_6;
                WHEN 7 => RETURN CHAR_7;
                WHEN 8 => RETURN CHAR_8;
                WHEN 9 => RETURN CHAR_9;
                WHEN OTHERS => RETURN CHAR_0;
            END CASE;
        END FUNCTION;
      BEGIN
            text_on <= '0';
        --first row plaintext
        IF pixel_col >= 40 AND pixel_col < 40 + (55 * CHAR_WIDTH * SCALE) AND
           pixel_row >= 80 AND pixel_row < 80 + (CHAR_HEIGHT * SCALE) THEN
    
            x_rel := TO_INTEGER(UNSIGNED(pixel_col)) - 40;
            y_rel := TO_INTEGER(UNSIGNED(pixel_row)) - 80;
    
            char_idx := x_rel / (CHAR_WIDTH * SCALE);
    
            IF char_idx >= 0 AND char_idx < 55 THEN
    
                char_col := (x_rel MOD (CHAR_WIDTH * SCALE)) / SCALE;
                char_row := y_rel / SCALE;
    
                ascii_char :=
                    plaintext(439 - char_idx*8 DOWNTO 432 - char_idx*8);
    
                current_font := iso8859_to_font(ascii_char);
    
                bit_val := get_char_bit(current_font, char_row, char_col);
    
                IF bit_val = '1' THEN
                    text_on <= '1';
                END IF;
    
            END IF;
    
        END IF;
--        --second row plaintext
--        IF pixel_col >= 40 AND pixel_col < 40 + (55 * CHAR_WIDTH * SCALE) AND
--           pixel_row >= 96 AND pixel_row < 96 + (CHAR_HEIGHT * SCALE) THEN
    
--            x_rel := TO_INTEGER(UNSIGNED(pixel_col)) - 35;
--            y_rel := TO_INTEGER(UNSIGNED(pixel_row)) - 96;
    
--            char_idx := x_rel / (CHAR_WIDTH * SCALE);
    
--            IF char_idx >= 28 AND char_idx < 55 THEN
    
--                char_col := ((x_rel) MOD (CHAR_WIDTH * SCALE)) / SCALE;
--                char_row := y_rel / SCALE;
    
--                ascii_char :=
--                    plaintext(439 - char_idx*8 DOWNTO 432 - char_idx*8);
    
--                current_font := iso8859_to_font(x"42");
    
--                bit_val := get_char_bit(current_font, char_row, char_col);
    
--                IF bit_val = '1' THEN
--                    text_on <= '1';
--                END IF;
    
--            END IF;
    
--        END IF;
        --first row hash
        IF pixel_col >= 40 AND pixel_col < 40 + (64 * CHAR_WIDTH * SCALE) AND
           pixel_row >= 176 AND pixel_row < 176 + (CHAR_HEIGHT * SCALE) THEN
    
            x_rel := TO_INTEGER(UNSIGNED(pixel_col)) - 40;
            y_rel := TO_INTEGER(UNSIGNED(pixel_row)) - 296;
    
            char_idx := x_rel / (CHAR_WIDTH * SCALE);
    
            IF char_idx >= 0 AND char_idx < 64 THEN
    
                char_col := (x_rel MOD (CHAR_WIDTH * SCALE)) / SCALE;
                char_row := y_rel / SCALE;
    
                hex_digit_of_char :=
                    hash(255 - char_idx*4 DOWNTO 252 - char_idx*4);
                --hex_digit_of_char
                current_font := hex_digit_to_font(hex_digit_of_char);
    
                bit_val := get_char_bit(current_font, char_row, char_col);
    
    
                IF bit_val = '1' THEN
                    text_on <= '1';
                END IF;
    
            END IF;
    
        END IF;
        --second row hash
--        IF pixel_col >= 40 AND pixel_col < 40 + (55 * CHAR_WIDTH * SCALE) AND
--           pixel_row >= 296 AND pixel_row < 296 + (CHAR_HEIGHT * SCALE) THEN
    
--            x_rel := TO_INTEGER(UNSIGNED(pixel_col)) - 35;
--            y_rel := TO_INTEGER(UNSIGNED(pixel_row)) - 176;
    
--            char_idx := x_rel / (CHAR_WIDTH * SCALE);
    
--            IF char_idx >= 32 AND char_idx < 64 THEN
    
--                char_col := ((x_rel) MOD (CHAR_WIDTH * SCALE)) / SCALE;
--                char_row := y_rel / SCALE;
    
--                hex_digit_of_char :=
--                    hash(255 - char_idx*4 DOWNTO 252 - char_idx*4);
--                --hex_digit_of_char
--                current_font := hex_digit_to_font(x"d");
    
--                bit_val := get_char_bit(current_font, char_row, char_col);
    
    
--                IF bit_val = '1' THEN
--                    text_on <= '1';
--                END IF;
    
--            END IF;
    
--        END IF;
    END PROCESS;

END Behavioral;
