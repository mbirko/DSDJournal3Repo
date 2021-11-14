library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity watch is

	port
	(
		-- Input ports
		clk		: in  std_logic;
		speed		: in  std_logic_vector(0 downto 0);
		reset 	: in  std_logic;

		-- Output ports
		sec_1		: out std_logic_vector(6 downto 0);
		sec_10	: out std_logic_vector(6 downto 0);
		min_1		: out std_logic_vector(6 downto 0);
		min_10	: out std_logic_vector(6 downto 0);
		hrs_1		: out std_logic_vector(6 downto 0);
		hrs_10	: out std_logic_vector(6 downto 0);
		tm			: out std_logic_vector(15 downto 0)
		
	);
end watch;

architecture watch_impl of watch is
	signal clkOutSignal	: std_logic;
	-- signals from overflow of sec, min and hrs
	signal cout_sec_1		: std_logic; 
	signal cout_sec_10	: std_logic; 
	signal cout_min_1		: std_logic; 
	signal cout_min_10	: std_logic; 
	signal cout_hrs_1		: std_logic;
	signal cout_hrs_10	: std_logic;
	-- signals for the value count of sec, min and hrs
	signal count_sec_1	: std_logic_vector(3 downto 0);
	signal count_sec_10	: std_logic_vector(3 downto 0); 
	signal count_min_1	: std_logic_vector(3 downto 0);
	signal count_min_10	: std_logic_vector(3 downto 0); 
	signal count_hrs_1	: std_logic_vector(3 downto 0);
	signal count_hrs_10	: std_logic_vector(3 downto 0) 
	
begin

clockGen : entity clock_gen
	port map 
	(
		clk => CLOCK_50,
		speed => KEY(0),
		reset => KEY(3),
		clk_out => clkOutSignal 
	);
-- MULTICOUNTER SEC, MIN AND HRS
sec_1 : entity multi_counter
	port map 
	(		
		count => countSec_1,
		clk => clkOutSignal,
		cout => ,	
		mode => SW,
		reset => KEY(3)		
	);
sec_10 : entity multi_counter
	port map 
	(		
		count => countSec_1,
		clk => clkOutSignal,
		cout => ,	
		mode => SW,
		reset => KEY(3)		
	);
min_1 : entity multi_counter
	port map 
	(		
		count => countSec_1,
		clk => clkOutSignal,
		cout => ,	
		mode => SW,
		reset => KEY(3)		
	);
min_10 : entity multi_counter
	port map 
	(		
		count => countSec_1,
		clk => clkOutSignal,
		cout => ,	
		mode => SW,
		reset => KEY(3)		
	);	
hrs_1 : entity multi_counter
	port map 
	(		
		count => countSec_1,
		clk => clkOutSignal,
		cout => ,	
		mode => SW,
		reset => KEY(3)		
	);
hrs_10 : entity multi_counter
	port map 
	(		
		count => countSec_1,
		clk => clkOutSignal,
		cout => ,	
		mode => SW,
		reset => KEY(3)		
	);	
	
-- BIN2SEVENSEG SEC, MIN AND HRS	
sec_1 : entity bin2hex
	port map 
	(
		bin => countSec_1,
		seg => sec_1
	);	
	
sec_10 : entity bin2hex
	port map 
	(
		bin => countSec_1,
		seg => sec_10
	);	
	
min_1 : entity bin2hex
	port map 
	(
		bin => countSec_1,
		seg => min_1
	);	
	
min_10 : entity bin2hex
	port map 
	(
		bin => countSec_1,
		seg => min_10
	);	
hrs_1 : entity bin2hex
	port map 
	(
		bin => countSec_1,
		seg => hrs_1
	);	
	
hrs_10 : entity bin2hex
	port map 
	(
		bin => countSec_1,
		seg => hrs_10
	);	
	
end watch_impl;

