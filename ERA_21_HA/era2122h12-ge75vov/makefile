# ------------------------------------------------------------------------------
# Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
# Fakultät für Informatik, Technische Universität München
# ------------------------------------------------------------------------------

HEIZUNG_NAME=heizung
BASIC_TB_NAME=heizung_basic_tb
ADVANCED_TB_NAME=heizung_advanced_tb

# define programs that will be used
GHDL?=ghdl

.PHONY: all basic_tb advanced_tb

all:
	$(GHDL) -a $(HEIZUNG_NAME).vhd

basic_tb:
	$(GHDL) -a $(HEIZUNG_NAME).vhd $(BASIC_TB_NAME).vhd
	$(GHDL) -e $(HEIZUNG_NAME)
	$(GHDL) -e $(BASIC_TB_NAME)
	$(GHDL) -r $(BASIC_TB_NAME)  --vcd=basic_tb.vcd --stop-time=80sec

advanced_tb:
	$(GHDL) -a $(HEIZUNG_NAME).vhd $(ADVANCED_TB_NAME).vhd
	$(GHDL) -e $(HEIZUNG_NAME)
	$(GHDL) -e $(ADVANCED_TB_NAME)
	$(GHDL) -r $(ADVANCED_TB_NAME)  --vcd=advanced_tb.vcd --stop-time=187sec
