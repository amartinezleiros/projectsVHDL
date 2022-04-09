library IEEE;
use IEEE.std_logic_1164.all;

--Entity AND
entity and2 is

	port ( 

		--1 se�al salida
		y0 : out std_logic;

		--2 se�ales entrada
		x0, x1 : in std_logic 

	);

end entity;

--Arquitectura puerta AND (funcionamiento)
architecture and2 of and2 is
begin

	y0 <= x0 and x1;

end architecture;

