library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity cerrojo_avan is

    port (
        boton, rst, clk: in std_logic; 
        clave_in: in std_logic_vector(7 down to 0); 
        num_intentos: in std_logic_vector(3 down to 0); 
        intentos_restantes: out std_logic_vector(6 down to 0); 
        leds: out std_logic_vector(7 down to 0)

    ); 

end cerrojo_avan; 

architecture acrhCerrojo of cerrojo_avan is





end architecture; 