----------------------------------------------------------------------------------
-- Project Name: LW2 - LED control with joystick and buzzer
-- Module Name: clk_divider - clk_divider_arch
-- Create Date: 11:04:24 02/16/2018 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_divider is
    generic (
			TICK_COUNT_g : natural := 50000000
	 );
	 port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           EN : out  STD_LOGIC);
end clk_divider;

architecture clk_divider_arch of clk_divider is
	signal clk_count : natural range 0 to 50000000 := 0;
begin
	counter: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				clk_count <= 0;
				EN <= '0';
			elsif clk_count = TICK_COUNT_g - 1 then
				clk_count <= 0;
				EN <= '1';
			else
				clk_count <= clk_count + 1;
				EN <= '0';
			end if;
		end if;
	end process;

end clk_divider_arch;

