-------------------------------------------------------------------------------
-- Title       : gf256_mul_func
-- Design      : kalyna_cipher_plain
-- Author      : kdg
-- Company     : auts_khpi
-- File        : gf256_mul_func.vhd
-- Generated   : Wed May 23 08:36:14 2018
-------------------------------------------------------------------------------
-- Description : Calculate multiplication over GF(2^8) with fixed modulo 
--               polinomial 0x11D. Is used in Kalyna block cipher harware
--               implementation. Functional implementation.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity gf256_mul_func is
	 port(
		 OP_A : in STD_LOGIC_VECTOR(7 downto 0);
		 OP_B : in STD_LOGIC_VECTOR(7 downto 0);
		 MUL : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end gf256_mul_func;

architecture gf256_mul_func_arch of gf256_mul_func is
begin

	mul_proc: process(OP_A, OP_B)
		variable op1, op2, result : unsigned(7 downto 0);
		variable ovf : std_logic;
		constant mpol : unsigned(8 downto 0) := "100011101"; -- 0x11D -- "100011011"; -- 0x11B --
	begin		
		op1 := unsigned(OP_A);
		op2 := unsigned(OP_B);
		result := (others => '0');
		while op1 /= 0 loop
			if op1(0) = '1' then
				result := result xor op2;
			end if;
			ovf := op2(7);
			op2 := op2(6 downto 0) & '0';
			if ovf = '1' then
				op2 := op2 xor mpol(7 downto 0); -- x"1D";
			end if;
			op1 := '0' & op1(7 downto 1);
		end loop;
		MUL <= std_logic_vector(result);
	end process;

end gf256_mul_func_arch;
