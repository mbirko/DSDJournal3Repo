LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY alarm_watch_tester IS
	PORT (
		-- Input ports
		CLOCK_50 : IN STD_LOGIC;
		KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		SW : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

		-- Output ports
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		LEDR0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
	);

END alarm_watch_tester;

ARCHITECTURE alarm_watch_tester_impl OF alarm_watch_tester IS

	SIGNAL tm_alarm : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL dis_alarm : STD_LOGIC_VECTOR(27 DOWNTO 0);
	SIGNAL dis_time : STD_LOGIC_VECTOR(41 DOWNTO 0);
	SIGNAL tm_time : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN

	-- Instance of watch
	ur : ENTITY watch
		PORT MAP
		(
			clk => CLOCK_50,
			speed => KEY(0),
			reset => KEY(3),
			tm => tm_time,
			currentTime => dis_time
		);
	
	limit : ENTITY timeInputLimiter
		PORT MAP(
			input => sw(15 DOWNTO 0),
			output => tm_alarm
		);

	alarmBin2Hex : ENTITY four_hex_display
		PORT MAP(
			binInput => tm_alarm,
			disOutput => dis_alarm
		);
	compare : entity compareVector
	  port map (
		i1 => tm_time,
		i2 => tm_alarm, 
		o1 => LEDR0
	  );

	viewSetAlarm : process(KEY(2))
	begin
		case( KEY(2) ) is
			when '1' => 	HEX2 <= dis_time(6 downto 0);
							HEX3 <= dis_time(13 downto 7);
							HEX4 <= dis_time(20 downto 14);
							HEX5 <= dis_time(27 downto 21);
							HEX6 <= dis_time(34 downto 28);
							HEX7 <= dis_time(41 downto 35);
			when '0' => 	HEX2 <= "1111111";
							HEX3 <= "1111111";
							HEX4 <= dis_alarm(6 downto 0);
							HEX5 <= dis_alarm(13 downto 7);
							HEX6 <= dis_alarm(20 downto 14);
							HEX7 <= dis_alarm(27 downto 21);
			when others => 	HEX2 <= "0000110"; -- r
							HEX3 <= "0101111"; -- o
							HEX4 <= "0101111"; -- r
							HEX5 <= "0100011"; -- r
							HEX6 <= "0101111"; -- E 
							HEX7 <= "0111111"; -- -
						
							     
		end case ;
		
	end process ; -- viewSetAlarm



END alarm_watch_tester_impl;