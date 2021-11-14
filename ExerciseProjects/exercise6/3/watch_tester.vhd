library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity watch_tester is
	port map
	(
		-- Input ports
		KEY		: in  std_logic_vector(3 downto 0);
		SW			: in  std_logic_vector(17 downto 16);
		CLOCK_50 : in 	std_logic; 
		-- Output ports
		HEX2		: out std_logic_vector(6 downto 0);
		HEX3		: out std_logic_vector(6 downto 0);
		HEX4		: out std_logic_vector(6 downto 0);
		HEX5		: out std_logic_vector(6 downto 0);
		HEX6		: out std_logic_vector(6 downto 0);
		HEX7		: out std_logic_vector(6 downto 0);

	);

end watch_tester;

architecture watch_tester_impl of watch_tester is

begin
	port map
	(
		clk 						=> CLOCK_50,
		speed 					=> KEY(0),
		reset 					=> KEY(3),
		sec_1(6 downto 0) 	=> HEX2(6 downto 0),
		sec_10(6 downto 0) 	=> HEX3(6 downto 0),
		min_1(6 downto 0) 	=> HEX4(6 downto 0),
		min_10(6 downto 0) 	=> HEX5(6 downto 0),
		hrs_1(6 downto 0) 	=> HEX6(6 downto 0),
		hrs_10(6 downto 0) 	=> HEX7(6 downto 0),
	);

end watch_tester_impl;