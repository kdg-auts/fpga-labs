----------------------------------------------------------------------------------
-- Project Name: LW2 - LED control with joystick and buzzer
-- Module Name: LED_driver_v2 - ld_v2_arch
-- Create Date: 10:22:30 03/02/2018 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LED_driver_v2 is
	port ( 
		CLK : in  STD_LOGIC;
		RST : in  STD_LOGIC;
		EN : in  STD_LOGIC;
		count_up : in  STD_LOGIC;
		count_down : in  STD_LOGIC;
		initial : in  STD_LOGIC;
		LED : out  STD_LOGIC_vector (3 downto 0);
		BUZZ_T : out  STD_LOGIC
	); 
end LED_driver_v2;

architecture ld_v2_arch of LED_driver_v2 is
	signal led_state: natural range 0 to 16 := 0;
begin
	led_driving: process (CLK, RST, EN)
		begin
		if clk'event and clk = '1' then
			if RST ='1' then -- reset events
				led_state <= 5;
				LED <= "1111";
			elsif EN ='1' then -- normal operation
				-- define led state when buttons pressed
				if count_up = '1' and count_down = '0' and initial = '0' then
					if led_state < 9 then
						led_state <= led_state + 1;
					end if;
				elsif count_up = '0' and  count_down = '1' and initial = '0' then
					if led_state > 0 then
						led_state <= led_state - 1;
					end if;
				elsif count_up = '0' and count_down = '0' and initial = '1' then
					led_state <= 5;
				end if;
				-- led enlighting based on led_state
				case led_state is
					when 0 => LED <= "0000";
					when 1 => LED <= "0001";
					when 2 => LED <= "0010";
					when 3 => LED <= "0011";
					when 4 => LED <= "0100";
					when 5 => LED <= "0101";
					when 6 => LED <= "0110";
					when 7 => LED <= "0111";
					when 8 => LED <= "1000";
					when 9 => LED <= "1001";
					when others => LED <= "1111";
				end case;
			end if; -- normal operation
		end if; -- clock
	end process;

	buzz_driving: process (CLK, EN)
	begin
		if clk'event and clk = '1' then
			if EN = '1' then
				BUZZ_T <= '0'; -- default state: no buzz
				if led_state = 0 and count_down = '1' then
					BUZZ_T <= '1'; -- buzz when min count
				elsif led_state = 9 and count_up = '1' then
					BUZZ_T <= '1'; -- buzz when max count
				end if;
			end if;
		end if;
	end process;

end ld_v2_arch;

