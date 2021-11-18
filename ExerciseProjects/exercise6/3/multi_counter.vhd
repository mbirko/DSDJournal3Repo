library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity multi_counter is
generic
	(
		MIN_COUNT : natural := 0; -- min og
		MAX_COUNT : natural := 10 -- max count for tæller
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
	-- process reagerer både clk og reset
counter_proc : process (clk,reset) 
		variable max_value : natural := 10;
		-- bruger "variable" for øjeblikkelig opdatering af counter variable
		variable	cnt	:	integer range MIN_COUNT to MAX_COUNT; 
		-- MAX_COUNT betyder IKKE at counteren af sig selv ikke tæller højere end til MAX_COUNT
		variable cout_temp : std_logic;
	begin
	-- asynkron reset, ikke afhængig af clk
	if reset = '0'  then 
		-- Reset the counter to 0 
		cnt := 0;
		cout_temp := '0';
		
	elsif (rising_edge(clk)) then		
		-- increment counter
		cnt := cnt + 1;
		-- test counter værdier afhængig af mode 
		-- (og reset counter på passende vis)
		case mode is
			-- count to 9	
			when "00" => max_value := MAX_COUNT;
			-- count to 5
			when "01" => max_value := MAX_COUNT/2;
			-- count to 2
			when "10" => max_value := 3;
			-- count to 2
			when "11" => max_value := 3;
		end case;
		
		if (cnt >= max_value) then
			cnt := 0;
			cout_temp := '1';
		else
			cout_temp := '0';
		end if;	
		
	end if;
	
	-- Output the current count
	count	<= std_logic_vector(to_unsigned(cnt, count'length));	
	-- Output cout--
	cout 	<= cout_temp;
	end process counter_proc;	
end multi_counter_impl;

