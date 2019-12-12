library ieee;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rutaDatos is
     generic(width : natural := 7);
        port(
            rst:            in std_logic; 
            clk:            in std_logic;
            a_in:           in std_logic_vector(width downto 0); 
            b_in:           in std_logic_vector(width downto 0);
            control:        in std_logic_vector(4 downto 0); 
            display:        out std_logic_vector(6 downto 0);
            display_enable: out std_logic_vector(3 downto 0); 
            estado:         out std_logic_vector(1 downto 0)
    
        ); 
end rutaDatos; 

architecture rtl of rutaDatos is
