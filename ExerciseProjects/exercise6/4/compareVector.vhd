library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;


ENTITY compareVector IS
	GENERIC (
		VECTOR_SIZE : INTEGER := 16
	);
	PORT (
		-- Input ports
		i1 : IN STD_LOGIC_VECTOR(VECTOR_SIZE-1 DOWNTO 0);
		i2 : IN STD_LOGIC_VECTOR(VECTOR_SIZE-1 DOWNTO 0);
		-- Output ports
		o1 : OUT STD_LOGIC_vector(0 downto 0)
	);
END compareVector;

ARCHITECTURE compareVector_impl OF compareVector IS
BEGIN
	compare : PROCESS (i1, i2)
	BEGIN
		IF i1 = i2 THEN
			o1 <= "1";
		ELSE
			o1 <= "0";
		END IF;
	END PROCESS; -- compare
END compareVector_impl; -- compareVector_impl