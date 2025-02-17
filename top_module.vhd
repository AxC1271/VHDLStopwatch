library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_module is
    Port ( clk       : in STD_LOGIC;                
           rst       : in STD_LOGIC;                
           seg       : out STD_LOGIC_VECTOR(6 downto 0);  
           anodes    : out STD_LOGIC_VECTOR(3 downto 0)
           ); 
end top_module;

architecture Behavioral of top_module is
    
    signal clk_1khz     : STD_LOGIC := '0';
    signal clk_1hz      : STD_LOGIC := '0';          
    signal sec_count : STD_LOGIC_VECTOR(5 downto 0); 
    signal min_count   : STD_LOGIC_VECTOR(5 downto 0);
    
    signal bcd_min_tens  : STD_LOGIC_VECTOR(6 downto 0);
    signal bcd_min_ones  : STD_LOGIC_VECTOR(6 downto 0);
    signal bcd_sec_tens : STD_LOGIC_VECTOR(6 downto 0);
    signal bcd_sec_ones : STD_LOGIC_VECTOR(6 downto 0);

begin

    mux_clk_inst : entity work.mux_timer
        port map (
            clk => clk,
            rst => rst,
            clk_1khz => clk_1khz
        );
        
    clk_div_inst : entity work.clock_divider
        port map (
            clk  => clk,    
            rst  => rst,    
            clk_1hz => clk_1hz  
        );

    timekeeping_inst : entity work.timekeeping_counter
        port map (
            clk      => clk_1hz,          
            rst      => rst,                   
            mins     => min_count,     
            secs     => sec_count        
        );

    bcd_converter_inst : entity work.bcd_converter
        port map (
            min => min_count,
            sec => sec_count,
            bcd_min_tens => bcd_min_tens,
            bcd_min_ones => bcd_min_ones,
            bcd_sec_tens => bcd_sec_tens,
            bcd_sec_ones => bcd_sec_ones
        );

    clock_mux_inst : entity work.clock_mux
        port map (
            clk => clk_1khz,  
            rst => rst, 
            bcd_min_tens => bcd_min_tens,
            bcd_min_ones => bcd_min_ones,
            bcd_sec_tens => bcd_sec_tens,
            bcd_sec_ones => bcd_sec_ones,
            seg => seg,
            anodes => anodes
        );
end Behavioral;