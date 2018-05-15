----------------------------------------------------------------------------------
-- Project Name: LW3 - Stopwatch/Timer using 8-buttons keyboard and 7-segment display
-- Module Name: IND_DRV - IND_DRV_ARCH
-- Create Date: 09:51:56 03/23/2018 
-- Description: 7-segment display driver
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IND_DRV is
   port ( 
		DIG1 : in  STD_LOGIC_VECTOR (3 downto 0);
      DIG2 : in  STD_LOGIC_VECTOR (3 downto 0);
      DIG3 : in  STD_LOGIC_VECTOR (3 downto 0);
      DIG4 : in  STD_LOGIC_VECTOR (3 downto 0);
      RST : in  STD_LOGIC;
      CLK : in  STD_LOGIC;
      EN : in  STD_LOGIC;
		CH_SEG : in  STD_LOGIC;
      DIGIT : out  STD_LOGIC_VECTOR (7 downto 0);
      CONTROL : out  STD_LOGIC_VECTOR (3 downto 0)
	);
end IND_DRV;

architecture IND_DRV_ARCH of IND_DRV is

signal dig1_s, dig2_s, dig3_s, dig4_s: std_logic_vector(3 downto 0);
signal selected_dig_s: std_logic_vector(3 downto 0);
signal seg_select_s: std_logic_vector(1 downto 0):=(others=>'0');

begin
	dig_reg: process(CLK,RST)
	begin
		if CLK'event and CLK='1' then
			if RST='1' then
				dig1_s <= (others => '0');
				dig2_s <= (others => '0');
				dig3_s <= (others => '0');
				dig4_s <= (others => '0');
			elsif EN='1' then
				dig1_s <= DIG1;
				dig2_s <= DIG2;
				dig3_s <= DIG3;
				dig4_s <= DIG4;
			end if;
		end if;
	end process;



	MUX_CONTROL:process(CLK,RST)
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				seg_select_s <= "00";
			elsif CH_SEG = '1' then
				seg_select_s <= seg_select_s + 1;
			end if;
		end if;
		
	end process;

	MUX: 
		selected_dig_s <= dig1_s when seg_select_s = "00" else
								dig2_s when seg_select_s = "01" else
								dig3_s when seg_select_s = "10" else
								dig4_s;
	SEG_SEL:
		CONTROL <= "1000" when seg_select_s = "00" else
					  "0100" when seg_select_s = "01" else
					  "0010" when seg_select_s = "10" else
					  "0001";

	HEX_TO_LED:
		DIGIT <=  "00111111" when selected_dig_s = "0000" else
					 "00000110" when selected_dig_s = "0001" else
					 "01011011" when selected_dig_s = "0010" else
					 "01001111" when selected_dig_s = "0011" else
					 "01100110" when selected_dig_s = "0100" else
					 "01101101" when selected_dig_s = "0101" else
					 "01111101" when selected_dig_s = "0110" else
					 "00000111" when selected_dig_s = "0111" else
					 "01111111" when selected_dig_s = "1000" else
					 "01101111" when selected_dig_s = "1001" else
					 "01000000";



end IND_DRV_ARCH;

