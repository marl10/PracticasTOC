----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:11 10/25/2018 
-- Design Name: 
-- Module Name:    sumador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity sumador is
	generic(N: natural := 8);
	port(
			A,B : in std_logic_vector(N - 1 downto 0);
			Z:		out std_logic_vector(N-1 downto 0)
			);

end sumador;

architecture Behavioral of sumador is
	signal result : std_logic_vector(N-1 downto 0);

begin
	result <= A+ B; 
	Z <= result; 


end Behavioral;

