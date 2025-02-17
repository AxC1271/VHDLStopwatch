library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_1hz : out STD_LOGIC);
end clock_divider;

architecture Behavioral of clock_divider is
    constant MAX_COUNT : integer := 100_000_000 - 1; 
    signal count : integer range 0 to MAX_COUNT := 0;
    signal clk_reg : STD_LOGIC := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            count <= 0;
            clk_reg <= '0';
        elsif rising_edge(clk) then
            if count = MAX_COUNT then
                count <= 0;
                clk_reg <= not clk_reg;
            else
                count <= count + 1;
            end if;
         end if;
    end process;

    clk_1hz <= clk_reg;

end Behavioral;