--------------------------------------------------------------------------------
-- Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
-- Fakultät für Informatik, Technische Universität München
--------------------------------------------------------------------------------

--Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- this may be useful, have a look at conversions in vhdl

entity display is

	port (
		VALUE 	        :	in	std_logic_vector(4 downto 0);
        SEGMENTS_0  	:	out	std_logic_vector(6 downto 0);
        SEGMENTS_1      :   out std_logic_vector(6 downto 0)
	    );

end entity;
