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
	constant O : std_logic_vector(3 downto 0) := "0001";
	constant Z : std_logic_vector(3 downto 0) := "0000";
	
begin


-- problem 
-- misunderstanding varieble initial value assingment timing
P1 : process(A)
	variable countOfones : std_logic_vector(3 downto 0) ; -- := "0000"  is not assigned with every process, but at program start time. 
begin
	countOfones := "0000"; -- is assigned at every start of every process 
L1 : for i in 7 downto 0 loop 
			if A(i) = '1' then
				countOfones := std_logic_vector(unsigned(countOfones) + "1");				
			else
				countOfones := countOfones;
		end if;
	end loop L1;
	ones <= countOfones;
end process;
	
B2H : entity bin2hex
	port map 
	(	
		 bin => ones,
		 seg => HEX		
	);
			
end count_ones_impl;
