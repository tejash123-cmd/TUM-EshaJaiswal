--------------------------------------------------------------------------------
-- Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
-- Fakultät für Informatik, Technische Universität München
--------------------------------------------------------------------------------

--Libraries
library ieee;
use ieee.std_logic_1164.all;


entity muldiv is

	port (
        INPUT  	:	in	std_logic_vector(3 downto 0);
        SEL     :   in  std_logic;
		OUTPUT  :	out	std_logic_vector(4 downto 0)
	    );

end entity;
