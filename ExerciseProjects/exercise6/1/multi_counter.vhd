LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY multi_counter IS
	GENERIC (
		MIN_COUNT : NATURAL := 0; -- min limit for counter
		MAX_COUNT : NATURAL := 10 -- max limit for counter
	);

	PORT (
		-- Input ports
		clk : IN STD_LOGIC;
		mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		reset : IN STD_LOGIC;

		-- Output ports
		count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		cout : OUT STD_LOGIC
	);
END multi_counter;

ARCHITECTURE multi_counter_impl OF multi_counter IS

BEGIN
	-- counter_proc is sensetive to both clock and reset
	counter_proc : PROCESS (clk, reset)
	-- variebles for imidiate updating of counter variables.
		-- varieble max_value to switch between modes. 
		VARIABLE max_value : NATURAL;
		-- limiting the range of cnt between MIN_COUNT and MAX_COUNT
		VARIABLE cnt : INTEGER RANGE MIN_COUNT TO MAX_COUNT;
		-- carrry out varieble
		VARIABLE cout_temp : STD_LOGIC;
	BEGIN
		-- asynkron reset, not dependten on clock
		IF reset = '0' THEN
			-- Reset the counter and cout to 0 
			cnt := 0;
			cout_temp := '0';
			-- on rasing edge of clk, count up
		ELSIF (rising_edge(clk)) THEN
			cnt := cnt + 1;
			-- setting max_value based on mode
			CASE mode IS
					-- count to 9	
				WHEN "00" => max_value := MAX_COUNT;
					-- count to 5
				WHEN "01" => max_value := MAX_COUNT/2;
					-- count to 2
				WHEN "10" => max_value := MAX_COUNT/3;
					-- count to 2
				WHEN "11" => max_value := MAX_count/3;
			END CASE;
			-- limitign and couting 
			IF (cnt >= max_value) THEN
				cnt := 0;
				cout_temp := '1';
			ELSE
				cout_temp := '0';
			END IF;
		END IF;
		-- Output the current count
		count <= STD_LOGIC_VECTOR(to_unsigned(cnt, count'length));
		-- Output cout--
		cout <= cout_temp;
	END PROCESS counter_proc;
END multi_counter_impl;