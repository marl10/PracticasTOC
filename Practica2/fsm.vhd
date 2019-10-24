library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port(
        boton, rst, clk: in std_logic; 
        clave_in: in std_logic_vector(7 down to 0); 
        intentos: out std_logic_vector(3 down to 0); 
        abierto_leds: out std_logic_vector(8 down to 0)

    ); 

end fsm; 

architecture Behaviral of fsm is 

type estados_t is (inicial, tres, dos, uno, final); 
signal estados_t actual_t, siguiente_t: estados_t; 

signal clave_acceso: std_logic_vector(7 down to 0); 

-- proceso que define el comportamiento de un registro, en este caso el que se guarda la
-- contraseña de acceso(la que hay que adivinar) 
p_reg: process(clk, rst)
begin
    if rst = '1' then 
        clave_acceso <= "00000000"; 
    elsif rising_edge(clk) then 
        if boton = '1' and actual_t = inicial then 
            clave_acceso <= clave; 
        end if; 
    end if; 

end process; 

----------------------------------------------------------------------------------

-- proceso que define el transito de estaodo, en la maquina de estados. 
p_sincrono: process(clk, rst)
begin 
    if rst = '1' then 
        actual_t <= inicial; 
    elsif rising_edge(clk) then 
        actual_t <= siguiente_t;
    end if; 
end process; 

----------------------------------------------------------------------------------

p_siguiente_estado: process(actual_t, clave, clace_acceso, boton)
begin

    case actual_t is 
        when inicial => 
            intenentos <= "0000";
            abierto_leds <= "111111111";

            if boton = '1' then 
                siguiente_t <= tres; 
            else 
                siguiente_t <= actual_t; 
            end if; 

        when tres => 
            intentos <= "0011"; 
            abierto_leds <= "000000000";

            if boton = '1' and clave = clave_acceso then 
                siguiente_t <= inicial; 
            elsif boton = '1' and clave /= clave_acceso then 
                siguiente_t <= dos; 
            else 
                siguiente_t <= actual_t; 
            end if; 
        when dos => 
            intentos <= "0010";
            abierto_leds <= "000000000";

            if boton = '1' and clave = clave_acceso then 
                siguiente_t <= inicial; 
            elsif boton = '1' and clave /= clave_acceso then 
                siguiente_t <= dos; 
            else 
                siguiente_t <= actual_t; 
             end if; 

        when uno => 

            intentos <= "0001";
            abierto_leds <= "000000000";

            if boton = '1' and clave = clave_acceso then 
                siguiente_t <= inicial; 
            elsif boton = '1' and clave /= clave_acceso then 
                siguiente_t <= dos; 
            else 
                siguiente_t <= actual_t; 
             end if; 
        
        when final => 

            intentos <= "1110"; 
            abierto_leds <= "000000000";
            siguiente_t <= actual_t; 
        when others => 
            intentos <= "1010"; 
            abierto <= "111111111";
            suiguiente_t <= inicial; 
    end case; 
    
end process; 

end Behaviral; 












