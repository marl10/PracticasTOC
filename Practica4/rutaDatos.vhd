library ieee;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity rutaDatos is
        port(
            rst:            in std_logic; 
            clk:            in std_logic;
            a_in:           in std_logic_vector(3 downto 0); 
            b_in:           in std_logic_vector(3 downto 0);
            control:        in std_logic_vector(4 downto 0); 
            display:        out std_logic_vector(6 downto 0);
            display_enable: out std_logic_vector(3 downto 0); 
            estado:         out std_logic_vector(1 downto 0)
    
        ); 
end rutaDatos; 

architecture rtl of rutaDatos is

    constant 4_ceros : std_logic_vector(3 downto 0):= "0000";
    signal ldr, des, ce, ldacc, mux_acc: std_logic; 
    signal n_zero: std_logic; 
    signal a,b, acc, mux_salida, suma_res: std_logic_vector(7 downto 0);
    signal n : std_logic_vector(2 downto 0);

    -- ****************** -- 
    -- SEÑALES NECESARIAS PARA EL DISPLAY 

    signal dis1, dis2,dis3, dis4: std_logic_vector(3 downto 0); 


    -- ****************** --
   
   

    component conv_binarioTo_7seg is 
        port(
            rst:                in std_logic; 
            clk:                in std_logic; 
            binario_in:         in std_logic_vector(7 downto 0); 
            display_out:        out std_logic_vector(6 downto 0); 
            display_enable_out: out std_logic_vector(3 downto 0)

        ); 
        end component; 


 begin 
 

 (ldr, des, ce, ldaacc, mux_acc) <= control; -- las señales de control las pasamos por un array pero aqui las desglosamos en señales individuales para facilitar si control
 -- control(4) es ldr
 estado <= (n_zero & b(0)); -- este es un vector de salida con las señales de estado en este caso son n == 0 que es la comparacion y con el bit de la posicion 0 del array b

 conversor: conv7_BCD_2Displays port map (acc,res_2Displays); -- Bits 13-7 son un display. 6-0 el otro.

 salida_display: conv_binarioTo_7seg port map(
        rst         =>  rst,     
        clk         =>  clk,       
        binario_in  =>  acc,
        display_out =>  display, 
        display_enable_out => display_enable

 ); 


 -----------------************************************************-----------------
 --                IMPLENTACION DE LOS COMPONENTES FISICOS DE LA RUTA DE DATOS 
 -----------------************************************************-----------------


 -------------------------------------------------------------
 --        REGISTRO DESPLAZAMIENTO A LA IZQUIERDA PARA A 
 -------------------------------------------------------------
 p_aregistro: process(clk, rst) is 
    begin 
        if rst = '1' then 
            a <= 4_ceros & 4_ceros; 
        elsif rising_edge(clk) then 
            if ldr = '1' then 
                a <= 4_ceros & a_in; 
            elsif des = '1' then -- des = señal que indica si se activa el desplazamiento 
                a <= a(6 downto 0) & '0'; -- metemos un cero a la izqueirda del todo y lo concatenamos con el mismo quitandole el ultimo bit
            end if; 
        end if; 
 end process p_aregistro;


 -------------------------------------------------------------
 --        REGISTRO DESPLAZAMIENTO A LA DERECHA PARA B 
 -------------------------------------------------------------
 p_bregistro: process(clk, rst) is 
    begin 
        if rst = '1' then 
                a <= 4_ceros & 4_ceros; 
            elsif rising_edge(clk) then 
                if ldr = '1' then 
                    a <= 4_ceros & a_in; 
                elsif des = '1' then -- des = señal que indica si se activa el desplazamiento 
                    a <= a(6 downto 0) & '0'; -- metemos un cero a la izqueirda del todo y lo concatenamos con el mismo quitandole el ultimo bit
                end if; 
            end if; 
 end process p_bregistro;

  -------------------------------------------------------------
 --        REGISTRO ACC CON CARGA PARALELA (todo de golpe)
 -------------------------------------------------------------

 p_accregistro: process(clk, rst) is 
 begin 
    if(rst = '1') then 
        acc <= (others => '0'); 
    elsif rising_edge(clk) then 
        if(ldaacc = '1') then 
            acc <= mux_salida; 
        end if; 
    end if; 
 end process p_accregistro;

 -------------------------------------------------------------
 --       contador descendente para n 
 -------------------------------------------------------------

 p_ncontador: process(clk, rst) is 

 begin 
    if rst = '1' then 
        n <= (others => '0'); 
    elsif rising_edge(clk) then
        if ldr = '1' then 
            n <= "100"; 
        elsif ce = '1' then 
            n <= n - 1;
        end if; 
    end if; 
 end process p_ncontador;

 -------------------------------------------------------------
 --       mux
 -------------------------------------------------------------

 p_mux: process (mux_acc, suma_res) is 
 
 begin 
    if mux_acc = '0' then 
        mux_salida <= (others => '0'); 
    else 
        mux_salida <= suma_res;
    end if; 
 end process p_mux;


 -------------------------------------------------------------
 --    Sumador. con libreria ieee.std_logic_arith.all;
 -------------------------------------------------------------

 p_sumador: process (acc, a) is
 begin 
    suma_res <= acc + a: 

 end process p_sumador;

 -------------------------------------------------------------
 --    Comparador con cero
 -------------------------------------------------------------

 p_cmp: process (n) is 
 begin 
    if n = "000" then 
        n_zero <= '1'; 
    else 
        n_zero <= '0'
    end if; 

 end process p_cmp; 


end rtl;