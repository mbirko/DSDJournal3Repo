library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

ENTITY bin2hex_tester IS
	PORT 
	(
		-- Input ports		
		SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		-- Output ports
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END bin2hex_tester;

ARCHITECTURE bin2hex_tester_impl OF bin2hex_tester IS
BEGIN
DUT : ENTITY bin2hex
	PORT MAP
	(
		bin => SW(3 DOWNTO 0),
		seg => HEX0 (6 DOWNTO 0)
	);
END bin2hex_tester_impl;

