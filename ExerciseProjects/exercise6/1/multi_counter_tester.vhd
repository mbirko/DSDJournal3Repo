LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY multi_counter_tester IS
	PORT (
		-- Input ports
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 16);
		-- Output ports
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- counter value
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";-- off
		LEDR : OUT STD_LOGIC_VECTOR(0 DOWNTO 0) -- carry out
	);
END multi_counter_tester;

ARCHITECTURE multi_counter_impl_tester OF multi_counter_tester IS
	SIGNAL countSignal : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
	DUT : ENTITY multi_counter
		PORT MAP
		(
			count => countSignal,
			cout => LEDR(0),
			clk => KEY(0),
			mode => SW,
			reset => KEY(3)
		);

	hexDisp : ENTITY bin2hex
		PORT MAP
		(
			bin => countSignal,
			seg => HEX0
		);
END multi_counter_impl_tester;