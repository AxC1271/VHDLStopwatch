library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_converter is
    Port ( 
           min   : in  STD_LOGIC_VECTOR(5 downto 0);  
           sec  : in  STD_LOGIC_VECTOR(5 downto 0); 
           bcd_min_tens  : out STD_LOGIC_VECTOR(6 downto 0); 
           bcd_min_ones  : out STD_LOGIC_VECTOR(6 downto 0);  
           bcd_sec_tens : out STD_LOGIC_VECTOR(6 downto 0);  
           bcd_sec_ones : out STD_LOGIC_VECTOR(6 downto 0)
         );
end bcd_converter;

architecture Behavioral of bcd_converter is
    function bcd_to_7seg(digit : integer) return STD_LOGIC_VECTOR is
    begin
        case digit is
            when 0 => return "0000001";  
            when 1 => return "1001111";  
            when 2 => return "0010010";  
            when 3 => return "0000110";  
            when 4 => return "1001100"; 
            when 5 => return "0100100";  
            when 6 => return "0100000";  
            when 7 => return "0001111"; 
            when 8 => return "0000000"; 
            when 9 => return "0000100"; 
            when others => return "1111111"; 
        end case;
    end function;

begin
    process(min, sec)
        variable min_int : integer range 0 to 59;
        variable sec_int : integer range 0 to 59;
        variable min_tens, min_ones : integer range 0 to 9;
        variable sec_tens, sec_ones : integer range 0 to 9;
    begin
        min_int := to_integer(unsigned(min(5 downto 0)));  
        sec_int := to_integer(unsigned(sec(5 downto 0)));  

        min_tens := hr_int / 10;
        min_ones := hr_int mod 10;
        sec_tens := min_int / 10;
        sec_ones := min_int mod 10;

        bcd_min_tens <= bcd_to_7seg(min_tens);  
        bcd_min_ones <= bcd_to_7seg(min_ones); 
        bcd_sec_tens <= bcd_to_7seg(sec_tens);  
        bcd_sec_ones <= bcd_to_7seg(sec_ones); 
    end process;

end Behavioral;