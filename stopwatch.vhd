library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stopwatch is
    port (
        clk : in STD_LOGIC; 
        rst : in STD_LOGIC;
        segment : out STD_LOGIC_VECTOR(6 downto 0);
        anode : out STD_LOGIC_VECTOR(3 downto 0)
    );
end stopwatch;

architecture Behavioral of stopwatch is

    signal clk_100Hz : STD_LOGIC := '0';
    signal clk_1kHz : STD_LOGIC := '0';
    signal value_i : integer range 0 to 9999 := 0;
    
    -- by default, all segments and anodes are blank
    signal segment_i : STD_LOGIC_VECTOR(6 downto 0) := "1111111";
    signal anode_i : STD_LOGIC_VECTOR(3 downto 0) := "1111";
    
begin
    -- here we begin our processes
    
    -- first we start with a clock divider to get a 1Hz clock
    clock_divider_100Hz: process(clk) is
        constant max_100Hz : integer := (100_000_000 / 100) / 2;
        variable clk_count : integer range 0 to max_100Hz := 0;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                clk_100Hz <= '0';
                clk_count := 0;
            else
                if clk_count = max_100Hz then
                    clk_count := 0;
                    clk_100Hz <= not clk_100Hz;
                else
                    clk_count := clk_count + 1;
                end if;
            end if;
        end if;
    end process clock_divider_100Hz;
    
    -- we have a second clock divider for our multiplexer
    clock_divider_1kHz: process(clk) is
        constant max_1kHz : integer := (100_000_000 / 1000) / 2;
        variable clk_count : integer range 0 to max_1kHz := 0;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                clk_1kHz <= '0';
                clk_count := 0;
            else
                if clk_count = max_1kHz then
                    clk_count := 0;
                    clk_1kHz <= not clk_1kHz;
                else
                    clk_count := clk_count + 1;
                end if;
            end if;
        end if;
    end process clock_divider_1kHz;
    
    -- we update our counter a hundred times every second since 
    -- I plan on using the two rightmost digits 00:00 to track the centi-seconds
    -- the left two segments are our actual seconds
    counter_register : process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                value_i <= 0;
            elsif rising_edge(clk_100Hz) then
                if value_i = 9999 then
                    value_i <= 0;
                else
                    value_i <= value_i + 1;
                end if;
            end if;
        end if;
    end process counter_register;

    -- next process is our anode multiplexer 
    anode_mux : process(clk_1kHz) is 
        variable anode_select : integer range 0 to 3 := 0; 
    begin
        if rising_edge(clk_1kHz) then
            if rst = '1' then
                anode_select := 0;
                anode_i <= "1111";
            else 
                if anode_select = 3 then
                    anode_select := 0;
                else
                    anode_select := anode_select + 1;
                end if;
            end if;
        end if;
        
        case anode_select is
            when 0 =>
                anode_i <= "1110";
            when 1 =>
                anode_i <= "1101";
            when 2 =>
                anode_i <= "1011";
            when 3 =>
                anode_i <= "0111";
            when others =>
                anode_i <= "1111";
        end case;
   
    end process anode_mux;
    
    bcd_decoder : process(clk_1kHz) is 
        variable curr : integer range 0 to 9 := 0;
    begin
    if rising_edge(clk_1kHz) then
        if rst = '1' then
            segment_i <= "1111111"; 
        else
            case anode_i is
                when "1110" =>
                    curr := (value_i / 1) mod 10; 
                when "1101" =>
                    curr := (value_i / 10) mod 10; 
                when "1011" =>
                    curr := (value_i / 100) mod 10; 
                when "0111" =>
                    curr := (value_i / 1000) mod 10; 
                when others =>
                    curr := 0;
            end case;
            
            case curr is
                when 0 =>
                    segment_i <= "0000001";
                when 1 =>
                    segment_i <= "1001111";
                when 2 =>
                    segment_i <= "0010010";
                when 3 =>
                    segment_i <= "0000110";
                when 4 =>
                    segment_i <= "1001100";
                when 5 =>
                    segment_i <= "0100100";
                when 6 =>
                    segment_i <= "0100000";
                when 7 =>
                    segment_i <= "0001111";
                when 8 =>
                    segment_i <= "0000000";
                when 9 =>
                    segment_i <= "0000100";
                when others =>
                    segment_i <= "1111111";
            end case;
        end if;
    end if;
    end process bcd_decoder;
    
    anode <= anode_i;
    segment <= segment_i;
end Behavioral;
