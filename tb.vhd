library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_arith.all;

entity polynomial_tb is
end entity polynomial_tb;

architecture test_polynomial of polynomial_tb is
	signal clk, mode, clr : std_ulogic;
	signal coeff_addr : unsigned(1 downto 0);
	signal x : u_sfixed(5 downto -11);
	signal p : u_sfixed(26 downto -44);
  signal ovf : bit;
begin
	dut: entity work.polynomial(rtl)
		port map(
				 clk        => clk, 
				 mode       => mode, 
			   clr        => clr, 
				 coeff_addr => coeff_addr, 
				 x          => x, 
				 p          => p, 
				 ovf        => ovf
				 );
	stimulus: process is
	begin
		clk <= '1';
		mode <= '1';
		clr <= '1';
    wait for 50ps;
    clr <= '0';
    coeff_addr <= "00";
		--- a0 = 1
    x <= "00000100000000000"; 
    wait for 500ps;
		coeff_addr <= "01";
		--- a1 = 1
    x <= "00000100000000000"; 
    wait for 500ps;
		coeff_addr <= "10";
		--- a3 = 1/2
    x <= "00000010000000000";
    wait for 500ps;
		coeff_addr <= "11";
		--- a4 = 1/6
    x <= "00000000101010101"; 
    wait for 500ps;
		mode <= '0'; 
    --- x = 1
    x <= "00000100000000000";
    wait for 500ps;
    wait;
	end process stimulus;
end architecture test_polynomial;
