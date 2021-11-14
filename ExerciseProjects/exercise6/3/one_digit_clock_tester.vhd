library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity one_digit_clock_tester is
generic
	(
		MIN_COUNT : natural := 0; -- min og max count for tæller
		MAX_COUNT : natural := 10
	);

	port
	(
		-- Input ports
		KEY		: in  std_logic_vector(3 downto 0);
		SW			: in  std_logic_vector(17 downto 16);
		CLOCK_50 : in 	std_logic; 
		
		-- Output ports
		HEX0		: out std_logic_vector(6 downto 0);
		LEDR 		: out std_logic_vector(0 downto 0)		
	);
end one_digit_clock_tester;


architecture one_digit_clock_impl_tester of one_digit_clock_tester is
	signal clkOutSignal	: std_logic;
	signal countSignal	: std_logic_vector(3 downto 0); 
begin

clockGen : entity clock_gen
	port map 
	(
		clk => CLOCK_50,
		speed => KEY(0),
		reset => KEY(3),
		clk_out => clkOutSignal 
	);
	
DUT : entity multi_counter
	port map 
	(		
		count => countSignal,
		clk => clkOutSignal,
		cout => LEDR(0),	
		mode => SW,
		reset => KEY(3)		
	);
	
hexDisp : entity bin2hex
	port map 
	(
		bin => countSignal,
		seg => HEX0
	);	
	
end one_digit_clock_impl_tester;
