library ieee;
use ieee.std_logic_1164.all;

entity tragaperras is

    port(
        rst:    in std_logic;
        clk:    in std_logic;
        inicio: in std_logic; 
        fin:    in std_logic; 
        leds:   out std_logic_vector(9 downto 0); 
        displays: out std_logic_vector(6 downto 0); 
        display_enable: out std_logic_vector(3 downto 0)
    ); 
end tragaperras;

architecture bh of tragaperras is

begin


end bh; 