library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_mux is
    Port ( clk          : in STD_LOGIC;                
           rst          : in STD_LOGIC;               
           bcd_hr_tens  : in STD_LOGIC_VECTOR(6 downto 0); 
           bcd_hr_ones  : in STD_LOGIC_VECTOR(6 downto 0);  
           bcd_min_tens : in STD_LOGIC_VECTOR(6 downto 0); 
           bcd_min_ones : in STD_LOGIC_VECTOR(6 downto 0);  
           seg          : out STD_LOGIC_VECTOR(6 downto 0);  
           anodes       : out STD_LOGIC_VECTOR(3 downto 0)  
         );
end clock_mux;

architecture Behavioral of clock_mux is

    signal count : integer range 0 to 3 := 0;

begin

    process(clk, rst)
    begin
        if rst = '1' then
            count <= 0;
        elsif rising_edge(clk) then
            count <= (count + 1) mod 4;  
        end if;
    end process;

    process(count, bcd_hr_tens, bcd_hr_ones, bcd_min_tens, bcd_min_ones)
    begin
        seg <= "1111111";  
        anodes <= "1111";  

        case count is
            when 0 =>  
                seg <= bcd_hr_tens;
                anodes <= "0111"; 
            when 1 =>  
                seg <= bcd_hr_ones;
                anodes <= "1011"; 
            when 2 =>  
                seg <= bcd_min_tens;
                anodes <= "1101"; 
            when 3 => 
                seg <= bcd_min_ones;
                anodes <= "1110";  
            when others =>
                seg <= "1111111";  
        end case;
    end process;

end Behavioral;