# ------------------------------------------------------------------------------
# Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
# Fakultät für Informatik, Technische Universität München
# ------------------------------------------------------------------------------

ADDIERER_NAME=addierer
MULDIV_NAME=muldiv
DISPLAY_NAME=display
RECHNER_NAME=rechner
RECHNER_TB=rechner_tb

OUT = rechner.vcd
STOP = 500ns

# define programs that will be used
GHDL?=ghdl

all:
	$(GHDL) -a $(ADDIERER_NAME).vhdl $(MULDIV_NAME).vhdl $(DISPLAY_NAME).vhdl $(RECHNER_NAME).vhdl $(RECHNER_TB).vhdl
	$(GHDL) -e $(ADDIERER_NAME)
	$(GHDL) -e $(MULDIV_NAME)
	$(GHDL) -e $(DISPLAY_NAME)
	$(GHDL) -e $(RECHNER_NAME)
	$(GHDL) -e $(RECHNER_TB)
	$(GHDL) -r $(RECHNER_TB) --vcd=$(OUT) --stop-time=$(STOP)

clean:
	$(GHDL) --remove
