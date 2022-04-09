library IEEE;
use IEEE.std_logic_1164.all;

--Entity puerta NOT
entity not1 is

	port ( 
		
		--1 señal de salida
		y0 : out std_logic;
		--1 señales de entrada
		x0 : in std_logic );

end entity;

--Arquitectura puerta NOT (funcionamiento)
architecture not1 of not1 is
begin

	y0 <= not x0;

end architecture;
