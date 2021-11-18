-- countOne
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY count_ones IS
	GENERIC (
		BIT_SIZE : INTEGER := 8
	);

	PORT (
		-- Input ports
		A : IN STD_LOGIC_VECTOR(BIT_SIZE - 1 DOWNTO 0);

		-- Output ports		
		HEX : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END count_ones;

ARCHITECTURE count_ones_impl OF count_ones IS
	-- signal passing the counted High bits in input to output
	SIGNAL NumberOfOnes : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

BEGIN

	-- process runs when A one changes 
	P1 : PROCESS (A)
		-- cnt variable to be incremented under procces
		VARIABLE cnt : STD_LOGIC_VECTOR(3 DOWNTO 0);
		-- NOTE: Assigned valeus here will only happen at complietime, not wth every procces.  
	BEGIN
		-- This is assigned at the start of every process 
		cnt := "0000";
		L1 : FOR i IN BIT_SIZE - 1 DOWNTO 0 LOOP
			-- if there is a one, count up, no else = latch. 
			IF A(i) = '1' THEN
				cnt := STD_LOGIC_VECTOR(unsigned(cnt) + "1");
			END IF;
		END LOOP L1;
		-- value sent to Display with signal. 
		NumberOfOnes <= cnt;
	END PROCESS;
	-- entity of bin2hex
	B2H : ENTITY bin2hex
		PORT MAP
		(
			bin => NumberOfOnes,
			seg => HEX
		);

END count_ones_impl;