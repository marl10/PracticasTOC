library ieee;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity unidadControl is 
    port(
        rst:            in std_logic;
        clk:            in std_logic;
        inicio:         in std_logic;
        fin:         in std_logic;
        estado:         in std_logic_vector(1 downto 0); -- señales procedentes de la ruta de datos 
        control:        out std_logic_vector(4 downto 0); -- señales de control que se transfierren a la ruta de datos
        fin:            out std_logic
    ); 

end unidadControl; 

architecture rtl of unidadControl is 

type t_estado is (s0, s1,s2,s3,s4, s5); 
signal estado_actual, estado_sig: t_estado; 


end rtl; 