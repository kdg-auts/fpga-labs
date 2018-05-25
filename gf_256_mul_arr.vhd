-------------------------------------------------------------------------------
-- Title       : gf_256_mul_arr
-- Design      : kalyna_cipher_plain
-- Author      : kdg
-- Company     : auts_khpi
-- File        : gf_256_mul_arr.vhd
-- Generated   : Wed May 23 11:02:08 2018
-------------------------------------------------------------------------------
-- Description : Calculate multiplication over GF(2^8) with fixed modulo 
--               polinomial 0x11D. Is used in Kalyna block cipher harware
--               implementation. Functional implementation.
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity gf_256_mul_arr is
	 port(
		 OP_A : in STD_LOGIC_VECTOR(7 downto 0);
		 OP_B : in STD_LOGIC_VECTOR(7 downto 0);
		 MUL : out STD_LOGIC_VECTOR(7 downto 0)
	     );
end gf_256_mul_arr;

architecture gf_256_mul_arr_arch of gf_256_mul_arr is
	signal muld_x002, muld_x004, muld_x008, muld_x016, muld_x032, muld_x064, muld_x128, 
	       mpol_x001, mpol_x002, mpol_x004, mpol_x008, mpol_x016, mpol_x032, mpol_x064,
		   mul_res, mod_res0, mod_res1, mod_res2, mod_res3, mod_res4, mod_res5, mod_res : std_logic_vector(15 downto 0) := (others => '0');
	constant mod_pol : std_logic_vector(8 downto 0) := "100011101"; -- field modulo polynomial, 0x11D
begin
	-- prepare shifted multiplicands
	muld_x002( 8 downto 1) <= OP_B when OP_A(1) = '1' else (others => '0'); 
	muld_x004( 9 downto 2) <= OP_B when OP_A(2) = '1' else (others => '0');
	muld_x008(10 downto 3) <= OP_B when OP_A(3) = '1' else (others => '0');
	muld_x016(11 downto 4) <= OP_B when OP_A(4) = '1' else (others => '0');
	muld_x032(12 downto 5) <= OP_B when OP_A(5) = '1' else (others => '0');
	muld_x064(13 downto 6) <= OP_B when OP_A(6) = '1' else (others => '0');
	muld_x128(14 downto 7) <= OP_B when OP_A(7) = '1' else (others => '0');
	-- calculate full product (be careful - it's not like arithmetic product A*B !)
	mul_res <= ("00000000" & OP_B) xor muld_x002 xor muld_x004 xor muld_x008 xor muld_x016 xor muld_x032 xor muld_x064 xor muld_x128;
	-- calculate shifted modules to reduce result and perform intermediate calculations
	mpol_x064 <= '0' & (mul_res(14) and mod_pol(8)) & (mul_res(14) and mod_pol(7)) & (mul_res(14) and mod_pol(6)) & (mul_res(14) and mod_pol(5)) & (mul_res(14) and mod_pol(4)) & (mul_res(14) and mod_pol(3)) & (mul_res(14) and mod_pol(2)) & (mul_res(14) and mod_pol(1)) & (mul_res(14) and mod_pol(0)) & "000000";
	mod_res0 <= mul_res xor mpol_x064;
	mpol_x032 <= "00" & (mod_res0(13) and mod_pol(8)) & (mod_res0(13) and mod_pol(7)) & (mod_res0(13) and mod_pol(6)) & (mod_res0(13) and mod_pol(5)) & (mod_res0(13) and mod_pol(4)) & (mod_res0(13) and mod_pol(3)) & (mod_res0(13) and mod_pol(2)) & (mod_res0(13) and mod_pol(1)) & (mod_res0(13) and mod_pol(0)) & "00000";	
	mod_res1 <= mod_res0 xor mpol_x032;	  
	mpol_x016 <= "000" & (mod_res1(12) and mod_pol(8)) & (mod_res1(12) and mod_pol(7)) & (mod_res1(12) and mod_pol(6)) & (mod_res1(12) and mod_pol(5)) & (mod_res1(12) and mod_pol(4)) & (mod_res1(12) and mod_pol(3)) & (mod_res1(12) and mod_pol(2)) & (mod_res1(12) and mod_pol(1)) & (mod_res1(12) and mod_pol(0)) & "0000";	
	mod_res2 <= mod_res1 xor mpol_x016;
	mpol_x008 <= "0000" & (mod_res2(11) and mod_pol(8)) & (mod_res2(11) and mod_pol(7)) & (mod_res2(11) and mod_pol(6)) & (mod_res2(11) and mod_pol(5)) & (mod_res2(11) and mod_pol(4)) & (mod_res2(11) and mod_pol(3)) & (mod_res2(11) and mod_pol(2)) & (mod_res2(11) and mod_pol(1)) & (mod_res2(11) and mod_pol(0)) & "000";
	mod_res3 <= mod_res2 xor mpol_x008;
	mpol_x004 <= "00000" & (mod_res3(10) and mod_pol(8)) & (mod_res3(10) and mod_pol(7)) & (mod_res3(10) and mod_pol(6)) & (mod_res3(10) and mod_pol(5)) & (mod_res3(10) and mod_pol(4)) & (mod_res3(10) and mod_pol(3)) & (mod_res3(10) and mod_pol(2)) & (mod_res3(10) and mod_pol(1)) & (mod_res3(10) and mod_pol(0)) & "00";	
	mod_res4 <= mod_res3 xor mpol_x004;
	mpol_x002 <= "000000" & (mod_res4(9) and mod_pol(8)) & (mod_res4(9) and mod_pol(7)) & (mod_res4(9) and mod_pol(6)) & (mod_res4(9) and mod_pol(5)) & (mod_res4(9) and mod_pol(4)) & (mod_res4(9) and mod_pol(3)) & (mod_res4(9) and mod_pol(2)) & (mod_res4(9) and mod_pol(1)) & (mod_res4(9) and mod_pol(0)) & '0'; 
	mod_res5 <= mod_res4 xor mpol_x002;
	mpol_x001 <= "0000000" & (mod_res5(8) and mod_pol(8)) & (mod_res5(8) and mod_pol(7)) & (mod_res5(8) and mod_pol(6)) & (mod_res5(8) and mod_pol(5)) & (mod_res5(8) and mod_pol(4)) & (mod_res5(8) and mod_pol(3)) & (mod_res5(8) and mod_pol(2)) & (mod_res5(8) and mod_pol(1)) & (mod_res5(8) and mod_pol(0));
	-- reduce mul_res by module polynomial
	mod_res <= mod_res5 xor mpol_x001; 
	-- cut actual result from calc buffer
	MUL <= mod_res(7 downto 0);
end gf_256_mul_arr_arch;
