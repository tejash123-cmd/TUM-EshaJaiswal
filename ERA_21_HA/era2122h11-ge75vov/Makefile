NAME=sevensegment
NAME_TB=sevensegment_tb
COUNT=countdown
all:
	ghdl -a $(NAME).vhd
	ghdl -a $(COUNT).vhd
	ghdl -a $(NAME_TB).vhd
	ghdl -e $(NAME)
	ghdl -e $(COUNT)
	ghdl -e $(NAME_TB)
	ghdl -r $(NAME_TB) --vcd=$(NAME).vcd --stop-time=1000fs
clean:
	rm $(NAME).o *.cf
