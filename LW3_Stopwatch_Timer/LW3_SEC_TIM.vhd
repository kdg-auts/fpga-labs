----------------------------------------------------------------------------------
-- Project Name: LW3 - Stopwatch/Timer using 8-buttons keyboard and 7-segment display
-- Module Name:    LW3_SEC_TIM - LW3_SEC_TIM_ARCH
-- Create Date:    09:52:58 05/04/2018 
-- Description: top module of stopwatch/timer project
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LW3_SEC_TIM is
	generic (
		BUZZ_PERIOD_g : natural := 50000000 -- 50M = 1 sec
	);

	port ( 
		CLK : in  STD_LOGIC;
		RST : in  STD_LOGIC;
		SEC : in  STD_LOGIC; -- button to switch stopwatch mode of operation (bind to B5)
		TIM : in  STD_LOGIC; -- button to switch timer mode of operation (B6)
		START : in  STD_LOGIC; -- button to start counting (B7)
		STOP : in  STD_LOGIC; -- button to stop counting (B8)
		SETUP : in  STD_LOGIC_VECTOR (3 downto 0); -- buttons to setup initial values of timer (B4 B3 B2 B1)
		BUZZ : out  STD_LOGIC; -- output on buzzer (to generate sound effects)
		DIGIT : out  STD_LOGIC_VECTOR (7 downto 0); -- output to enlight number on segment (7-segment display module)
		SEGM : out  STD_LOGIC_VECTOR (3 downto 0); -- output to chose segment (7-segment display module)
		SEC_LED: out STD_LOGIC; -- output on LED to indicate Stopwatch mode (built-in LED0)
		TIM_LED: out STD_LOGIC -- output on LED to indicate Timer mode (built-in LED1)
	);
end LW3_SEC_TIM;

architecture LW3_SEC_TIM_ARCH of LW3_SEC_TIM is

	-- intermediate signals (between modules)
	signal S_L_s : STD_LOGIC_VECTOR (3 downto 0);
	signal S_H_s : STD_LOGIC_VECTOR (3 downto 0);
	signal M_L_s : STD_LOGIC_VECTOR (3 downto 0);
	signal M_H_s : STD_LOGIC_VECTOR (3 downto 0);
	signal DIGIT_s : STD_LOGIC_VECTOR (7 downto 0);
	signal CH_D_s: STD_LOGIC;
	signal EN_s: STD_LOGIC;
	signal BUZZ_s: STD_LOGIC;
	signal RST_s: STD_LOGIC;
	signal SEC_s: STD_LOGIC;
	signal TIM_s: STD_LOGIC;
	signal START_s: STD_LOGIC;
	signal STOP_s: STD_LOGIC;
	signal SETUP_s : STD_LOGIC_VECTOR (3 downto 0);
	signal BUZZ_out_s: STD_LOGIC;
	signal SEC_LED_s: STD_LOGIC;
	signal TIM_LED_s: STD_LOGIC;

begin
	
	-- signals with inversion
	RST_s <= not RST;
	SEC_s <= not SEC;
	TIM_s <= not TIM;
	START_s <= not START;
	STOP_s <= not STOP;
	SETUP_s <= not SETUP;
	BUZZ <= not BUZZ_out_s;
	SEC_LED <= not SEC_LED_s;
	TIM_LED <= not TIM_LED_s;
	DIGIT <= not DIGIT_s;
	
	clk_divider: entity work.clk_divider 
	generic map(
		TICK_COUNT_EN_g => 50000000, -- 50M pulses with 50MHz = 1 sec
		TICK_COUNT_CH_g => 500000 -- 0,5M pulses with 50MHz = 0,01 sec
	)
	port map(
		CLK => CLK,
		RST => RST_s,
		EN => EN_s,
		CH_D => CH_D_s
	);

	COUNT_TIMER: entity work.COUNT_TIMER 
	port map(
		CLK => CLK,
		RST => RST_s,
		EN => CH_D_s,
		TIC => EN_s,
		SEC => SEC_s,
		TIM => TIM_s,
		START => START_s,
		STOP => STOP_s,
		SETUP => SETUP_s,
		BUZZ => BUZZ_s,
		SEC_M => SEC_LED_s,
		TIM_M => TIM_LED_s,
		M_H => M_H_s,
		M_L => M_L_s,
		S_H => S_H_s,
		S_L => S_L_s
	);
	
	IND_DRV: entity work.IND_DRV
	port map(
		DIG1 => S_L_s,
		DIG2 => S_H_s,
		DIG3 => M_L_s,
		DIG4 => M_H_s,
		RST => RST_s,
		CLK => CLK,
		EN => CH_D_s,
		CH_SEG => CH_D_s,
		DIGIT  => DIGIT_s,
		CONTROL => SEGM
	);

	BUZZ_DRV: entity work.buzz_driver
		generic map(
			BUZZ_PERIOD_g => BUZZ_PERIOD_g
		)
		port map( 
			CLK => CLK,
			EN => BUZZ_s,
			BUZZ => BUZZ_out_s
		);
	
end LW3_SEC_TIM_ARCH;

