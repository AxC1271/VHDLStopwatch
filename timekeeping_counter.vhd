library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity timekeeping_counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           min : out STD_LOGIC_VECTOR(5 downto 0);
           sec : out STD_LOGIC_VECTOR(5 downto 0)
           );
end timekeeping_counter;

architecture Behavioral of timekeeping_counter is 
    signal m  : STD_LOGIC_VECTOR(5 downto 0) := "000000";         
    signal s  : STD_LOGIC_VECTOR(5 downto 0) := "000000";           
begin
    process(clk, rst)
    begin
        if rst = '1' then 
            m <= "000000";  
            s <= "000000";     
        elsif rising_edge(clk) then
                if s = "111011" then  
                    s <= "000000"; 
                    if m = "111011" then  
                        m <= "000000";  
                    else
                        m <= m + 1; 
                    end if;
                else
                    s <= s + 1; 
                end if;
            end if;
    end process;

    min <= m;
    sec <= s;

end Behavioral; 