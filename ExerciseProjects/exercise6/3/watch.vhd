library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity watch is

	port
	(
		-- Input ports
		clk		: in  std_logic;
		speed		: in  std_logic;
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
	-- signals from reset logic process
	signal reset_out 		: std_logic;
	signal reset_in 		: std_logic;
	-- signal from clockgen
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
	signal count_hrs_10	: std_logic_vector(3 downto 0); 
	
begin
-- CLOCKGEN
clockGen : entity clock_gen
	port map 
	(
		clk => clk,
		speed => speed,
		reset => reset_out,
		clk_out => clkOutSignal  
	);
	
-- MULTICOUNTER SEC, MIN AND HRS
multiCounter_sec_1 : entity multi_counter
	port map 
	(		
		count => count_sec_1,
		clk => clkOutSignal,
		cout => cout_sec_1,	
		mode => "00",
		reset => reset_out		
	);
	
multiCounter_sec_10 : entity multi_counter
	port map 
	(		
		count => count_sec_10,
		clk => cout_sec_1,
		cout => cout_sec_10,	
		mode => "01",
		reset => reset_out		
	);
multiCounter_min_1 : entity multi_counter
	port map 
	(		
		count => count_min_1,
		clk => cout_sec_10,
		cout => cout_min_1,	
		mode => "00",
		reset => reset_out		
	);
multiCounter_min_10 : entity multi_counter
	port map 
	(		
		count => count_min_10,
		clk => cout_min_1,
		cout => cout_min_10,	
		mode => "01",
		reset => reset_out		
	);	
multiCounter_hrs_1s : entity multi_counter
	port map 
	(		
		count => count_hrs_1,
		clk => cout_min_10,
		cout => cout_hrs_1,	
		mode => "00",
		reset => reset_out		
	);
multiCounter_hrs_10 : entity multi_counter
	port map 
	(		
		count => count_hrs_10,
		clk => cout_hrs_1,
		cout => cout_hrs_10,	
		mode => "11",
		reset => reset_out		
	);	
	
-- BIN2SEVENSEG SEC, MIN AND HRS	
bin2sevenseg_sec_1 : entity bin2hex
	port map 
	(
		bin => "0101",
		seg => sec_1
	);	
	
bin2sevenseg_sec_10 : entity bin2hex
	port map 
	(
		bin => count_sec_10,
		seg => sec_10
	);	
	
bin2sevenseg_min_1 : entity bin2hex
	port map 
	(
		bin => count_min_1,
		seg => min_1
	);	
	
bin2sevenseg_min_10 : entity bin2hex
	port map 
	(
		bin => count_min_10,
		seg => min_10
	);	
bin2sevenseg_hrs_1 : entity bin2hex
	port map 
	(
		bin => count_hrs_1,
		seg => hrs_1
	);	
	
bin2sevenseg_hrs_10 : entity bin2hex
	port map 
	(
		bin => count_hrs_10,
		seg => hrs_10
	);	

-- RESET LOGIC

reset_logic : process(reset_in, cout_hrs_10) 
begin
	if reset_in = '0' then
		reset_out <= '0';
	elsif reset_in = '1' then
		if cout_hrs_10 = '1'  then 
				reset_out <= '0';
		end if;
	end if;	
end process reset_logic;
reset_out <= '0';

end watch_impl;

