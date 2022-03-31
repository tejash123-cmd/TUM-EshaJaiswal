--------------------------------------------------------------------------------
-- Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
-- Fakultät für Informatik, Technische Universität München
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity heizung_advanced_tb is
end heizung_advanced_tb;

architecture behavioral of heizung_advanced_tb is
	-- from heizung.vhd
    component heizung
		port(
			CLK, NOTAUS: 	in std_logic;
			TEMP: 			in signed(15 downto 0);
			P1, P2: 		out std_logic
		);
    end component;
	signal   clk_in: 		std_logic := '0';
	constant clk_period: 	time := 1 sec;
  constant temp_low:          signed(15 downto 0) := "0001000100000000"; -- 17
  constant temp_low_thresh:   signed(15 downto 0) := "0001001000000000"; -- 18
  constant temp_medium:       signed(15 downto 0) := "0001001100000000"; -- 19
  constant temp_high_thresh:  signed(15 downto 0) := "0001010000000000"; -- 20
  constant temp_high:         signed(15 downto 0) := "0001100000000000"; -- 24

	signal notaus_in: 	std_logic := '0';
	signal temp_in: 		signed(15 downto 0) := "0001100000000000"; -- 24
	signal p1_imp, p2_imp: 	std_logic;
begin
	heizung_component: heizung port map (
		TEMP 	=> temp_in,
		NOTAUS => notaus_in,
		CLK 	=> clk_in,
		P1 		=> p1_imp,
		P2 		=> p2_imp
	);

	process
	begin
		wait for clk_period / 2;
    -- Begin Test --------------------------------------------------------------
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 3 * clk_period;
    temp_in <= temp_low;
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 3 * clk_period;
    temp_in <= temp_low;
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_high_thresh;
    wait for 3 * clk_period;
    temp_in <= temp_high_thresh - 1;
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low_thresh;
    wait for 3 * clk_period;
    temp_in <= temp_low_thresh - 1;
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= "0111111111111111";
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 3 * clk_period;
    temp_in <= temp_low;
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    temp_in <= temp_medium;
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    temp_in <= temp_low;
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 3 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 2 * clk_period;
    notaus_in <= '1';
    wait for 1 * clk_period;
    notaus_in <= '0';
    wait for 1 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 2 * clk_period;
    wait for 2 * clk_period / 10; -- 0.2
    notaus_in <= '1';
    wait for 1 * clk_period / 10; -- 0.1
    notaus_in <= '0';
    wait for 7 * clk_period / 10; -- 0.7
    wait for 2 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 2 * clk_period;
    wait for 6 * clk_period / 10; -- 0.6
    notaus_in <= '1';
    wait for 1 * clk_period / 10; -- 0.1
    notaus_in <= '0';
    wait for 3 * clk_period / 10; -- 0.3
    wait for 2 * clk_period;
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_medium;
    wait for 2 * clk_period / 10; -- 0.2
    notaus_in <= '1';
    wait for 1 * clk_period / 10; -- 0.1
    notaus_in <= '0';
    wait for 7 * clk_period / 10; -- 0.7
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    temp_in <= temp_low;
    wait for 6 * clk_period / 10; -- 0.6
    notaus_in <= '1';
    wait for 1 * clk_period / 10; -- 0.1
    notaus_in <= '0';
    wait for 3 * clk_period / 10; -- 0.3
    temp_in <= temp_high;
    wait for 2 * clk_period;
    wait for 2 * clk_period;
    wait for 7 * clk_period / 10; -- 0.7
    notaus_in <= '1';
    wait for 3 * clk_period / 10; -- 0.3
    temp_in <= temp_medium;
    wait for 3 * clk_period / 10; -- 0.3
    notaus_in <= '0';
    wait for 7 * clk_period / 10; -- 0.7
    temp_in <= temp_high;
    wait for 3 * clk_period;
    wait for 2 * clk_period;
    wait for 9 * clk_period / 10; -- 0.9
    notaus_in <= '1';
    wait for 1 * clk_period / 10; -- 0.1
    temp_in <= temp_low;
    wait for 1 * clk_period / 10; -- 0.1
    notaus_in <= '0';
    wait for 9 * clk_period / 10; -- 0.9
    temp_in <= temp_high;
    wait for 3 * clk_period;
    -- End Test ----------------------------------------------------------------
	end process;

	-- simulate clock
	process
	begin
	  clk_in <= '0';
	  wait for clk_period / 2;
	  clk_in <= '1';
	  wait for clk_period / 2;
	end process;
end;
