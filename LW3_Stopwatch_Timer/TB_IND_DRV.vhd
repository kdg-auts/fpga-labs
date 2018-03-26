--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:14:24 03/23/2018
-- Design Name:   
-- Module Name:   C:/xilinx_projects/LW3_SEC_TIM/TB_IND_DRV.vhd
-- Project Name:  LW3_SEC_TIM
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IND_DRV
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
 
ENTITY TB_IND_DRV IS
END TB_IND_DRV;
 
ARCHITECTURE behavior OF TB_IND_DRV IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IND_DRV
    PORT(
         DIG1 : IN  std_logic_vector(3 downto 0);
         DIG2 : IN  std_logic_vector(3 downto 0);
         DIG3 : IN  std_logic_vector(3 downto 0);
         DIG4 : IN  std_logic_vector(3 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         EN : IN  std_logic;
         CH_SEG : IN  std_logic;
         DIGIT : OUT  std_logic_vector(7 downto 0);
         CONTROL : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DIG1 : std_logic_vector(3 downto 0) := (others => '0');
   signal DIG2 : std_logic_vector(3 downto 0) := (others => '0');
   signal DIG3 : std_logic_vector(3 downto 0) := (others => '0');
   signal DIG4 : std_logic_vector(3 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal EN : std_logic := '0';
   signal CH_SEG : std_logic := '0';

 	--Outputs
   signal DIGIT : std_logic_vector(7 downto 0);
   signal CONTROL : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IND_DRV PORT MAP (
          DIG1 => DIG1,
          DIG2 => DIG2,
          DIG3 => DIG3,
          DIG4 => DIG4,
          RST => RST,
          CLK => CLK,
          EN => EN,
          CH_SEG => CH_SEG,
          DIGIT => DIGIT,
          CONTROL => CONTROL
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
 
 RST_process :process
   begin
		RST <= '1';
		wait for CLK_period*2;
		RST <= '0';
		wait;
   end process;
 
 CH_SEG_process :process
   begin
		CH_SEG <= '0';
		wait for CLK_period*10;
		CH_SEG <= '1';
		wait for CLK_period;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait until RST='0';	
      wait for CLK_period*10;

      -- insert stimulus here 
		DIG1<=x"8";
      DIG2<=x"4";
		DIG3<=x"2";
		DIG4<=x"1";
		EN<='1';
		wait for CLK_period;
		EN<='0';
		wait for CLK_period*100;
		
		DIG1<=x"3";
      DIG2<=x"5";
		DIG3<=x"7";
		DIG4<=x"9";
		EN<='1';
		wait for CLK_period;
		EN<='0';
		wait for CLK_period*100;
		
		DIG1<=x"A";
      DIG2<=x"B";
		DIG3<=x"C";
		DIG4<=x"D";
		EN<='1';
		wait for CLK_period;
		EN<='0';
		wait for CLK_period*100;
		wait;
   end process;

END;
