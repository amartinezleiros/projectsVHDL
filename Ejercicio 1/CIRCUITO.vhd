library IEEE;
use IEEE.std_logic_1164.all;

--Entity
entity Circuito is
	port(

		--3 Señales entrada
		X,Y,Z : in std_logic;

		--2 Señales salida
		F,G   : out std_logic

	);
end entity;

--Architecture
architecture Comp of Circuito is
begin

	--F = x'z+xy
	F <= ((not x) and z) or (x and y);

	--G = x'z+x'y'
	G <= ((not x) and z) or ((not x) and (not y));

end architecture;

architecture Estruc_Circuito of Circuito is

signal not_x_and_z, xy, not_x_and_not_y, not_x, not_y: std_logic;

-- Declaración de las clases de los componentes
component and2 is
	port ( 

		y0 : out std_logic;

		x0, x1 : in std_logic

	);
end component;

component not1 is
	port ( 

		y0 : out std_logic;

		x0 : in std_logic 
	);
end component;

component or2 is
	port ( 

		y0 : out std_logic;
	
		x0, x1 : in std_logic 
	);
end component;

begin
-- Instanciación y conexión de los componentes
not1_1 : component not1 port map (not_x, x);
not1_2 : component not1 port map (not_y, y);
and2_1 : component and2 port map (not_x_and_z, not_x, z);
and2_2 : component and2 port map (xy, x, y);
and2_3 : component and2 port map (not_x_and_not_y, not_x, not_y);
or2_1 : component or2 port map (F, xy, not_x_and_z);
or2_2: component or2 port map (G, not_x_and_not_y, not_x_and_z);
end architecture Estruc_Circuito;


