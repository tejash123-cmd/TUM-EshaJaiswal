--------------------------------------------------------------------------------
-- Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
-- Fakultät für Informatik, Technische Universität München
--------------------------------------------------------------------------------

--Libraries
library ieee;
use ieee.std_logic_1164.all;


entity rechner is

	port (
        A 	            :	in	std_logic_vector(2 downto 0);
        B 	            :	in	std_logic_vector(2 downto 0);
        SEL             :   in  std_logic;
        SEGMENTS_0  	:	out	std_logic_vector(6 downto 0);
        SEGMENTS_1      :   out std_logic_vector(6 downto 0)
	    );

end entity;
