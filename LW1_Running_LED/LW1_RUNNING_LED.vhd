----------------------------------------------------------------------------------
-- Project Name: LW1 - Simple LED control
-- Module Name: LW1_RUNNING_LED - Behavioral 
-- Create Date: 11:55:20 02/16/2018 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LW1_RUNNING_LED is
	generic (
		TICK_COUNT : integer := 25000000
	);
	port ( 
		CLK : in  STD_LOGIC;
		RST : in  STD_LOGIC;
		LED : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end LW1_RUNNING_LED;

architecture Behavioral of LW1_RUNNING_LED is
	component clk_divider is
		generic (
			TICK_COUNT : integer
		);
		port ( 
			CLK : in  STD_LOGIC;
			RST : in  STD_LOGIC;
			EN : out  STD_LOGIC
		);
	end component;
	
	signal en_s : std_logic;
	signal rst_s : std_logic;

begin
	
	rst_s <= not RST;
	
	CLK_DIV: clk_divider
	generic map (
		TICK_COUNT => TICK_COUNT
	)
	port map (
		CLK => CLK,
		RST => rst_s,
		EN => en_s
	);
	
	LED_DRW: entity work.led_driver
	port map (
		CLK => CLK,
		RST => rst_s,
		EN => en_s,
		LED => LED
	);

end Behavioral;

