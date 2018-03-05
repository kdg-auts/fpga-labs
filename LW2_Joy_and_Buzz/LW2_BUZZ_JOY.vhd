----------------------------------------------------------------------------------
-- Project Name: LW2 - LED control with joystick and buzzer
-- Module Name: LW2_BUZZ_JOY - LW2_BUZZ_JOY_ARCH
-- Create Date: 10:59:20 03/02/2018 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LW2_BUZZ_JOY is
	generic (
		BUZZ_PERIOD_g : natural := 50000000; -- 50M = 1 sec
		TICK_COUNT_g : natural := 1000000 -- 10M = 0.2 sec
	);
	port ( 
		CLK : in  STD_LOGIC;
		RST : in  STD_LOGIC;
		J_UP : in  STD_LOGIC;
		J_DWN : in  STD_LOGIC;
		J_PRESS : in  STD_LOGIC;
		BUZZ : out  STD_LOGIC;
		LED : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end LW2_BUZZ_JOY;

architecture LW2_BUZZ_JOY_ARCH of LW2_BUZZ_JOY is
	signal en_s : std_logic;
	signal rst_s : std_logic;
	signal j_up_s : std_logic;
	signal j_dwn_s : std_logic;
	signal j_press_s : std_logic;
	signal buzz_s : std_logic;
	signal buzz_en_s : std_logic;
	signal led_s : std_logic_vector(3 downto 0);
begin
	
	-- enable pulses generator
	CLK_DIV: entity work.clk_divider
	generic map (
		TICK_COUNT_g => TICK_COUNT_g
	)
	port map (
		CLK => CLK,
		RST => rst_s,
		EN => en_s
	);
	
	-- core module: LED and BUZZ controller, LED driver
	LED_DRV: entity work.LED_driver_v2
	port map (
		CLK => CLK,
		RST => rst_s,
		EN => en_s,
		LED => led_s,
		COUNT_UP => j_up_s,
		COUNT_DOWN => j_dwn_s,
		INITIAL => j_press_s,
		BUZZ_T => buzz_en_s
	);
	
	-- BUZZ driver (generates 1 sec buzzing)
	BUZZ_DRV: entity work.buzz_driver
	generic map(
		BUZZ_PERIOD_g => BUZZ_PERIOD_g
	)
	port map( 
		CLK => CLK,
		EN => buzz_en_s,
		BUZZ => buzz_s
	);
	
	-- output assignments (with inverse)
	rst_s <= not RST;
	j_up_s <= not J_UP;
	j_dwn_s <= not J_DWN;
	j_press_s <= not J_PRESS;
	BUZZ <= not buzz_s;
	LED <= not led_s;
	
end LW2_BUZZ_JOY_ARCH;

