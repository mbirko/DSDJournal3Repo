LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY two_player_guess_game IS
	PORT (

		--		gameplay 
		--		-- setup 
		--		player zero sets the player siwtch to one(the other player), and inputs secrect value the other player should guess. 
		--		player one then sets the player sets the secrete value on player zero
		--		
		--		-- game - the game can npw start. 
		--		1. player zero makes a guess and compares it. if the guess is correct  -> x if not -> 2
		--		2. player one then makes a guess and compare. if the guess is correct  -> x if not -> 1
		--		3. This player have one! guessing the number before the other

		-- Input ports
		inputs : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		set : IN STD_LOGIC; -- if one, store secret value form inputs
		try : IN STD_LOGIC; -- if one, compare secret value with input and display Hi, Lw or --(correct)
		show : IN STD_LOGIC; -- show the secret value is displayed
		player : IN STD_LOGIC; -- detmins what plays input and outputs is shown

		hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- 7Seg incoded vector for the least sigificant display, DisLow
		hex10 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0); -- 7Seg vector for the most sigificant display, DisLow
		hex_p : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) -- displays who is currently playing

	);

END two_player_guess_game;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ARCHITECTURE two_player_guess_game_impl OF two_player_guess_game IS

	SIGNAL secret_value : STD_LOGIC_VECTOR(7 DOWNTO 0); -- secret value is stored from input when set is pressed
	SIGNAL numDisLow : STD_LOGIC_VECTOR(3 DOWNTO 0); -- the least sigificant displays number, that needs to be encoded to 7Seg. 
	SIGNAL numDisHigh : STD_LOGIC_VECTOR(3 DOWNTO 0); -- the most signicant displays number, that needs to be encoded to 7 seg.
	SIGNAL hexOut : STD_LOGIC_VECTOR(13 DOWNTO 0); -- the combination of the two 7seg encoded numbers. 
	SIGNAL isTrue : STD_LOGIC_VECTOR(1 DOWNTO 0);

	-- player zero signals 
	SIGNAL buttonsP0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL inputsP0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL hexOutP0 : STD_LOGIC_VECTOR(13 DOWNTO 0);

	-- player one signals 
	SIGNAL buttonsP1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL inputsP1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL hexOutP1 : STD_LOGIC_VECTOR(13 DOWNTO 0);

BEGIN

	playerPlaying : PROCESS (player) -- 
	begin
		IF player = '1' THEN
		
			buttonsP1(0) <= set;
			buttonsP1(1) <= try;
			buttonsP1(2) <= show;
			inputsP1 <= inputs;
			
		ELSIF player = '0' THEN
			buttonsP0(0) <= set;
			buttonsP0(1) <= try;
			buttonsP0(2) <= show;
			inputsP0 <= inputs;
		ELSE
			buttonsP0(0) <= '0';
			buttonsP0(1) <= '0';
			buttonsP0(2) <= '0';
			inputsP0 <= "00000000";
			
			buttonsP1(0) <= '0';
			buttonsP1(1) <= '0';
			buttonsP1(2) <= '0';
			inputsP1 <= "00000000";
		END IF;

	END PROCESS;

	P0 : ENTITY guess_game
		PORT MAP
		(
			inputs => inputsP1,
			set => buttonsP0(0), -- if one, store secret value form inputs
			try => buttonsP0(1), -- if one, compare secret value with input and display Hi, Lw or --(correct)
			show => buttonsP0(2), -- show the secret value is displayed
			hex1 => hexOutP0(6 DOWNTO 0), -- 7Seg incoded vector for the least sigificant display, DisLow
			hex10 => hexOutP0(13 DOWNTO 7)-- 7Seg vector for the most sigificant display, DisLow
		);
		
	P1 : ENTITY guess_game
		PORT MAP
		(
			inputs => inputsP1,
			set => buttonsP1(0), -- if one, store secret value form inputs
			try => buttonsP1(1), -- if one, compare secret value with input and display Hi, Lw or --(correct)
			show => buttonsP1(2), -- show the secret value is displayed
			hex1 => hexOutP1(6 DOWNTO 0), -- 7Seg incoded vector for the least sigificant display, DisLow
			hex10 => hexOutP1(13 DOWNTO 7)-- 7Seg vector for the most sigificant display, DisLow
		);

	muxPlayerToDisplay : PROCESS (player)
	begin
		IF player = '0' THEN
			hex1 <= hexOutP0(6 DOWNTO 0); -- 7Seg incoded vector for the least sigificant display, DisLow
			hex10 <= hexOutP0(13 DOWNTO 7);
		ELSIF player = '1' THEN
			hex1 <= hexOutP1(6 DOWNTO 0); -- 7Seg incoded vector for the least sigificant display, DisLow
			hex10 <= hexOutP1(13 DOWNTO 7);
		ELSE
			hex1 <= "0101111"; -- 7Seg incoded vector for the least sigificant display, DisLow
			hex10 <= "0000110";
		END IF;
	END PROCESS;

	hex_p_ent : ENTITY bin2hex
		PORT MAP
		(
			bin => '0' &'0' & '0' & player,
			seg => hex_p
		); 

	END two_player_guess_game_impl;