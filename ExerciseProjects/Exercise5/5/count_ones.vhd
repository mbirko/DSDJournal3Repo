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
	signal ones : std_logic_vector(3 downto 0) := "0000";
	signal one : std_logic_vector(3 downto 0) := "0001";
	signal z : std_logic_vector(3 downto 0) := "0000";
	
begin

P1 : process(A)
	variable countOfones : std_logic_vector(3 downto 0) := "0000";
begin
L1 : for i in 7 downto 0 loop 
			if A(i) = '1' then
				countOfones := std_logic_vector(unsigned(countOfones) + unsigned(one));				
			else
				--countOfones := std_logic_vector(unsigned(countOfones) + unsigned(z));	
				countOfones := countOfones;
		end if;
	end loop L1;
	ones <= "1010";--countOfOnes;
end process;
	
B2H : entity bin2hex
	port map 
	(	
		 bin => "1010",
		 seg => HEX		
	);
			
end count_ones_impl;
