

library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity guess_game is
	port
	(
		inputs : in std_logic_vector(7 downto 0);
		set : in std_logic;
		try : in std_logic;
		show : in std_logic;
		hex1 : out std_logic_vector(6 downto 0);
		hex10 out std_logic_vector(6 downto 0)
	);
end guess_game;


architecture guess_game_imple of guess_game is
	
	
	signal secret_value : std_logic_vector(7 downto 0);
	variable buttons : std_logic_vector(2 downto 0) := set & try & show; 
	variable inputLow : std_logic_vector(3 downto 0) := 
	dis1 : ENTITY bin2hex
	PORT MAP
		(
			
		);
	dis2 : ENTITY bin2hex
	begin
		displayMux : PROCESS (buttons, inputs)
		begin 
		if buttons = '100' then 
			

			
		end if ;
	




end guess_game_imple ; -- uess_game_imple

