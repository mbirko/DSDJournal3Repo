LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;

ENTITY multi_counter IS
	GENERIC (
		MIN_COUNT : NATURAL := 0; -- min limit for counter
		MAX_COUNT : NATURAL := 10 -- max limit for counter
	);

	PORT (
		-- Input ports
		clk : IN STD_LOGIC;
		mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		reset : IN STD_LOGIC;

		-- Output ports
		count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		cout : OUT STD_LOGIC
	);
END multi_counter;

ARCHITECTURE multi_counter_impl OF multi_counter IS

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
			cout_temp := '0';
		end if;	
		
	end if;
	
	-- OUTPUT THE CURRENT COUNT
	count	<= std_logic_vector(to_unsigned(cnt, count'length));	
	-- OUTPUT COUT
	cout 	<= cout_temp;
	end process counter_proc;	
end multi_counter_impl;

