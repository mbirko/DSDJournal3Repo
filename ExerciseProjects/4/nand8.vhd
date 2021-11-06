library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity my_nand8 is
	port
	(
	-- Input ports
		a	: in  std_logic_vector(7 downto 0);
	-- Output ports
		y	: out std_logic		
	);
end my_nand8;

architecture nand8_impl of my_nand8 is

begin
P1: process(a)
-- Using variable in the loop for the y port intermediate results
	variable output : std_logic;
	
begin
	L1:for index in 7 downto 0 loop
		-- and all of a to one another
			output := output and a(index); 
		end loop L1;
	-- lastly invert the output and send to port y
		y <= not output;
	end process;
end nand8_impl;
