# ------------------------------------------------------------------------------
# Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
# Fakultät für Informatik, Technische Universität München
# ------------------------------------------------------------------------------

# define programs that will be used
CC?=gcc
ASM?=nasm
CXX?=g++
export ASM
export CC
export CXX

all:
	$(MAKE) -C assignment
	$(MAKE) -C public_tests
	$(MAKE) -C example_program
	@echo "***********************************"
	@echo "Everything compiled successfully"
	@echo "***********************************"

clean:
	$(MAKE) -C assignment clean
	$(MAKE) -C public_tests clean
	$(MAKE) -C example_program clean
