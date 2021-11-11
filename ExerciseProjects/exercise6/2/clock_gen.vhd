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

begin
		-- asynkron reset, ikke afhængig af clk
		if reset = '0'  then 
			-- Reset the counter to 0 
			cnt := 0;
				
		elsif (rising_edge(clk)) then
			-- increment counter
			
			
			-- speed mode 1 for 1 sec clk pulse 
			if	(speed = '1') then	
				cnt := cnt + 1;			
				if (cnt = MAX_COUNT) then
					clk_out <= '1'; 
				else
					clk_out <= '0';
				end if;
				
			-- speed mode 0 for 5 ms clk pulse	
			elsif (speed = '0') then	
				cnt := cnt + 200;
				if (cnt = MAX_COUNT) then
					clk_out <= '1';
				else 
					clk_out <= '0';
				end if;
			end if;
		end if;
	end process;
end clock_gen_impl;

