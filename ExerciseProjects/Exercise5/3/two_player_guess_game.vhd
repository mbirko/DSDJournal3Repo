LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY two_player_guess_game IS
	PORT (

		--	Gameplay 
		--	-- Setup 
		--	Player zero inputs secret value with switch to 0. 
		--  Player one inputs secret value with switch to 1. 
		--	
		--	-- Game - the game can now start. 
		--	1. player zero makes a guess with switch to 1, and compares it. 
		--     If the guess is correct  -> 3 if not -> 2
		--	2. Player one then makes a guess with switch to 0 and compare. 
		--     If the guess is correct  -> x if not -> 1
		--	3. This player have one! guessing the number before the other

		-- Input ports
		
		inputs : in std_logic_vector(7 downto 0);
		-- Set input, used to save secret value
		set : in std_logic; 
		-- Try input, used to test a guess with compare process
		try : in std_logic; 
		-- Show the secret value is displayed
		show : in std_logic; 
		-- Detminens what plays input and outputs is used
		player : IN STD_LOGIC; 
		-- 7Seg incoded vector for the least sigificant display, DisLow

		-- output ports
		hex1 : out std_logic_vector(6 downto 0); 
		-- 7Seg vector for the most sigificant display, DisLow
		hex10 : out std_logic_vector(6 downto 0); 
		-- Displays who is currently playing
		hex_p : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) 
	);

END two_player_guess_game;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ARCHITECTURE two_player_guess_game_impl OF two_player_guess_game IS

	-- player zero signals 
	SIGNAL buttonsP0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL inputsP0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL hexOutP0 : STD_LOGIC_VECTOR(13 DOWNTO 0);

	-- player one signals 
	SIGNAL buttonsP1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL inputsP1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL hexOutP1 : STD_LOGIC_VECTOR(13 DOWNTO 0);

BEGIN

	playerPlaying : PROCESS (player)
	BEGIN
		CASE player IS

			WHEN '1' => buttonsP1(0) <= set;
				buttonsP1(1) <= show;
				buttonsP1(2) <= try;
				inputsP1 <= inputs;

			WHEN '0' => buttonsP0(0) <= set;
				buttonsP0(1) <= show;
				buttonsP0(2) <= try;
				inputsP0 <= inputs;

			WHEN OTHERS => NULL;
		END CASE;
	END PROCESS;
	P0 : ENTITY guess_game
		PORT MAP
		(
			inputs => inputsP0, -- 
			set => buttonsP0(0),
			show => buttonsP0(1),
			try => buttonsP0(2),
			hex1 => hexOutP0(6 DOWNTO 0),
			hex10 => hexOutP0(13 DOWNTO 7)
		);

	P1 : ENTITY guess_game
		PORT MAP
		(
			inputs => inputsP1,
			set => buttonsP1(0),
			show => buttonsP1(1),
			try => buttonsP1(2),
			hex1 => hexOutP1(6 DOWNTO 0), -- 7Seg incoded vector for the least sigificant display, DisLow
			hex10 => hexOutP1(13 DOWNTO 7)-- 7Seg vector for the most sigificant display, DisLow
		);

	muxPlayerToDisplay : PROCESS (player)
		VARIABLE temp : STD_LOGIC_VECTOR(13 DOWNTO 0);
	BEGIN
		IF player = '0' THEN
			temp(6 DOWNTO 0) := hexOutP0(6 DOWNTO 0); -- 7Seg incoded vector for the least sigificant display, DisLow
			temp(13 DOWNTO 7) := hexOutP0(13 DOWNTO 7);
		ELSIF player = '1' THEN
			temp(6 DOWNTO 0) := hexOutP1(6 DOWNTO 0); -- 7Seg incoded vector for the least sigificant display, DisLow
			temp(13 DOWNTO 7) := hexOutP1(13 DOWNTO 7);
		ELSE
			hex1 <= "0101111";
			hex10 <= "0000110";
		END IF;
		hex1 <= temp(6 DOWNTO 0);
		hex10 <= temp(13 DOWNTO 7);
	END PROCESS;

	hex_p_ent : ENTITY bin2hex
		PORT MAP
		(
			bin => '0' & '0' & '0' & player,
			seg => hex_p
		);

END two_player_guess_game_impl;