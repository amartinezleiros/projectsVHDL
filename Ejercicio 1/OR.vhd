library IEEE;
use IEEE.std_logic_1164.all;

--Entity puerta OR
entity or2 is

	port ( 
		
		--1 señal de salida
		y0 : out std_logic;
		--2 señales de entrada
		x0, x1 : in std_logic );

end entity;

--Arquitectura puerta OR (funcionamiento)
architecture or2 of or2 is
begin

	y0 <= x0 or x1;

end architecture;
