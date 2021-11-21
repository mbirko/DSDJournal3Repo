library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity watch is

	port
	(
		-- Input ports
		clk		: in  std_logic;
		speed		: in  std_logic;
		reset 	: in  std_logic;

		-- Output ports
		currentTime : out std_logic_vector(41 downto 0);
		tm : out std_logic_vector(15 downto 0)
	);
end watch;

architecture watch_impl of watch is

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
			seg => currentTime( 6 downto 0)
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
			seg => currentTime( 13 downto 7)
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
			seg => currentTime( 20 downto 14)
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
			seg => currentTime( 27 downto 21)
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
			seg => currentTime( 34 downto 28)
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
			seg => currentTime( 41 downto 35)
		);

		tm(3 downto 0) <= count_min_1;
		tm(7 downto 4)  <= count_min_10;
		tm(11 downto 8)  <= count_hrs_1;
		tm(15 downto 12)  <= count_hrs_10;
END watch_impl;

