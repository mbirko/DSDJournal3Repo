library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity nand8 is
	port
	(
		-- Input ports
		a	: in  std_logic_vector(7 downto 0);

		-- Output ports
		y	: out std_logic
		
	);
end nand8;

architecture nand8_impl of nand8 is

begin
	y <= nand(a);
	
end nand8_impl;
