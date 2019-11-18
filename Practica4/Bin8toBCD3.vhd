library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity Bin8toBCD3 is
    port ( binario  : in  std_logic_vector (7 downto 0) ;
           bcd3 : out std_logic_vector (11 downto 0) 
           ) ;
end Bin8toBCD3 ;

architecture arc_Bin8toBCD3 of Bin8toBCD3 is

begin
  

process ( binario )
    variable hex_src : std_logic_vector (7 downto 0) ;
    variable bcd     : std_logic_vector (11 downto 0) ;
begin
    hex_src := binario ;
    bcd     := (others => '0') ;
-- implentacion del algortimo para pasar de binario a BCD esta dividido en 3 secciones(centenas, decenas, unidades)
-- 1) se desplaza el numero en binario un bit a la izquierda
-- 2) si alguno de los digitos dezplazados tienen un valor mayor o igual a 5 se le suma 3. 
-- 3) se ha de repetir 1 y 2 tantas veces como bits se quieran convertir, en este caso 4 bits por numero 
    for i in 0 to 7 loop
        if bcd(3 downto 0) > "0100" then
            bcd(3 downto 0) := bcd(3 downto 0) + "0011" ;
        end if ;
        if bcd(7 downto 4) > "0100" then
            bcd(7 downto 4) := bcd(7 downto 4) + "0011" ;
        end if ;
        if bcd(11 downto 8) > "0100" then
            bcd(11 downto 8) := bcd(11 downto 8) + "0011" ;
        end if ;

        bcd := bcd(10 downto 0) & hex_src(7) ; -- aqui se almacena el bit que ha sido desplazado de la cadena que queremos convertir
        hex_src := hex_src(6 downto 0) & '0' ; -- aqui se llevan acabo los desplazamientos a la izquierda 
    end loop ;

    bcd3 <= bcd;

end process ;
	 
end arc_Bin8toBCD3 ;