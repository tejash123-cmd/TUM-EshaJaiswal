--------------------------------------------------------------------------------
-- Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
-- Fakultät für Informatik, Technische Universität München
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity heizung_basic_tb is
end heizung_basic_tb;

architecture behavioral of heizung_basic_tb is
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

		temp_in <= "0001100000000000"; -- 24
		wait for 5 * clk_period;

		temp_in <= "0001001100000000"; -- 19
		wait for 5 * clk_period;

		temp_in <= "0001000000000000"; -- 16
		wait for 2 * clk_period;

		temp_in <= "0001001100000000"; -- 19
		wait for 5 * clk_period;

		temp_in <= "0001100000000000"; -- 24
		wait for 5 * clk_period;

		temp_in <= "0001001000000001"; -- >18
		wait for 5 * clk_period;

		temp_in <= "0001000000000000"; -- 16
		wait for 5 * clk_period;

		notaus_in <= '1';
		wait for clk_period;

		notaus_in <= '0';
		wait for 4 * clk_period;

		temp_in <= "0001100000000000"; -- 24
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
