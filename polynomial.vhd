library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;
use ieee.std_logic_arith.all;
entity polynomial is 
  port( 
    clk, mode,clr : in std_ulogic;
    coefficient_addr 	  : in unsigned(1 downto 0);
		x             : in u_sfixed(5 downto -11);
		p 			      : out u_sfixed(26 downto -44);
		ovflow 		      : out bit
	);
end entity polynomial;

architecture rtl of  polynomial is

	signal m0    : u_sfixed(5 downto -11) := (others => '0');
	signal m1    : u_sfixed(5 downto -11) := (others => '0');
	signal m2    : u_sfixed(5 downto -11) := (others => '0');
	signal m3    : u_sfixed(5 downto -11) := (others => '0');
  type fsm is (idle, stage_1, stage_2, stage_3, eval_over);
  signal fsm_stages  : fsm := idle;
  signal next_fsm : fsm := idle;
  signal prev_fsm : fsm := idle;
  signal int_ovflow : bit := '0';
  signal stg_1_out : u_sfixed(12 downto -22) := (others => '0');
  signal stg_2_out : u_sfixed(19 downto -33) := (others => '0');
  signal stg_3_out : u_sfixed(26 downto -44) := (others => '0');
  
begin

fsm_process :process (clk,mode,coefficient_addr) is
begin
 
if rising_edge(clk) then
	if clr = '1' then
    m0        <= (others => '0');
    m1        <= (others => '0');
    m2        <= (others => '0');
    m3        <= (others => '0');
    stg_1_out <= (others => '0');
    stg_2_out <= (others => '0');
    stg_3_out <= (others => '0');
    fsm_stages <= idle;
    prev_fsm  <= idle;
    next_fsm  <= idle;
    int_ovflow   <= '0';
	else
		if mode = '1' then
			case coefficient_addr is
				when "00" 	=> 
          m0 <= x;
				when "01" 	=>	
          m1 <= x;
				when "10"   => 
          m2 <= x;
				when others => 
          m3 <= x;
			end case;
    else
      fsm_stages <= idle;
      case fsm is
        when stage_1 =>
          stg_1_out  <= m2 + m3 * x; 
          fsm_stages <= eval_over;
          next_fsm   <= stage_2;
          prev_fsm   <= stage_1;
          
        when stage_2 =>
          stg_2_out <= m1 + stg_1_out * x; 
          fsm_stages <= eval_over;
          next_fsm <= stage_3;
          prev_fsm <= stage_2;
          
        when stage_3 =>
          stg_3_out <= m0 + stg_2_out * x; 
          fsm_stages <= eval_over;
          next_fsm <= idle;
          prev_fsm <= stage_3
          
        when eval_over =>
          if prev_fsm = "stage_1" and (int_ovf = '1' or stg_1_out > 16 or stg_1_out < -16) then 
            int_ovflow   <= '1';
          elsif prev_fsm = "stage_2" and (int_ovf = '1' or stg_2_out > 16 or stg_2_out < -16) then
            int_ovflow   <= '1';
          elsif prev_fsm = "stage_3" and  (int_ovf = '1' or stg_3_out > 16 or stg_3_out < -16) then
            int_ovflow   <= '1'; 
          else
            int_ovflow   <= '0';
          end if;
          fsm_stages <= next_fsm;
        
        when idle => 
          if ( mode = '0') then
            fsm_stages <= stage_1;
          end if;
      end case;
    end if;
	end if;
end if;
  p   <= stg_3_out;
  ovflow <= int_ovflow;
end process;
end architecture rtl;