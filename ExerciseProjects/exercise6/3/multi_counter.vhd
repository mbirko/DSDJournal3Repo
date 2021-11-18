library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity multi_counter is
generic
	(
		MIN_COUNT : natural := 0; -- MIN AND 
		MAX_COUNT : natural := 10 -- MAX COUNT VALUES
	);

	port
	(
		-- Input ports
		clk	: in  std_logic;
		mode	: in  std_logic_vector(1 downto 0);
		reset : in	std_logic;
		
		-- Output ports
		count	: out std_logic_vector(3 downto 0);
		cout	: out std_logic
	);
end multi_counter;

architecture multi_counter_impl of multi_counter is

begin
counter_proc : process (clk,reset) 
		variable max_value : natural := 10;
		-- VARIABLE USED FOR IMMIDIATE UPDATE OF COUNTER VARIABLE
		variable	cnt	:	integer range MIN_COUNT to MAX_COUNT; 
		variable cout_temp : std_logic;
		
	begin
	-- ASYNC RESET, NOT CLK DEPENDENT
	if reset = '0'  then 
		-- RESET COUNTER TO 0 
		cnt := 0;
		cout_temp := '0';
		
	elsif (rising_edge(clk)) then		
		-- INCREMENT COUNTER
		cnt := cnt + 1;
		-- CHECK MODE AND ASSIGN MAX VALUE
		case mode is
			-- count to 9	
			when "00" => max_value := MAX_COUNT;
			-- count to 5
			when "01" => max_value := 6;
			-- count to 2
			when "10" => max_value := 3;
			-- count to 4
			when "11" => max_value := 3;
		end case;
		
		-- CHECK COUNT VS MAX VALUE
		if (cnt >= max_value) then
			cnt := 0;
			cout_temp := '1';
		else
			cout_temp := '0';
		end if;	
		
	end if;
	
	-- OUTPUT THE CURRENT COUNT
	count	<= std_logic_vector(to_unsigned(cnt, count'length));	
	-- OUTPUT COUT
	cout 	<= cout_temp;
	end process counter_proc;	
end multi_counter_impl;

