-- countOne
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity count_ones_tester is
	port
	(
	-- Input ports
		SW	: in  std_logic_vector(7 downto 0);

	-- Output ports
		HEX0	: out std_logic_vector(6 downto 0)
	);

end count_ones_tester;


architecture count_ones_impl_tester of count_ones_tester is
	
begin
	
DUT : entity count_ones
	port map 
	(
		A(7 downto 0) => SW(7 downto 0),
		HEX(6 downto 0) => HEX0(6 downto 0) 
	);
			
end count_ones_impl_tester;
