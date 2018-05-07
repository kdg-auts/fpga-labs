--------------------------------------------------------------------------------
-- Project Name: LW3 - Stopwatch/Timer using 8-buttons keyboard and 7-segment display
-- Module Name: TB_COUNT_TIMER
-- Module Type: testbench
-- Unit Under Test: COUNT_TIMER
-- Create Date: 11:03:00 04/27/2018
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
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
   uut: COUNT_TIMER 
	PORT MAP (
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
		-- reset section
		RST <='1';
      wait for 100 ns;	-- hold reset state for 100 ns
		RST <='0';
      wait for CLK_period*10; -- cooldown pause

      -- тестирование секундомера 
		SEC <= '1'; -- переключение в режим "секундомер" (имитация нажатия кнопки)
		wait for 50 ns;
		SEC <= '0';
		wait for 50 ns;
		START <= '1'; -- запуск отсчета секунд (имитация нажатия кнопки)
		wait for 50 ns;
		START <= '0';
		wait for CLK_period*100; -- ожидание 10 отсчетов
		STOP <= '1'; -- остановка отсчета (имитация нажатия кнопки)
		wait for 150 ns;
		STOP <= '0';
		wait for 50 ns;
		
		-- тестирование таймера
		TIM <= '1'; -- переключение в режим "таймер" (имитация нажатия кнопки)
		wait for 50 ns;
		TIM <= '0';
		wait for 50 ns;
		START <= '1'; -- запуск таймера (имитация нажатия кнопки); начальное состояние осталось от работы секундомера (10 секунд)
		wait for 50 ns;
		START <= '0';
		wait for CLK_period*125;
		
		--wait until BUZZ='1';
		--wait for CLK_period*10;
		
		SETUP(0)<='1';
		wait for CLK_period*100;
		SETUP(0)<='0';
		wait for CLK_period*20;
		
		SETUP(1)<='1';
		wait for CLK_period*100;
		SETUP(1)<='0';
		wait for CLK_period*20;
		
		SETUP(2)<='1';
		wait for CLK_period*100;
		SETUP(2)<='0';
		wait for CLK_period*20;
		
		SETUP(3)<='1';
		wait for CLK_period*100;
		SETUP(3)<='0';
		wait for CLK_period*20;
		
--		for i in 0 to 9 loop
--		SETUP(0)<='1';
--		wait for 50 ns;
--		SETUP(0)<='0';
--		wait for 150 ns;
--		end loop;
--		
--		for i in 0 to 5 loop
--		SETUP(1)<='1';
--		wait for 50 ns;
--		SETUP(1)<='0';
--		wait for 150 ns;
--		end loop;
--		
--		for i in 0 to 9 loop
--		SETUP(2)<='1';
--		wait for 50 ns;
--		SETUP(2)<='0';
--		wait for 150 ns;
--		end loop;
--		
--		for i in 0 to 5 loop
--		SETUP(3)<='1';
--		wait for 50 ns;
--		SETUP(3)<='0';
--		wait for 150 ns;
--		end loop;
		
		
      wait;
   end process;

END;
