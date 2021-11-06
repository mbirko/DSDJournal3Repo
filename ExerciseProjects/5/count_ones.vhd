-- countOne
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity count_ones is
	port
	(
	-- Input ports
		A	: in  std_logic_vector(7 downto 0);

	-- Output ports
		HEX : out std_logic_vector(6 downto 0)
	);
end count_ones;

architecture count_ones_impl of count_ones is
	signal ones : unsigned(3 downto 0) := "0000";
	
begin
P1 : process(A)
begin

L1 : for index in 7 downto 0 loop
			if (A(index) = '1') then
			ones <= (ones + 1);
		end if;
	end loop L1;
end process;
	
B2H : entity bin2hex
	port map 
	(	
		 bin => std_logic_vector(ones),
		 seg => HEX		
	);
			
end count_ones_impl;
