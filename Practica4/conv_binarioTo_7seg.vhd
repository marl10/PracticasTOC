library ieee;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- MODULO TOCHO 
-- en este modulo se gestiona la conversion de binario a BCD y posteriormete a salida para los displays de 7 segmentos

entity conv_binarioTo_7seg is 
    port(
        rst, clk:       in std_logic; 
        binario_in:        in std_logic_vector(7 downto 0); 
        display_out:        out std_logic_vector(6 downto 0); 
        display_enable_out: out std_logic_vector(3 downto 0)

    ); 

end conv_binarioTo_7seg;

architecture Behavioral of conv_binarioTo_7seg is
-- señales necesarias 
signal BCD_out: std_logic_vector(11 downto 0); 
signal binario_decenas, binario_unidades: std_logic_vector(3 downto 0); 
signal display_unidades, display_decenas: std_logic_vector(6 downto 0); 


signal dis1, dis2, dis3, dis4: std_logic_vector(3 downto 0); 


-- instanciar componentes 
component Bin8toBCD3 is 
        port ( 
            binario:    in  std_logic_vector (7 downto 0) ;
            bcd3:       out std_logic_vector (11 downto 0) 
        ) ;
end component; 

component displays is 
        Port ( 
            rst : in STD_LOGIC;
            clk : in STD_LOGIC;       
            digito_0 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_1 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_2 : in  STD_LOGIC_VECTOR (3 downto 0);
            digito_3 : in  STD_LOGIC_VECTOR (3 downto 0);
            display : out  STD_LOGIC_VECTOR (6 downto 0);
            display_enable : out  STD_LOGIC_VECTOR (3 downto 0)
        );
end component; 

begin 

-- hacer port map 

conversor: Bin8toBCD3 port map(binario_in,BCD_out);

display: displays port map(rst, clk, binario_unidades, binario_decenas, dis3, dis4, display_out,  display_enable_out);

p_separarBCD: process(binario_in, BCD_out) is 

begin
    if binario_in > 01100011 then -- esto sirve para si me paso de 99 salga ff en los displays 
        binario_unidades <= "1111"; 
        binario_decenas <= "1111";
    else 
        binario_unidades <= BCD_out(3 downto 0); 
        binario_decenas <= BCD_out(7 downto 4);
    end if; 
end process; 


end Behavioral;