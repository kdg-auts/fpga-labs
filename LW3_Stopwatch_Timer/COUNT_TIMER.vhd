----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:12 04/06/2018 
-- Design Name: 
-- Module Name:    COUNT_TIMER - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COUNT_TIMER is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           EN : in  STD_LOGIC;
			  TIC : in  STD_LOGIC;
           SEC : in  STD_LOGIC;
           TIM : in  STD_LOGIC;
           START : in  STD_LOGIC;
           STOP : in  STD_LOGIC;
           SETUP : in  STD_LOGIC_VECTOR (3 downto 0);
           BUZZ : out  STD_LOGIC;
           SEC_M : out  STD_LOGIC;
           TIM_M : out  STD_LOGIC;
           M_H : out  STD_LOGIC_VECTOR (3 downto 0);
           M_L : out  STD_LOGIC_VECTOR (3 downto 0);
           S_H : out  STD_LOGIC_VECTOR (3 downto 0);
           S_L : out  STD_LOGIC_VECTOR (3 downto 0));
end COUNT_TIMER;

architecture COUNT_TIMER_ARCH of COUNT_TIMER is
	signal MODE: natural:=0;
	type state_t is (IDLE,COUNT);
	signal CT_State: state_t := IDLE;
	signal S_L_s : STD_LOGIC_VECTOR (3 downto 0);
	signal S_H_s : STD_LOGIC_VECTOR (3 downto 0);
	signal M_L_s : STD_LOGIC_VECTOR (3 downto 0);
	signal M_H_s : STD_LOGIC_VECTOR (3 downto 0);

begin
	state_machine : process (CLK,RST)
		
		begin
			if RST='1' then
				CT_State <= IDLE;
				MODE <= 0;
				S_L_s <= (others=>'0');
				S_H_s <= (others=>'0');
				M_L_s <= (others=>'0');
				M_H_s <= (others=>'0');
				BUZZ <= '0';
			elsif CLK'event and CLK='1' then
				if EN='1' then
					BUZZ<='0';
					case CT_State is
						
						when IDLE => -- prepare state
							if TIM='1' then -- button TIMER is pressed
								MODE<=1;
							elsif SEC='1' then -- button STOPWATCH is pressed
								MODE<=0;
							elsif SETUP(0)='1' then -- setup ordinate seconds
								if TIC='1' then
									if S_L_s="1001" then
										S_L_s<="0000";
									else 
										S_L_s<=S_L_s+1;
									end if;
								end if;
							elsif SETUP(1)='1' then -- setup seconds decades
								if TIC='1' then
									if S_H_s="0101" then
										S_H_s<="0000";
									else 
										S_H_s<=S_H_s+1;
									end if;
								end if;
							elsif SETUP(2)='1' then -- setup ordinary minutes
								if TIC='1' then
									if M_L_s="1001" then
										M_L_s<="0000";
									else 
										M_L_s<=M_L_s+1;
									end if;
								end if;
							elsif SETUP(3)='1' then -- setup minutes decades
								if TIC='1' then
									if M_H_s="0101" then
										M_H_s<="0000";
									else 
										M_H_s<=M_H_s+1;
									end if;
								end if;
							elsif START='1' then -- button START pressed
								CT_State<=COUNT;
							end if;
						
						when COUNT=>
							if TIC='1' then
								if MODE=0 then -- count mode
									if STOP='1' then
										CT_State<=IDLE;
									elsif S_L_s<"1001" then
										S_L_s<=S_L_s+1;
									elsif S_H_s<"0101" then
										S_L_s <= "0000";
										S_H_s<=S_H_s+1;
									elsif M_L_s<"1001" then
										S_H_s <= "0000";
										M_L_s<=M_L_s+1;
									elsif M_H_s<"0101" then
										M_L_s <= "0000";
										M_H_s<=M_H_s+1;
									else 
										M_H_s<=(others=>'0');
										M_L_s<=(others=>'0');
										S_H_s<=(others=>'0');
										S_L_s<=(others=>'0');
										BUZZ<='1';
										CT_State<=IDLE;
									end if;
								elsif MODE=1 then 
									if STOP='1' then
										CT_State<=IDLE;
									elsif S_L_s>"0000" then
										S_L_s<=S_L_s-1;
									elsif S_H_s>"0000" then
										S_L_s <= "1001";
										S_H_s<=S_H_s-1;
									elsif M_L_s>"0000" then
										S_H_s <= "0101";
										M_L_s<=M_L_s-1;
									elsif M_H_s>"0000" then
										M_L_s <= "1001";
										M_H_s<=M_H_s-1;
									else 
										M_H_s<=(others=>'0');
										M_L_s<=(others=>'0');
										S_H_s<=(others=>'0');
										S_L_s<=(others=>'0');
										BUZZ<='1';
										CT_State<=IDLE;
									end if;
								end if;
							end if;
						when others => 
							NULL;
					end case;
				end if;
			end if;
		end process;

	S_L <= S_L_s;
	S_H <= S_H_s;
	M_L <= M_L_s;
	M_H <= M_H_s;
		
end COUNT_TIMER_ARCH;

