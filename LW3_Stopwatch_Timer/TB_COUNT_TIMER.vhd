--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:03:00 04/27/2018
-- Design Name:   
-- Module Name:   C:/xilinx_projects/LW3_SEC_TIM/TB_COUNT_TIMER.vhd
-- Project Name:  LW3_SEC_TIM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: COUNT_TIMER
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_COUNT_TIMER IS
END TB_COUNT_TIMER;
 
ARCHITECTURE behavior OF TB_COUNT_TIMER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT COUNT_TIMER
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         EN : IN  std_logic;
         TIC : IN  std_logic;
         SEC : IN  std_logic;
         TIM : IN  std_logic;
         START : IN  std_logic;
         STOP : IN  std_logic;
         SETUP : IN  std_logic_vector(3 downto 0);
         BUZZ : OUT  std_logic;
         SEC_M : OUT  std_logic;
         TIM_M : OUT  std_logic;
         M_H : OUT  std_logic_vector(3 downto 0);
         M_L : OUT  std_logic_vector(3 downto 0);
         S_H : OUT  std_logic_vector(3 downto 0);
         S_L : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal EN : std_logic := '0';
   signal TIC : std_logic := '0';
   signal SEC : std_logic := '0';
   signal TIM : std_logic := '0';
   signal START : std_logic := '0';
   signal STOP : std_logic := '0';
   signal SETUP : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal BUZZ : std_logic;
   signal SEC_M : std_logic;
   signal TIM_M : std_logic;
   signal M_H : std_logic_vector(3 downto 0);
   signal M_L : std_logic_vector(3 downto 0);
   signal S_H : std_logic_vector(3 downto 0);
   signal S_L : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: COUNT_TIMER PORT MAP (
          CLK => CLK,
          RST => RST,
          EN => EN,
          TIC => TIC,
          SEC => SEC,
          TIM => TIM,
          START => START,
          STOP => STOP,
          SETUP => SETUP,
          BUZZ => BUZZ,
          SEC_M => SEC_M,
          TIM_M => TIM_M,
          M_H => M_H,
          M_L => M_L,
          S_H => S_H,
          S_L => S_L
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
 TIC_process :process
   begin
		TIC <= '0';
		wait for CLK_period*9;
		TIC <= '1';
		wait for CLK_period;
   end process;
	
	EN_process :process
   begin
		EN <= '0';
		wait for CLK_period/2;
		EN <= '1';
		wait for CLK_period/2;
   end process;
	
   -- Stimulus process
   stim_proc: process
   begin	
		RST <='1';
		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RST <='0';
      wait for CLK_period*10;

      -- insert stimulus here 
		SEC <= '1'; --secundamer
		wait for 50 ns;
		SEC <= '0';
		wait for 50 ns;
		START <= '1';
		wait for 50 ns;
		START <= '0';
		wait for CLK_period*100;
		STOP <= '1';
		wait for 150 ns;
		STOP <= '0';
		wait for 50 ns;
		
		TIM <= '1'; --timer
		wait for 50 ns;
		TIM <= '0';
		wait for 50 ns;
		START <= '1';
		wait for 50 ns;
		START <= '0';
		wait for CLK_period*100;
		
      wait;
   end process;

END;
