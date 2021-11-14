library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity clock_gen is
generic
	(
		MIN_COUNT : natural := 0; -- min og max count for tæller
		MAX_COUNT : natural := 50000000
	);

	port
	(
		-- Input ports
		clk	: in  std_logic;
		speed	: in  std_logic;
		reset : in	std_logic;
		
		-- Output ports
		clk_out	: out std_logic		
	);
end clock_gen;

architecture clock_gen_impl of clock_gen is
begin 

clkProces : process(clk,reset) 
	variable	cnt : integer range MIN_COUNT to MAX_COUNT; 
	variable clkOutSignal : std_logic;
begin
		-- asynkron reset, ikke afhængig af clk
		if reset = '0'  then 
			-- Reset the counter to 0 
			cnt := 0;
			clkOutSignal := '0';
			
		elsif (rising_edge(clk)) then
			-- increment counter
			cnt := cnt + 1;	
			
			-- speed mode 1 for 1 sec clk pulse 
			if	(speed = '1') then							
				if (cnt = MAX_COUNT) then
					cnt := 0;
					clkOutSignal := '1';
				else 
					clkOutSignal := '0';					 
				end if;
				
			-- speed mode 0 for 5 ms clk pulse	
			elsif (speed = '0') then				
				if (cnt = (MAX_COUNT/200)) then
					cnt := 0;
					clkOutSignal := '1';
				else 
					clkOutSignal := '0';
				end if;
				
			end if;
		end if;
		clk_out 	<= clkOutSignal;
	end process;
end clock_gen_impl;

