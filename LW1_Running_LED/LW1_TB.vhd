--------------------------------------------------------------------------------
-- Project Name: LW1 - Simple LED control
-- Module Name: LW1_TB
-- Create Date: 12:14:52 02/16/2018
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LW1_TB is
end LW1_TB;

architecture behavior of LW1_TB is 
	-- Component Declaration for the Unit Under Test (UUT)
	component LW1_RUNNING_LED
	generic (
		TICK_COUNT : integer
	);
	port(
		CLK : IN  std_logic;
		RST : IN  std_logic;
		LED : OUT  std_logic_vector(3 downto 0)
	);
	end component;

	--Inputs
	signal CLK : std_logic := '0';
	signal RST : std_logic := '0';

	--Outputs
	signal LED : std_logic_vector(3 downto 0);
	-- Clock period definitions
	constant CLK_period : time := 20 ns;

begin

	-- Instantiate the Unit Under Test (UUT)
	uut: LW1_RUNNING_LED 
	generic map (
		TICK_COUNT => 100
	)
	PORT MAP (
		CLK => CLK,
		RST => RST,
		LED => LED
	);

	-- Clock process definitions
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;

	-- Stimulus process
	stim_proc: process
	begin
	-- hold reset state for 100 ns.
		RST <= '0';
		wait for 100 ns;	
		RST <= '1';
		wait for 29 us;
		RST <= '0';
		wait for 100 ns;	
		RST <= '1';
		-- insert other stimulus here 
	wait;
	end process;

end;
