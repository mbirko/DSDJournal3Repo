-- Tester program for guess game
library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity guess_game_tester is
	port
	(
		SW : in std_logic_vector(7 downto 0);
		KEY : in std_logic_vector(3 downto 0);
		hex1 : out std_logic_vector(6 downto 0);
		hex0 : out std_logic_vector(6 downto 0)
	);
end guess_game_tester;