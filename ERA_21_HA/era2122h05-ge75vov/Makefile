# ------------------------------------------------------------------------------
# Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
# Fakultät für Informatik, Technische Universität München
# ------------------------------------------------------------------------------

# define filenames
TEMPLATE_NAME:=u5_template
TEST_NAME:=u5_test
INC_NAME:=u5_test.inc
MACRO_NAME:=macro

# define programs that will be used
CC:=gcc
ASM:=nasm


# define flags for programs
CCFLAGS:=-c -Og -m32 -g
LDFLAGS:=-m32 -g -static-libgcc
ASMFLAGS:=-g -f elf32 -F dwarf
TEST_FLAGS:=-dera_test

# add flags for operating systems
ifeq ($(OS),Windows_NT)
	ASMFLAGS += -dera_os_win
else
	ASMFLAGS += -dera_os_unix
endif

# setup phony targets
.PHONY: all template test clean

# everything
all: template test

$(MACRO_NAME).o: $(MACRO_NAME).c
	$(CC) $(LDFLAGS) $(MACRO_NAME).c -c -o $(MACRO_NAME).o

# main and tests
template:  $(MACRO_NAME).o
	$(ASM) $(ASMFLAGS) $(TEMPLATE_NAME).asm -o $(TEMPLATE_NAME).o
	$(CC) $(LDFLAGS) -o $(TEMPLATE_NAME) $(TEMPLATE_NAME).o $(MACRO_NAME).o

# tests only
test: $(MACRO_NAME).o
	$(ASM) $(ASMFLAGS) $(TEST_FLAGS) $(TEMPLATE_NAME).asm -o $(TEMPLATE_NAME).o
	$(ASM) $(ASMFLAGS) $(TEST_FLAGS) $(TEST_NAME).asm -o $(TEST_NAME).o
	$(CC) $(LDFLAGS) -o $(TEST_NAME) $(TEMPLATE_NAME).o $(TEST_NAME).o $(MACRO_NAME).o

# clean up
clean:
	$(RM) $(TEMPLATE_NAME) $(TEST_NAME)
