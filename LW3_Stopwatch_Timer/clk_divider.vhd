----------------------------------------------------------------------------------
-- Project Name: LW3 - Stopwatch/Timer using 8-buttons keyboard and 7-segment display
-- Module Name: clk_divider - clk_divider_arch
-- Create Date: 11:04:24 02/16/2018 
-- Description: reused from LW2 with upgrade
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_divider is
    generic (
			TICK_COUNT_EN_g : natural := 50000000;
			TICK_COUNT_CH_g : natural := 50000000
	 );
	 port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           EN : out  STD_LOGIC;
			  CH_D : out  STD_LOGIC
	 );
end clk_divider;

architecture clk_divider_arch of clk_divider is
	signal clk_count1 : natural range 0 to 50000000 := 0;
	signal clk_count2 : natural range 0 to 50000000 := 0;
begin

	counter1: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				clk_count1 <= 0;
				EN <= '0';
			elsif clk_count1 = TICK_COUNT_EN_g - 1 then
				clk_count1 <= 0;
				EN <= '1';
			else
				clk_count1 <= clk_count1 + 1;
				EN <= '0';
			end if;
		end if;
	end process;
	
	counter2: process(CLK, RST)
	begin
		if CLK'event and CLK = '1' then
			if RST = '1' then
				clk_count2 <= 0;
				CH_D <= '0';
			elsif clk_count2 = TICK_COUNT_CH_g - 1 then
				clk_count2 <= 0;
				CH_D <= '1';
			else
				clk_count2 <= clk_count2 + 1;
				CH_D <= '0';
			end if;
		end if;
	end process;

end clk_divider_arch;

