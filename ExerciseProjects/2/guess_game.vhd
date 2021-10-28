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
		hex0 : out std_logic_vector(6 downto 0)
	);
end guess_game;

architecture guess_game_imple of guess_game is
		
	signal secret_value : std_logic_vector(7 downto 0);
	signal numDisLow : std_logic_vector(3  downto 0); 
	signal numDisHigh : std_logic_vector(3  downto 0); 
	signal numDis : std_logic_vector(13 downto 0) 
	signal isTrue : std_logic;

	disLow : ENTITY bin2hex
		PORT MAP
			(
				bin <= numDisLow;
				seg => numDis(6 downto 0)
			);
			
	disHigh : ENTITY bin2hex
		PORT MAP
		(
			bin <= numDisHigh;
			seg => numDis(13 downto 7)
		);

	setLatch :  process( sensitivity_list)
	begin
		if set = '1' then
			secret_value(7 downto 0) = inputs(7 downto 0);
		end if ;
	end process ; -- setLatch
	
	-- De
	mux1 : process( show, secret_value, inputs)  
	begin
		if show = '1' then
			numDisLow(3 downto 0) = secret_value(3 downto 0);
			numDisHigh(7 downto 4) = secret_value(7 downto 4);
		elsif show = '0' then
			numDisLow(3 downto 0) = inputs(3 downto 0);
			numDisHigh(7 downto 4) = inputs(7 downto 4);
		end if ;
	end process ; -- mux1

	compareLogic : process( try, inputs, secret_value)
	begin
		if try = '1' then
			if secret_value = inputs then 
				isTrue = 1;
			elsif secret_value > inputs then
				isTrue = 2;
			elsif secret_value < inputs then
				isTrue = 3;
			else
				isTrue = 0;
		end if ;	
	end process ; -- compareLogic

	displayMux : PROCESS (buttons, inputs)
	begin 
		if isTrue = '1' then 
			disHigh 
		end if;	
		
		if isTrue = '2' then
		
		end if;
		
		if isTrue = '3' then

		end if ;
	
-- 0001001 1000111 0111111 'H' 'L' '-' 

end guess_game_imple ; -- uess_game_imple

