LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY guess_game IS
	PORT (
		inputs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		-- set input, used to save secret value
		set : IN STD_LOGIC;
		-- try input, used to test a guess with compare process
		try : IN STD_LOGIC;
		-- show the secret value is displayed
		show : IN STD_LOGIC;
		-- 7Seg incoded vector for the least sigificant display, DisLow
		hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		-- 7Seg vector for the most sigificant display, DisLow
		hex10 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END guess_game;

ARCHITECTURE guess_game_imple OF guess_game IS

	-- secret value is stored from input when set is pressed
	SIGNAL secret_value : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-- the least sigificant displays number in binary. 
	SIGNAL numDisLow : STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- the most signicant displays number in binary.
	SIGNAL numDisHigh : STD_LOGIC_VECTOR(3 DOWNTO 0);
	-- the combination of the two 7seg encoded numbers. 
	SIGNAL hexOut : STD_LOGIC_VECTOR(13 DOWNTO 0);
	-- ustores the result of the comparetion 
	SIGNAL isTrue : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

	setLatch : PROCESS (set) -- latsh that stores the secret_value when set is pressed
	BEGIN
		IF set = '0' THEN
			secret_value(7 DOWNTO 0) <= inputs(7 DOWNTO 0);
		END IF;
	END PROCESS; -- setLatch

	--
	showMux : PROCESS (show) -- shows input as defualt, shows secret value when show is pressed
	BEGIN
		IF show = '0' THEN
			numDisLow(3 DOWNTO 0) <= secret_value(3 DOWNTO 0);
			numDisHigh(3 DOWNTO 0) <= secret_value(7 DOWNTO 4);
		ELSE
			numDisLow(3 DOWNTO 0) <= inputs(3 DOWNTO 0);
			numDisHigh(3 DOWNTO 0) <= inputs(7 DOWNTO 4);
		END IF;
	END PROCESS; -- showMux
	compareLogic : PROCESS (try)
	BEGIN
		IF try = '0' THEN
			IF secret_value = inputs THEN -- send 1 if the guess is spot on
				isTrue <= "01";
			ELSIF secret_value > inputs THEN -- send 2 if the guess needs to be lower
				isTrue <= "10";
			ELSIF secret_value < inputs THEN -- send 3 if the guess needs to be higher
				isTrue <= "11";
			END IF;
		ELSE
			isTrue <= "00"; -- if not any of the above, do send zero
		END IF;
	END PROCESS; -- compareLogic

	disLow : ENTITY bin2hex -- least sigificant binary to 7seg encoder
		PORT MAP
		(
			bin => numDisLow,
			seg => hexOut(6 DOWNTO 0)
		);

	disHigh : ENTITY bin2hex -- most sigificant binary to 7seg encoder 
		PORT MAP
		(
			bin => numDisHigh,
			seg => hexOut(13 DOWNTO 7)
		);

	displayMux : PROCESS (istrue)
	BEGIN
		IF isTrue = "00" THEN -- if istrue is 0, show input or secret_value depending on showMux
			hex1 <= hexOut(6 DOWNTO 0);
			hex10 <= hexOut(13 DOWNTO 7);
		ELSIF isTrue = "01" THEN -- if isTrue is 1, show -- for correct guess
			hex1 <= "0111111"; -- '-'
			hex10 <= "0111111";
		ELSIF isTrue = "10" THEN -- if isTrue is 2, Lo for try lower guess 
			hex1 <= "1000000"; -- 'L'		
			hex10 <= "1000111"; -- 'o'
		ELSIF isTrue = "11" THEN -- if isTrue is 3, show Hi for try higher guess
			hex1 <= "1001111"; -- 'H'
			hex10 <= "0001001"; -- 'i'
		END IF;
	END PROCESS;
END guess_game_imple;