
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity multiplicador is
	port(
			X: in std_logic_vector(3 downto 0);
			Y: in std_logic_vector(3 downto 0);
			Z: out std_logic_vector(7 downto 0));
	

end multiplicador;

architecture Behavioral of multiplicador is


	

	component sumador is
		generic(N: natural := 8);
		port(
			rst, clk: in std_logic; 
			A,B : in std_logic_vector(N - 1 downto 0);
			Z:		out std_logic_vector(N-1 downto 0)
			);
	end component; 
	
	signal aux1, aux2, aux3, aux4, aux5, aux6, salida : std_logic_vector(7 downto 0);
	signal and_1, and_2, and_3, and_4: std_logic_vector(3 downto 0);

	signal reg_1, reg_2, reg_3, reg_4, reg_5, reg_6 : std_logic_vector(7 downto 0);




begin

	p_reg: process(clk, rst)
	begin 

		if rst = '1' then 
			reg_1 <= "00000000"; 
			reg_2 <= "00000000";
			reg_3 <= "00000000";
			reg_4 <= "00000000";
			reg_5 <= "00000000";
			reg_6 <= "00000000";
		elsif rising_edge(clk) then
			reg_1 <= aux6; 
			reg_2 <= aux4;
			reg_3 <= aux3;
			reg_4 <= reg_1;
			reg_5 <= reg_1;
			reg_6 <= salida;
		end if; 


	end process; 

	sumador_1: sumador
			port map(
						 A => aux2,
						 B => aux1,
						 Z => aux3
							
							);
	sumador_2: sumador
			port map(
						 A => reg_2,
						 B => reg_3,
						 Z => reg_5
							
							);
	sumador_3: sumador
			port map(
						 A => reg_1,
						 B => reg_5,
						 Z => salida
							);
			
			and_1 <= "0000" when Y(0) = '0' else
						X; 
			and_2 <= "0000" when Y(1) = '0' else
						X; 
			and_3 <= "0000" when Y(2) = '0' else
						X; 
			and_4 <= "0000" when Y(3) = '0' else
						X; 
			
			aux1 <= "0000"&and_1; 
			
			aux2 <= "000"&and_2&"0"; 
			
			aux4 <= "00"&and_3&"00"; 
			
			aux6 <= "0"&and_4&"000"; 


end Behavioral;

