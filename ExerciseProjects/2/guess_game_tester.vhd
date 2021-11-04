-- Tester program for guess game
library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity guess_game_tester is
	port
	(
		SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(2 downto 0);
		
		HEX0 : out std_logic_vector(6 downto 0);
		HEX1 : out std_logic_vector(6 downto 0)
	);
end guess_game_tester;

architecture guess_game_tester_impl of guess_game_tester is

begin
DUT : entity guess_game
	port map
	(
		-- inputs 
		inputs => SW,
		set => KEY(0),
		show => KEY(1),
		try => KEY(2),
		-- outputs
		hex1 => HEX0,
		hex10 => HEX1
		
	);
end guess_game_tester_impl;

