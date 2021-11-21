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
		currentTime : out std_logic_vector(41 downto 0);
		sec_1		: out std_logic_vector(6 downto 0);
		sec_10	: out std_logic_vector(6 downto 0);
		min_1		: out std_logic_vector(6 downto 0);
		min_10	: out std_logic_vector(6 downto 0);
		hrs_1		: out std_logic_vector(6 downto 0);
		hrs_10	: out std_logic_vector(6 downto 0);
		tm 		: out std_logic_vector(15 downto 0)
		
	);
end watch;

architecture watch_impl of watch is
	-- signal from clockgen
	signal clkOutSignal	: std_logic;
	-- signal from reset logic
	signal reset_out : std_logic;

	-- signals from overflow of sec, min and hrs
	signal cout_sec_1		: std_logic; 
	signal cout_sec_10	: std_logic; 
	signal cout_min_1 	: std_logic; 
	signal cout_min_10 	: std_logic; 
	signal cout_hrs_1 	: std_logic; 
	signal cout_hrs_10 	: std_logic; 
	
	-- signals for the value count of sec, min and hrs
	signal count_sec_1	: std_logic_vector(3 downto 0);
	signal count_sec_10	: std_logic_vector(3 downto 0);
	signal count_min_1	: std_logic_vector(3 downto 0);
	signal count_min_10	: std_logic_vector(3 downto 0);
	signal count_hrs_1	: std_logic_vector(3 downto 0);
	signal count_hrs_10	: std_logic_vector(3 downto 0);
	
begin
-- RESETLOGIC PROCESS
	RLP : process(reset, cout_hrs_10, cout_hrs_1)
	begin	
		if reset = '0' then
			reset_out <= '0';		
		elsif (count_hrs_10 = "0010") and (count_hrs_1 = "0100") then
			 reset_out <= '0';	
		else 
			reset_out <= '1';	
			
		end if;
	end process RLP;

-- CLOCKGEN
	clockGen : entity clock_gen
		port map 
		(
			clk => clk,
			speed => speed,
			reset => reset,
			clk_out => clkOutSignal  
		);
		
-- MULTICOUNTER AND BIN2SEVEN FOR SEC 1
	multiCounter_sec_1 : entity multi_counter
		port map 
		(		
			count => count_sec_1,
			clk => clkOutSignal,
			cout => cout_sec_1,	
			mode => "00",
			reset => reset_out		
		);
		
	bin2sevenseg_sec_1 : entity bin2hex
		port map 
		(
			bin => count_sec_1,
			seg => currentTime(6 downto 0)
		);	
		
-- MULTICOUNTER AND BIN2SEVEN FOR SEC 10
	multiCounter_sec_10 : entity multi_counter
		port map 
		(		
			count => count_sec_10,
			clk => cout_sec_1,
			cout => cout_sec_10,	
			mode => "01",
			reset => reset_out		
		);
		
	bin2sevenseg_sec_10 : entity bin2hex
		port map 
		(
			bin => count_sec_10,
			seg => currentTime(13 downto 7)
		);	

-- MULTICOUNTER AND BIN2SEVEN FOR MIN 1
	multiCounter_min_1 : entity multi_counter
		port map 
		(		
			count => count_min_1,
			clk => cout_sec_10,
			cout => cout_min_1,	
			mode => "00",
			reset => reset_out		
		);
		
	bin2sevenseg_min_1 : entity bin2hex
		port map 
		(
			bin => count_min_1,
			seg => currentTime(20 downto 14)
		);	
		
-- MULTICOUNTER AND BIN2SEVEN FOR MIN 10
	multiCounter_min_10 : entity multi_counter
		port map 
		(		
			count => count_min_10,
			clk => cout_min_1,
			cout => cout_min_10,	
			mode => "01",
			reset => reset_out		
		);
		
	bin2sevenseg_min_10 : entity bin2hex
		port map 
		(
			bin => count_min_10,
			seg => currentTime(27 downto 21)
		);	
		
-- MULTICOUNTER AND BIN2SEVEN FOR HRS 1
	multiCounter_hrs_1 : entity multi_counter
		port map 
		(		
			count => count_hrs_1,
			clk => cout_min_10,
			cout => cout_hrs_1,	
			mode => "00",
			reset => reset_out	
		);
		
	bin2sevenseg_hrs_1 : entity bin2hex
		port map 
		(
			bin => count_hrs_1,
			seg => currentTime(34 downto 28)
		);	
		
-- MULTICOUNTER AND BIN2SEVEN FOR HRS 10
	multiCounter_hrs_10 : entity multi_counter
		port map 
		(		
			count => count_hrs_10,
			clk => cout_hrs_1,
			cout => cout_hrs_10,	
			mode => "10",
			reset => reset_out		
		);
		
	bin2sevenseg_hrs_10 : entity bin2hex
		port map 
		(
			bin => count_hrs_10,
			seg => currentTime(41 downto 35) 
		);	
	
	tm(3 downto 0) <= count_min_1; 
	tm(7 downto 4) <= count_min_10; 
	tm(11 downto 8) <= count_hrs_1; 
	tm(15 downto 12) <= count_hrs_10;

end watch_impl;

