----------------------------------------------------------------------------------
-- Project Name: LW2 - LED control with joystick and buzzer
-- Module Name: LW2_TB
-- Module Type: testbench
-- Unit Under Test: LW2_BUZZ_JOY
-- Create Date: 09:42:56 03/05/2018 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity LW2_TB is
end LW2_TB;
 
architecture LW2_TB_IMPLEMENT of LW2_TB is 
 
	-- Component Declaration for the Unit Under Test (UUT)
	component LW2_BUZZ_JOY
	generic (
		BUZZ_PERIOD_g : natural;
		TICK_COUNT_g : natural
	);
	port(
		CLK : in std_logic;
		RST : in std_logic;
		J_UP : in  std_logic;
		J_DWN : in  std_logic;
		J_PRESS : in  std_logic;
		BUZZ : out  std_logic;
		LED : out  std_logic_vector(3 downto 0)
	);
	end component;

	--Inputs
	signal CLK : std_logic := '0';
	signal nRST : std_logic := '1';
	signal nJ_UP : std_logic := '1';
	signal nJ_DWN : std_logic := '1';
	signal nJ_PRESS : std_logic := '1';

 	--Outputs
	signal nBUZZ : std_logic;
	signal nLED : std_logic_vector(3 downto 0);

	-- Clock period definitions
	constant CLK_period : time := 20 ns; -- f = 50 MHz
 
begin
 
	-- Instantiate the Unit Under Test (UUT)
	uut: LW2_BUZZ_JOY 
	generic map (
		BUZZ_PERIOD_g => 500,
		TICK_COUNT_g => 100
	)
	port map (
		CLK => CLK,
		RST => nRST,
		J_UP => nJ_UP,
		J_DWN => nJ_DWN,
		J_PRESS => nJ_PRESS,
		BUZZ => nBUZZ,
		LED => nLED
	);

	-- Clock process
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;

	-- Reset process
	rst_proc: process
	begin
		-- hold reset state for 100 ns.
		nRST <= '0';
		wait for CLK_period*5;
		nRST <= '1';
		wait;
	end process;
	
	-- Stimulators process
	stim_proc: process
	begin
		-- hold untill reset is off
		wait until nRST = '1';
		wait for CLK_period*50;
		
		for i in 0 to 11 loop
			nJ_UP <= '0';
			wait for CLK_period*100;
			nJ_UP <= '1';
			wait for CLK_period*1000;
		end loop;
		
		for i in 0 to 11 loop
			nJ_DWN <= '0';
			wait for CLK_period*100;
			nJ_DWN <= '1';
			wait for CLK_period*1000;
		end loop;
		
		nJ_PRESS <= '0';
		wait for CLK_period*100;
		nJ_PRESS <= '1';
		
		wait;
	end process;

end LW2_TB_IMPLEMENT;
