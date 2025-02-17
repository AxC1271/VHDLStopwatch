library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_timer is
    Port (
        clk     : in STD_LOGIC;  
        rst     : in STD_LOGIC;  
        clk_1khz : out STD_LOGIC 
    );
end mux_timer;

architecture Behavioral of mux_timer is
    signal counter : integer := 0;
    signal temp_clk : STD_LOGIC := '0';
    constant DIVIDER : integer := 50000; 
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            temp_clk <= '0';
        elsif rising_edge(clk) then
            if counter = DIVIDER then
                counter <= 0;
                temp_clk <= not temp_clk;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_1khz <= temp_clk;
end Behavioral;