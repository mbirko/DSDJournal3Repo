-- multi counter yeah --

library ieee;
use std_logic_1164.all;
use work.all;

entity multi_counter_tester is
	port
	(
		-- Input ports
		KEY	: in  std_logic_vector(3 downto 0);
		SW	: in  std_logic_vector(17 downto 16);
				
		-- Output ports
		HEX0	: out std_logic_vector(6 downto 0);
		LEDR 	: out std_logic_vector(0 downto 0);
		
	);
end multi_counter_tester;

architecture multi_counter_impl of multi_counter is
	
begin

DUT : entity multi_counter
	port map 
	(
		seg => HEX;
		cout => LEDR;
		clk => KEY(0);
		model => SW;
		reset => KEY(3);
		
	);


end multi_counter_impl;
