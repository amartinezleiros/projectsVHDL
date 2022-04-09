library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--ENTITY CIRCUITO COMBINACIONAL
ENTITY CircuitoCombinacional IS
	
	--CONSTANT GENERIC QUE INDICARÁ EL NÚMERO DE BITS DE LOS CUALES ESTARÁN FORMADOS LAS PALABRAS A, B Y RES
	GENERIC(
		CONSTANT n	: INTEGER := 4
	);
	PORT(
		--SALIDAS
		res		: OUT signed(n-1 DOWNTO 0) := (others => '0');
		desbordamiento	: OUT std_logic := '0';
		cero		: OUT std_logic := '0';
		signo		: OUT std_logic := '0';
		--ENTRADAS
		a		: IN signed(n-1 DOWNTO 0);
		b		: IN signed(n-1 DOWNTO 0);
		cin		: IN std_logic
	);

END ENTITY;


ARCHITECTURE Comportamiento OF CircuitoCombinacional IS
		
		--SEÑALES AUXILIARES
		SIGNAL cinAux,S	: signed (n-1 DOWNTO 0) := (others => '0');
		SIGNAL checkD	: std_logic; 
		
BEGIN	
	
	--USAREMOS LA SEÑAL cinAux PARA SUMARLE 1 A NUESTRO CIRCUITO COMBINACIONAL
	--PARA PODER SUMARSELO, TENEMOS QUE TENER UNA VARIABLE DE TIPO SIGNED
	--ES POR ELLO QUE CREAMOS ESTE BUCLE WHEN-ELSE
	cinAux(0) <= '1' when cin = '1' else
	'0';
	
	--SUMARIAMOS LAS SEÑALES TIPO SIGNED A, B Y CINAUX, LO CUAL NOS DEVOLVERIA EL
	--VALOR DE NUESTRO RESULTADO FINAL
	S <= a + b + cinAux;
	res <= S;
	
	--BUCLE PARA VERIFICAR SI HAY DESBORDAMIENTO, CUANDO EL BIT DE MAS VALOR DE A SEA DISTINTO
	--DEL BIT DE MÁS VALOR DE B 0 CUANDO EL BIT DE MAS VALOR DE A, DE B Y DEL RESULTADO SEAN IGUALES,
	--EL DESBORDAMIENTO SE FIJARÁ A '0'
	checkD <= '0' when a(n-1) /= b(n-1) else
	'0' when a(n-1) = b(n-1) and a(n-1) = S(n-1) else
	'1';

	desbordamiento <= checkD;

	--LA SEÑAL CERO SERÁ '1' SOLO CUANDO EL VALOR DEL RESULTADO CONVERTIDO A INTEGER SEA 0 Y QUE EL VALOR
	--DE LA SEÑAL DESBORDAMIENTO SEA '0', SI NO, SU VALOR SERÁ '0'.
	cero <= '1' when to_integer(S) = 0  and checkD = '0' else
	'0';
	
	--LA SEÑAL SIGNO, SERÁ EL BIT DE MAYOR VALOR DEL RESULTADO SIEMPRE Y CUANDO NO HAYA DESBORDAMIENTO, SI NO,
	--SERA EL OPUESTO AL BIT DE MAYOR VALOR DEL RESULTADO.
	signo <= S(n-1) when checkD = '0' else
	not S(n-1);



END ARCHITECTURE;
	