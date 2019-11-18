library ieee;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity unidadControl is 
    port(
        rst:            in std_logic;
        clk:            in std_logic;
        inicio:         in std_logic;
        estado:         in std_logic_vector(1 downto 0); 
        control:        out std_logic_vector(4 downto 0); 
        fin:            out std_logic
    ); 

end unidadControl; 

architecture rtl of unidadControl is 

type t_estado is (s0, s1,s2,s3,s4); 
signal estado_actual, estado_sig: t_estado; 
signal n_zero, b_zero: std_logic; 



constant c_ldr      : std_logic_vector(4 downto 0) := "10000";
constant c_des      : std_logic_vector(4 downto 0) := "01000"; -- desplazamietno 1 indica realizarlo 
constant c_ce       : std_logic_vector(4 downto 0) := "00100";-- counter enable del contador n 
constant c_ldacc    : std_logic_vector(4 downto 0) := "00010"; -- load del registro acc 
constant c_mux_acc  : std_logic_vector(4 downto 0) := "00001"; -- señal del mutiplexor

component debouncer is
    port (
       rst             : in  std_logic;
       clk             : in  std_logic;
       x               : in  std_logic;
       xdeb            : out std_logic;
       xdebfallingedge : out std_logic;
       xdebrisingedge  : out std_logic
       );
  end component;

signal iniciar_bueno, s1,s2; -- señales que han pasado por el eliminador de rebotes 
-- iniciar es el boton de inicio bueno, que ya se ha quitado los rebotes 


----************************************************************************************************************************************************----
begin
----************************************************************************************************************************************************----


(n_zero, b_zero) <= estado;  -- separamos del array de señales de estado en dos señales independientes para facilitar su uso 

elim_rebotes: debouncer port map(rst, clk, inicio, iniciar_bueno, s1, s2); 
 -------------------------------------------------------------
 --  proceso sincrono basico en cualquier maquina de estados, determina la tra
 -------------------------------------------------------------
 p_sincrono: process (clk, rst) is 
 begin 
    if rst = '1' then 
        estado_actual <= s0; 
    elsif rising_edge(clk) then 
        estado_actual <= estado_sig; 
    end if; 
 end process p_sincrono;

  -------------------------------------------------------------
 --  proceso que determina el siguiente estado 
 -------------------------------------------------------------

 p_nextState: process (estado_actual, iniciar_bueno, n_zero, b_zero) is 
 -- en esta liste de sensibilidad van tambien las señales de la ruta de datos(señales de estado) ademas de otras señales que pueden influir en la toma de decisiones 
 begin
    case estado_actual is
        when s0 => 
            if iniciar_bueno = '1' then 
                estado_sig <= s1; 
             else 
            estado_sig <= s0; 
            end if; 
        when s1 => 
            estado_sig <= s2; 
        when s2 => 
            if n_zero = '1' then 
                estado_sig <= s0; 
            else 
                if b_zero = '0' then 
                    estado_sig <= s3; 
                else 
                    estado_sig <= s4; 
                end if; 
            end if; 
        when s3 => 
            estado_sig <= s2; 
        when s4 => 
            estado_sig <= s2; 
        when others => null;    
    end case; 
 end process p_nextState;

 p_salidas: process (estdo_actual) is 
 begin 
 control <= (others => '0'); 
 case estado_actual is 
        when s0 => 
            control <= (others => '0'); 
            fin <= '1'; 
        when s1 => 
            -- cargamos los registros 
            control <= c_ldr or c_ldacc; 
            fin <= '0'; 
        when s2 => -- no se hace nada con los dispositivos hardaware, es decir, los registros no se cargan, ni se hace un desplazamiento o funciona el contador
            control <= (others => '0'); 
            fin <= '0'; 
        when s3 => 
            control <= c_des or ce; -- hacemos que los regisotros con desplazamiento funcionen y ademas hacemos que el contador tambien funcione por ello necesitamos 
            -- dos señales de control 
            fin <= '0'; 
        when s4 => 
            control <= c_des or ce or c_mux_acc or c_ldacc; -- igual que s3 pero ademas debemos seleccionar la salida 1 del mux y ademas activar el load del regristo acc
            fin <= '0'; 
        when others => null;
 end case; 
 end process p_salidas; 


end rtl;