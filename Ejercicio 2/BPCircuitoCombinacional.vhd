library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity BP_CircuitoCombinacional is 
	GENERIC(
		CONSTANT n	: INTEGER := 4
	);
End Entity;


Architecture Comportamiento of BP_CircuitoCombinacional is
	
	COMPONENT CircuitoCombinacional	
 		PORT(
			res		: OUT signed(n - 1 DOWNTO 0);
			desbordamiento 	: OUT std_logic;
			cero	 	: OUT std_logic;
			signo	 	: OUT std_logic;
			a		: IN signed(n - 1 DOWNTO 0);
			b		: IN signed(n - 1 DOWNTO 0);
			cin		: IN std_logic
		 );
	END COMPONENT;
	
	--señales salida
	SIGNAL res		: signed(n - 1 DOWNTO 0);
	SIGNAL desbordamiento 	: std_logic;
	SIGNAL cero 		: std_logic;
	SIGNAL signo	 	: std_logic;
	SIGNAL errores 		: integer := 0;
	
	--señales entrada
	SIGNAL a 		: signed(n - 1 DOWNTO 0);
	SIGNAL b 		: signed(n - 1 DOWNTO 0);
	SIGNAL cin 		: std_logic;
	
BEGIN
	--RELACIONAMOS LAS ENTRADAS Y SALIDAS
	instancia:  COMPONENT CircuitoCombinacional 
		PORT MAP( 
			res 		=> res,
			cero 		=> cero,
			desbordamiento 	=> desbordamiento,
			signo 		=> signo,
			a 		=> a,
			b 		=> b,
			cin 		=> cin
		);

	
	test: PROCESS
		--VARIABLES A UTILIZAR EN EL PROCESO TEST
		variable vectorPrueba		: signed(n*2 downto 0) := (others=>'0');
		variable varA, varB, S		: signed(n-1 downto 0);
		variable varC 			: signed(n-1 downto 0) := (others=>'0');
		variable AuxA, AuxB		: integer := 0;
		variable int1			: integer;

		BEGIN	
			--SE RECORRERÁ ESTÉ BUCLE TANTAS VECES COMO 2^(N*2)+1, PARA PODER CONTAR CON TODOS LOS VALORES POSIBLES
			FOR i IN 1 TO 2 ** ((n*2)+1) LOOP

				--ESTE BUCLE LE DA VALOR A B, UTILIZAMOS AUXB COMO INDICE
				FOR j IN 1 TO n LOOP
					varA(AuxB) := vectorPrueba(j);
					AuxB := AuxB+1;
				END LOOP;

				--DEVOLVEMOS VALOR 0 A AUXB
					AuxB := 0;

				--ESTE BUCLE LE DA VALOR A A, UTILIZAMOS AUXA COMO INDICE
		 		FOR k IN n+1 TO n*2 LOOP
					varB(AuxA) := vectorPrueba(k);
					AuxA := AuxA+1;
				END LOOP;

				--DEVOLVEMOS 0 A AUXA
				AuxA := 0;
				--A CIN LE DAREMOS EL VALOR DEL BIT MAS BAJO DE VECTORPRUEBA
				a <= varA;
				b <= varB;
				cin <= vectorPrueba(0);
				
				if(vectorPrueba(0) = '1')then
					varC(0) := '1';
				else
					varC(0) := '0';
				end if;

				S := varA + varB + varC;
				int1 := to_integer(varA)+to_integer(varB);
				
				--CONDICIONAL QUE VERIFICARÁ SI EL RESULTADO ES CORRECTO O NO, EN CASO DE NO SERLO, SUMARÁ 1 AL NÚMERO DE ERRORES TOTALES
				if(vectorPrueba(0) = '1')then
					int1 := int1+1;
				end if;

				if(int1 = to_integer(S))then
				else
					report "Resultado esperado INCORRECTO, se esperaba " & integer'image(int1) & " y el resultado ha sido " & integer'image(to_integer(S));
					errores <= errores+1;
				end if;

				--ESPERAMOS 5 NS PARA INICIAR EL BUCLE PRINCIPAL DE NUEVO
				wait for 5 ns;

				--LE SUMAMOS 1 AL VECTOR DE PRUEBA, A TRAVÉS DEL CUAL TOMAMOS LOS BITS PARA NUESTRAS PALABRAS, 
				--ES DECIR, SI CADA PALABRA SON 4 BITS, Y TENEMOS 2 PALABRAS, NECESITAREMOS 2*4 BITS + 1 BIT DE CIN
				--PARA CONTAR CON TODOS LOS VALORES POSIBLES DE TEST, POR ELLO ESTE VECTOR SERÍA EN ESTE CASO DE 9 BITS.
				vectorPrueba := vectorPrueba + 1;
					
			END LOOP;	
				  --REPORT FINAL CON EL NÚMERO DE ERRORES TOTALES
				  report "Test completado con " & integer'image(errores) & " errores";
			WAIT;
		END PROCESS test;
END ARCHITECTURE;