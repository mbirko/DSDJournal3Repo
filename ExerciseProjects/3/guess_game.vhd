library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity guess_game is
	port
	(
		inputs : in std_logic_vector(7 downto 0);
		-- set input, used to save secret value
		set : in std_logic; 
		-- try input, used to test a guess with compare process
		try : in std_logic; 
		-- show the secret value is displayed
		show : in std_logic; 
		-- 7Seg incoded vector for the least sigificant display, DisLow
		hex1 : out std_logic_vector(6 downto 0); 
		-- 7Seg vector for the most sigificant display, DisLow
		hex10 : out std_logic_vector(6 downto 0) 
	);
end guess_game;

architecture guess_game_imple of guess_game is
	
	-- secret value is stored from input when set is pressed
	signal secret_value : std_logic_vector(7 downto 0); 
	-- the least sigificant displays number in binary. 
	signal numDisLow : std_logic_vector(3  downto 0); 		
	-- the most signicant displays number in binary.
	signal numDisHigh : std_logic_vector(3  downto 0); 		
	-- the combination of the two 7seg encoded numbers. 
	signal hexOut : std_logic_vector(13 downto 0);
	-- ustores the result of the comparetion 
	signal isTrue : std_logic_vector(1 downto 0); 			
	
begin

	setLatch :  PROCESS(set) -- latsh that stores the secret_value when set is pressed
	begin
		if set = '0' then
			secret_value(7 downto 0) <= inputs(7 downto 0);
		end if ;
	end PROCESS ; -- setLatch
	
	--
	showMux : PROCESS(show)	-- shows input as defualt, shows secret value when show is pressed
	begin
		if show = '0' then
			numDisLow(3 downto 0) <= secret_value(3 downto 0);
			numDisHigh(3 downto 0) <= secret_value(7 downto 4);
		else 
			numDisLow(3 downto 0) <= inputs(3 downto 0);
			numDisHigh(3 downto 0) <= inputs(7 downto 4);
		end if ;
	end PROCESS ; -- showMux

	
	compareLogic : PROCESS(try)
	begin 
		if try = '0' then
			if secret_value = inputs then -- send 1 if the guess is spot on
				isTrue <= "01";
			elsif secret_value > inputs then -- send 2 if the guess needs to be lower
				isTrue <= "10";
			elsif secret_value < inputs then  -- send 3 if the guess needs to be higher
				isTrue <= "11";
			end if ;
		else
			isTrue <= "00"; -- if not any of the above, do send zero
		end if ;	
	end PROCESS ; -- compareLogic

	
	
	disLow : ENTITY bin2hex -- least sigificant binary to 7seg encoder
		PORT MAP
			(
				bin => numDisLow,
				seg => hexOut(6 downto 0)
			);
	 
	disHigh : ENTITY bin2hex -- most sigificant binary to 7seg encoder 
		PORT MAP
		(
			bin => numDisHigh,
			seg => hexOut(13 downto 7)
		);
	
	displayMux : PROCESS (istrue)
	begin 
		if isTrue = "00" then -- if istrue is 0, show input or secret_value depending on showMux
			hex1 <= hexOut(6 downto 0);
			hex10 <= hexOut(13 downto 7);			
		elsif isTrue = "01" then -- if isTrue is 1, show -- for correct guess
			hex1  <= "0111111"; -- '-'
			hex10 <= "0111111";
		elsif isTrue = "10" then -- if isTrue is 2, Lo for try lower guess 
			hex1  <= "1000000"; -- 'L'		
			hex10 <= "1000111";		
		elsif isTrue = "11" then  -- if isTrue is 3, show Hi for try higher guess
			hex1  <= "1001111";	-- 'H'
			hex10 <= "0001001"; -- 
		end if;	 
	end PROCESS;
end guess_game_imple; 

