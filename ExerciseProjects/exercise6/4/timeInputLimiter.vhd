library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity timeInputLimiter is
	port
	(
		-- Input ports
		Input	: in std_logic_vector(15 downto 0);

		-- Output ports
		Output	: out std_logic_vector(15 downto 0)
	);
end timeInputLimiter;

architecture timeInputLimiter of timeInputLimiter is
begin
	limit : process( input )
	begin
		if input <= "0010001101011001" then
			output <= input;
		else
			output <= "0010001101011001";
		end if;
		
	end process ; -- limit
end timeInputLimiter ; -- timeInputLimiter


