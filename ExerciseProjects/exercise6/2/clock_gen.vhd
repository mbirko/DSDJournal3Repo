LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY clock_gen IS
	GENERIC (
		MIN_COUNT : NATURAL := 0; -- min og max count for tæller
		MAX_COUNT : NATURAL := 50000000
	);
	PORT (
		-- Input ports
		clk : IN STD_LOGIC;
		speed : IN STD_LOGIC;
		reset : IN STD_LOGIC;

		-- Output ports
		clk_out : OUT STD_LOGIC
	);
END clock_gen;

ARCHITECTURE clock_gen_impl OF clock_gen IS
BEGIN

	clkProces : PROCESS (clk, reset)
		VARIABLE cnt : INTEGER RANGE MIN_COUNT TO MAX_COUNT;
		VARIABLE clkOutSignal : STD_LOGIC;
	BEGIN
		-- asynkron reset
		IF reset = '0' THEN
			-- Reset the counter to 0 
			cnt := 0;
			clkOutSignal := '0';

		ELSIF (rising_edge(clk)) THEN
			-- increment counter
			cnt := cnt + 1;
			-- speed mode 1 for 1 sec clk pulse 
			IF (speed = '1') THEN
				IF (cnt = MAX_COUNT) THEN
					cnt := 0;
					clkOutSignal := '1';
				ELSE
					clkOutSignal := '0';
				END IF;
				-- speed mode 0 for 5 ms clk pulse	
			ELSIF (speed = '0') THEN
				IF (cnt = (MAX_COUNT/200)) THEN
					cnt := 0;
					clkOutSignal := '1';
				ELSE
					clkOutSignal := '0';
				END IF;
			END IF;
		END IF;
		clk_out <= clkOutSignal;
	END PROCESS;
END clock_gen_impl;