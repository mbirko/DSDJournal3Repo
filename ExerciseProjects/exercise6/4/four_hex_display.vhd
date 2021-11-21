library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity four_hex_display is
	port
	(
		-- Input ports
		binInput	: in std_logic_vector(15 downto 0);

		-- Output ports
		disOutput :	out std_logic_vector(27 downto 0)
	);
end four_hex_display;


architecture four_hex_display_impl of four_hex_display is
begin
	onesDisplay : entity bin2hex
		port map
		(
			bin => binInput(3 downto 0),
			seg => disOutput(6 downto 0)
		);
	TensDisplay : entity bin2hex
		port map
		(
			bin => binInput(7 downto 4),
			seg => disOutput(13 downto 7)
		);
	HundredDisplay : entity bin2hex
		port map
		(
			bin => binInput(11 downto 8),
			seg => disOutput(20 downto 14)
		);
	thusendDisplay : entity bin2hex
		port map
		(
			bin => binInput(15 downto 12),
			seg => disOutput(27 downto 21)
		);
end four_hex_display_impl ; -- four_hex_display_impl
