LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY watch IS

	PORT (
		-- Input ports
		clk : IN STD_LOGIC;
		speed : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		-- Output ports
		sec_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		sec_10 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		min_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		min_10 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		hrs_1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		hrs_10 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END watch;

ARCHITECTURE watch_impl OF watch IS
	-- signal from clockgen
	SIGNAL clkOutSignal : STD_LOGIC;
	-- signal from reset logic
	SIGNAL reset_out : STD_LOGIC;

	-- signals from overflow of sec, min and hrs
	SIGNAL cout_sec_1 : STD_LOGIC;
	SIGNAL cout_sec_10 : STD_LOGIC;
	SIGNAL cout_min_1 : STD_LOGIC;
	SIGNAL cout_min_10 : STD_LOGIC;
	SIGNAL cout_hrs_1 : STD_LOGIC;
	SIGNAL cout_hrs_10 : STD_LOGIC;

	-- signals for the value count of sec, min and hrs
	SIGNAL count_sec_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL count_sec_10 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL count_min_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL count_min_10 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL count_hrs_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL count_hrs_10 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	-- RESETLOGIC PROCESS
	RLP : PROCESS (reset, cout_hrs_10, cout_hrs_1)
	BEGIN
		IF reset = '0' THEN
			reset_out <= '0';
		ELSIF (count_hrs_10 = "0010") AND (count_hrs_1 = "0100") THEN
			reset_out <= '0';
		ELSE
			reset_out <= '1';

		END IF;
	END PROCESS RLP;

	-- CLOCKGEN
	clockGen : ENTITY clock_gen
		PORT MAP
		(
			clk => clk,
			speed => speed,
			reset => reset,
			clk_out => clkOutSignal
		);

	-- MULTICOUNTER AND BIN2SEVEN FOR SEC 1
	multiCounter_sec_1 : ENTITY multi_counter
		PORT MAP
		(
			count => count_sec_1,
			clk => clkOutSignal,
			cout => cout_sec_1,
			mode => "00",
			reset => reset_out
		);

	bin2sevenseg_sec_1 : ENTITY bin2hex
		PORT MAP
		(
			bin => count_sec_1,
			seg => sec_1
		);

	-- MULTICOUNTER AND BIN2SEVEN FOR SEC 10
	multiCounter_sec_10 : ENTITY multi_counter
		PORT MAP
		(
			count => count_sec_10,
			clk => cout_sec_1,
			cout => cout_sec_10,
			mode => "01",
			reset => reset_out
		);

	bin2sevenseg_sec_10 : ENTITY bin2hex
		PORT MAP
		(
			bin => count_sec_10,
			seg => sec_10
		);

	-- MULTICOUNTER AND BIN2SEVEN FOR MIN 1
	multiCounter_min_1 : ENTITY multi_counter
		PORT MAP
		(
			count => count_min_1,
			clk => cout_sec_10,
			cout => cout_min_1,
			mode => "00",
			reset => reset_out
		);

	bin2sevenseg_min_1 : ENTITY bin2hex
		PORT MAP
		(
			bin => count_min_1,
			seg => min_1
		);

	-- MULTICOUNTER AND BIN2SEVEN FOR MIN 10
	multiCounter_min_10 : ENTITY multi_counter
		PORT MAP
		(
			count => count_min_10,
			clk => cout_min_1,
			cout => cout_min_10,
			mode => "01",
			reset => reset_out
		);
	bin2sevenseg_min_10 : ENTITY bin2hex
		PORT MAP
		(
			bin => count_min_10,
			seg => min_10
		);

	-- MULTICOUNTER AND BIN2SEVEN FOR HRS 1
	multiCounter_hrs_1 : ENTITY multi_counter
		PORT MAP
		(
			count => count_hrs_1,
			clk => cout_min_10,
			cout => cout_hrs_1,
			mode => "00",
			reset => reset_out
		);
	bin2sevenseg_hrs_1 : ENTITY bin2hex
		PORT MAP
		(
			bin => count_hrs_1,
			seg => hrs_1
		);

	-- MULTICOUNTER AND BIN2SEVEN FOR HRS 10
	multiCounter_hrs_10 : ENTITY multi_counter
		PORT MAP
		(
			count => count_hrs_10,
			clk => cout_hrs_1,
			cout => cout_hrs_10,
			mode => "10",
			reset => reset_out
		);

	bin2sevenseg_hrs_10 : ENTITY bin2hex
		PORT MAP
		(
			bin => count_hrs_10,
			seg => hrs_10
		);

END watch_impl;