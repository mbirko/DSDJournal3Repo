library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity nand8_tester is
	generic (BIT_SIZE : integer := 16);
	port
	(
		-- Input ports
		SW	: in  std_logic_vector(BIT_SIZE-1 downto 0);

		-- Output ports
		LEDR	: out std_logic
		
	);
end nand8_tester;

architecture nasnd8_impl_tester of nand8_tester is

begin 
	-- direct instanciation
	DUT : ENTITY nandeight
		PORT MAP
		(
			a => SW,
			y => LEDR			
		);
end nand8_impl_tester;
