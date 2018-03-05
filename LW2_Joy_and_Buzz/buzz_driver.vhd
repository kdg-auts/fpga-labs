----------------------------------------------------------------------------------
-- Project Name: LW2 - LED control with joystick and buzzer
-- Module Name: buzz_driver - bd_arch
-- Create Date: 10:10:55 03/02/2018 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buzz_driver is
	generic (
		BUZZ_PERIOD_g: natural := 50000000
	);
	port ( 
		CLK : in  STD_LOGIC;
		EN : in  STD_LOGIC;
		BUZZ : out  STD_LOGIC
	);
end buzz_driver;

architecture bd_arch of buzz_driver is
	signal clk_count: natural range 0 to 50000000 := 0;
begin
	buzz_former: process (CLK, EN)
	begin
		if CLK'event and CLK = '1' then
			if EN = '1' then
				clk_count <= BUZZ_PERIOD_g - 1;
			end if;
			if clk_count > 0 then
				BUZZ <= '1';
				clk_count <= clk_count - 1;
			else 
				BUZZ <= '0';
			end if;
		end if;
	end process;
end bd_arch;

