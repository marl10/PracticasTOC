library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity fsm_avan is

    port(
        boton, rst, clk:    in std_logic; 
        clave_in:           in std_logic_vector(7 down to 0); 
        num_intentos:       in std_logic_vector(3 down to 0);
        intentos_restanres: out std_logic_vector(3 down to 0); -- numero de intentos restantes codificados en binario 
        leds:               out std_logic_vector(7 down to 0)
    ); 
end fsm_avan; 

architecture acrhFsm of fsm_avan is

----------------------------------------------------------------------

type estados_t is (inicial, intermedio, final); 
signal estados_t actual_t, siguiente_t: estados_t; 

signal clave_buena: std_logic_vector(7 down 0); 
signal intentos: std_logic_vector(3 down to 0); 
signal intentos2: std_logic_vector(3 down to 0); 
signal intentosTotal: std_logic_vector(3 down to 0); 
signal salida_intentos: std_logic_vector(3 down to 0); 

----------------------------------------------------------------------


----------------------------------------------------------------------
--      PROCESO QUE DEFINE EL FUNCIONAMIENTO DE UN REGISTRO

p_reg: process(rst, clk)
begin
    if rst = '1' then 
        clave_buena <= "00000000"; 
            intentos <= "0000"; 
    elsif rising_edge(clk) then
        if boton = '1' and actual_t = inicial then 
            clave_buena <= clave_in; 
            intentosTotal <= num_intentos;  
        end if; 
    end if; 
    
end process; 

p_sincrono: process(clk, rst)
begin
    if rst = '1' then 
        actual_t <= inicial; 
    elsif rising_edge(clk) then 
        actual_t <= siguiente_t;
        intentos <= intentos2; 
    end if; 

end process; 

----------------------------------------------------------------------


----------------------------------------------------------------------
--      PROCESO EN EL CUAL SE LLEVA A CABO EL SIGUIETNE ESTADO

p_sigEstado: process(clave_in,clave_buena ,actual_t, boton)
begin

    case actual_t is
        when inicial =>
        
            intentos_restantes <= intetosTotal; 
            leds <= (others => '1'); 
            intentos2 <= num_intentos; 

            if boton = '1' then 
                siguiente_t <= intermedio; 
            else 
                siguiente_t <= actual_t; 
            end if; 

        when intermedio => 
            intentos_restantes <= intentos; 
            leds <= (others => '0')

            if boton = '1' and clave_buena = clave_in then 
                siguiente_t <= inicial; 
            elsif boton = '1' and clave_buena /= clave_in then 
                if intentos = "0001" then
                    siguiente_t <= final; 
                else 
                    siguiente_t <= intermedio; 
                end if; 
            end if; 
            intentos2 <= std_logic_vector(unsigned(intentos) - 1); 

        when final =>
            intentos_restantes <= "0000"; 
            leds <= (others => '0'); 
            siguiente_t <= actual_t; 
    end case; 

end process; 


----------------------------------------------------------------------

end architecture; 