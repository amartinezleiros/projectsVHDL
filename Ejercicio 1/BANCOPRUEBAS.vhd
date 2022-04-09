-- Banco de pruebas
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity BP_Circuito is
end entity BP_Circuito;

architecture BP_Circuito of BP_Circuito is
	
	signal F, G : std_logic; -- Conectar salidas UUT
	signal x0, x1, x2 : std_logic; -- Conectar entradas UUT

component Circuito is 
	port( 
		F, G : out std_logic;
		x, y, z: in std_logic
	);
end component Circuito;

begin
-- Instanciar y conectar UUT
	uut : component Circuito port map
	( 
		F => F, G => G,
		x => x0, y => x1, z => x2);

gen_vec_test : process
variable test_in : unsigned (2 downto 0); -- Vector de test
begin
test_in := B"000";
for count in 0 to 7 loop
x2 <= test_in(2);
x1 <= test_in(1);
x0 <= test_in(0);
wait for 10 ns;
test_in := test_in + 1;
end loop;
wait;
end process gen_vec_test;
end architecture BP_Circuito;

