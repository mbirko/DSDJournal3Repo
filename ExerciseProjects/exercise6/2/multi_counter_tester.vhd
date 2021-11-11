library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity multi_counter_tester is
	port
	(
		-- Input ports
		KEY	: in  std_logic_vector(3 downto 0);
		SW	: in  std_logic_vector(17 downto 16);
				
		-- Output ports
		HEX0	: out std_logic_vector(6 downto 0);
		LEDR 	: out std_logic_vector(0 downto 0)
		
	);
end multi_counter_tester;

architecture multi_counter_impl_tester of multi_counter_tester is
	signal countSignal : std_logic_vector(3 downto 0); 
begin

DUT : entity multi_counter
	port map 
	(	
		count => countSignal,
		cout => LEDR(0),
		clk => KEY(0),
		mode => SW,
		reset => KEY(3)		
	);
	
hexDisp : entity bin2hex
	port map 
	(
		bin => countSignal,
		seg => HEX0
	);	
	
end multi_counter_impl_tester;
