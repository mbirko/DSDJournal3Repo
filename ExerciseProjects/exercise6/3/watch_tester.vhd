LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY watch_tester IS
	PORT (
		-- Input ports
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CLOCK_50 : IN STD_LOGIC;
		-- Output ports
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111"; -- off
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111"; -- off
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END watch_tester;

ARCHITECTURE watch_tester_impl OF watch_tester IS
BEGIN
	DUT : ENTITY watch
		PORT MAP
		(
			clk => CLOCK_50,
			speed => KEY(0),
			reset => KEY(3),
			sec_1(6 DOWNTO 0) => HEX2(6 DOWNTO 0),
			sec_10(6 DOWNTO 0) => HEX3(6 DOWNTO 0),
			min_1(6 DOWNTO 0) => HEX4(6 DOWNTO 0),
			min_10(6 DOWNTO 0) => HEX5(6 DOWNTO 0),
			hrs_1(6 DOWNTO 0) => HEX6(6 DOWNTO 0),
			hrs_10(6 DOWNTO 0) => HEX7(6 DOWNTO 0)
		);
END watch_tester_impl;