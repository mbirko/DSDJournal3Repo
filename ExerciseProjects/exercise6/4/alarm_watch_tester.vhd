library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity alarm_watch_tester is
	port
	(
		-- Input ports
		CLOCK_50	: in  std_logic;
		KEY		: in  std_logic_vector(3 downto 0);
		SW			: in	std_logic_vector(15 downto 0);
		
		-- Output ports
		HEX2	: out std_logic_vector(6 downto 0);	
		HEX3	: out std_logic_vector(6 downto 0);	
		HEX4	: out std_logic_vector(6 downto 0);	
		HEX5	: out std_logic_vector(6 downto 0);	
		HEX6	: out std_logic_vector(6 downto 0);	
		HEX7	: out std_logic_vector(6 downto 0);	
		LEDR0 : out std_logic_vector(0 downto 0)	
	);

end alarm_watch_tester;

architecture alarm_watch_tester_impl of alarm_watch_tester is
	signal bin_min1   : std_logic_vector(3 downto 0);
	signal bin_min10  : std_logic_vector(3 downto 0);
	signal bin_hrs1   : std_logic_vector(3 downto 0);
	signal bin_hrs10  : std_logic_vector(3 downto 0);
	signal time_alarm : std_logic_vector(15 downto 0);	
	
	signal hex_min_1	: std_logic_vector(6 downto 0);
	signal hex_min_10	: std_logic_vector(6 downto 0);
	signal hex_hrs_1	: std_logic_vector(6 downto 0);
	signal hex_hrs_10	: std_logic_vector(6 downto 0);
begin

-- Instance of watch
	WATCH : entity watch
		port map
		(
			clk => CLOCK_50,
			speed => KEY(0),
			reset => KEY(3)		
		);
		
-- Instances of bin2sevenseg for handling input
	min_1_bin2hex : entity bin2hex
		port map
		(
			bin => bin_min_1
			seg => hex_min_1
		);

	min_10_bin2hex : entity bin2hex
		port map
		(
			bin => bin_min_10
			seg => hex_min_10
		);
	hrs_1_bin2hex : entity bin2hex
		port map
		(
			bin => bin_hrs_1
			seg => hex_hrs_1
		);

	hrs_10_bin2hex : entity bin2hex
		port map
		(
			bin => bin_hrs_1
			seg => hex_hrs_10
		);
		
-- Compare tm_alarm with tm_watch
	compareProcess : process 

end alarm_watch_tester_impl;