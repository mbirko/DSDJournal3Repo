library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity guess_game is
	port
	(
		inputs : in std_logic_vector(7 downto 0);
		set : in std_logic; -- if one, store secret value form inputs
		try : in std_logic; -- if one, compare secret value with input and display Hi, Lw or --(correct)
		show : in std_logic; -- show the secret value is displayed
		hex1 : out std_logic_vector(6 downto 0); -- 7Seg incoded vector for the least sigificant display, DisLow
		hex10 : out std_logic_vector(6 downto 0) -- 7Seg vector for the most sigificant display, DisLow
	);
end guess_game;

architecture guess_game_imple of guess_game is
		
	signal secret_value : std_logic_vector(7 downto 0); -- secret value is stored from input when set is pressed
	signal numDisLow : std_logic_vector(3  downto 0); -- the least sigificant displays number, that needs to be encoded to 7Seg. 
	signal numDisHigh : std_logic_vector(3  downto 0); -- the most signicant displays number, that needs to be encoded to 7 seg.
	signal hexOut : std_logic_vector(13 downto 0); -- the combination of the two 7seg encoded numbers. 
	signal isTrue : std_logic_vector(1 downto 0); -- ustores the result of the comparetion 
	
begin

	setLatch :  process(set) -- latsh that stores the secret_value when sectec when set is pressed
	begin
		if set = '1' then
			secret_value(7 downto 0) <= inputs(7 downto 0);
		end if ;
	end process ; -- setLatch
	
	--
	showMux : process(show)	-- shows input as defualt, shows secret value when show is pressed
	begin
		if show = '1' then
			numDisLow(3 downto 0) <= secret_value(3 downto 0);
			numDisHigh(3 downto 0) <= secret_value(7 downto 4);
		else 
			numDisLow(3 downto 0) <= inputs(3 downto 0);
			numDisHigh(3 downto 0) <= inputs(7 downto 4);
		end if ;
	end process ; -- showMux

	
	compareLogic : process(try)
	begin 
		if try = '1' then
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
	end process ; -- compareLogic

	
	
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
			hex1 <= hexOut(13 downto 7);			
		elsif isTrue = "01" then -- if isTrue is 1, show -- for correct guess
			hex1  <= "0111111"; -- '-'
			hex10 <= "0111111";
		elsif isTrue = "10" then -- if isTrue is 2, Lo for try lower guess 
			hex1  <= "1000111"; -- 'L'		
			hex10 <= "1000000";		
		elsif isTrue = "11" then  -- if isTrue is 3, show Hi for try higher guess
			hex1  <= "0001001"; -- 'H'
			hex10 <= "0001111";	-- 
		end if;	 
	end process;
end guess_game_imple; 

