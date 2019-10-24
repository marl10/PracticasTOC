library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mul4 is

    port(
        x: in signed(3 down to 0); 
        y: in signed(3 down to 0); 
        z: out signed(3 down to 0) 

    ); 

end mul4; 

architecture rtl of mul4 is

    component adder8b
    port( 
          a: in  signed(7 downto 0);
          b: in  signed( 7 downto 0);
          z: out signed(7 downto 0)
        
    
        );
    end component; 

    signal salida1, salida2, salida3: signed(3 down to 0); 
    signal and0, and1, and2,and3: signed(3 down to 0);

begin

    and0 <= x and y(0); 
    and1 <= x and y(1);
    and2 <= x and y(2);
    and3 <= x and y(3);


    sum1: adder8b port map ("000"&and1&"0", "0000"&and0, salida1); 
    sum2: adder8b port map ("00"&and2&"00", salida1, salida2); 
    sum3: adder8b port map ("0"&and3&"000", salida2, z); 

end rtl;