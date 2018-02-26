----------------------------------------------------------------------------------
-- Project Name: LW1 - Simple LED control
-- Module Name: led_driver - led_driver_arch 
-- Create Date: 11:43:30 02/16/2018 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led_driver is
	port ( 
		CLK : in  STD_LOGIC;
		RST : in  STD_LOGIC;
		EN : in  STD_LOGIC;
		LED : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end led_driver;

architecture led_driver_arch of led_driver is

begin
	LED_driving: process(CLK, RST, EN)  
		variable led_state: integer range 0 to 9 := 0;
	begin 
		if clk'event and clk = '1' then
			if RST = '1' then
				led <= "1111";
				led_state := 0;
			elsif EN = '1' then 

					case led_state is
						when 0      =>  led <= "1111"; 
						when 1      =>  led <= "1110"; 
						when 2      =>  led <= "1101"; 
						when 3      =>  led <= "1100";
						when 4      =>  led <= "1011";
						when 5      =>  led <= "1010";
						when 6      =>  led <= "1001";
						when 7      =>  led <= "1000";
						when 8      =>  led <= "0111";
						when 9      =>  led <= "0110";
						when others =>  led <= "1111"; 
					end case; 
					
					if led_state = 9 then
						led_state := 0;
					else
						led_state := led_state + 1; 
					end if;
			end if;
		end if; 
	end process; 

end led_driver_arch;