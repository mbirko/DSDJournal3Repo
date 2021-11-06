-- Tester program for two player guess game
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;

ENTITY two_player_guess_game_tester IS
	PORT (
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		-- 7seg displays for game
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		-- Hex displays turned off 
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
		-- Hex display for player number 
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		-- Hex display displaying "P"
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "0001100";
		-- Hex displays turned off 
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111"
	);
END two_player_guess_game_tester;

ARCHITECTURE two_player_guess_game_tester_impl OF two_player_guess_game_tester IS
BEGIN
	DUT : ENTITY two_player_guess_game
		PORT MAP
		(
			-- Inputs 
			player => SW(17),
			inputs(7 DOWNTO 0) => SW(7 DOWNTO 0),
			set => KEY(0),
			show => KEY(1),
			try => KEY(2),
			-- Outputs
			hex1 => HEX0,
			hex10 => HEX1,
			hex_p => HEX4

		);
END two_player_guess_game_tester_impl;