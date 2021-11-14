library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity nandeight is
	generic (BIT_SIZE : integer := 16);
	port
	(
		-- Input ports
		a	: in  std_logic_vector(BIT_SIZE-1 downto 0);

		-- Output ports
		y	: out std_logic
		
	);
end nandeight;

architecture nandeight_impl of nandeight is

begin
P1: process(a)
	variable output : std_logic;
	
begin
	L1:for index in (BIT_SIZE-1) downto 0 loop
			output := output and a(index); 
		end loop L1;
		y <= not output;
	end process;
end nandeight_impl;
