library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity multi_counter is
generic
	(
		MIN_COUNT : natural := 0; -- min og max count for tæller
		MAX_COUNT : natural := 10
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
		-- bruger "variable" for øjeblikkelig opdatering af counter variable
		variable   cnt		 : integer range MIN_COUNT to MAX_COUNT; 
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
			if (mode = "00") then
				if (cnt >= MAX_COUNT) then
					cnt := 0;
					cout_temp := '1';
				else 
					cout_temp := '0';
				end if;
				
			-- Mode count to 10	
			elsif mode = "01" then
				if (cnt >= (MAX_COUNT/2)) then
					cnt := 0;
					cout_temp := '1';
				else 
					cout_temp := '0';
				end if;
				
			-- Mode count to 5	
			elsif mode = "10" then  
				if (cnt >= (MAX_COUNT/5)) then
					cnt := 0;
					cout_temp := '1';
				else 
					cout_temp := '0';
				end if;
				
			-- Mode count to 2	
			elsif mode = "11" then  
				if (cnt >= (MAX_COUNT/5)) then
					cnt := 0;
					cout_temp := '1';
				else 
					cout_temp := '0';
				end if;
				
			end if;			
		end if;
		
		-- Output the current count
		count	<= std_logic_vector(to_unsigned(cnt, count'length));
		
		-- Output cout--
		cout 	<= cout_temp;
	end process counter_proc;
	
end multi_counter_impl;

