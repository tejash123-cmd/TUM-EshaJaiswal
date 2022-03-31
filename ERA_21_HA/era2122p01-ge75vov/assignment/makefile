# ------------------------------------------------------------------------------
# Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
# Fakultät für Informatik, Technische Universität München
# ------------------------------------------------------------------------------

ADD_NAME:=fix_add
MUL_NAME:=fix_mul
SUB_NAME:=fix_sub
VEC_ADD_NAME:=fix_vec_add
VEC_CROSS_NAME:=fix_vec_cross
VEC_DOT_NAME:=fix_vec_dot
VEC_SUB_NAME:=fix_vec_sub
MACRO_NAME:=macro
BIN_DIR:=bin

# define programs that will be used
CC?=gcc
ASM?=nasm

# define flags for programs
CCFLAGS:=-Og -m32 -g
LDFLAGS:=-m32 -g -static-libgcc
ASMFLAGS?=-g -f elf32 -F dwarf

# add flags for operating systems
ifeq ($(OS),Windows_NT)
	ASMFLAGS += -dera_os_win
else
	ASMFLAGS += -dera_os_unix
endif

.PHONY: all objects clean

# phonies
all: $(BIN_DIR)/$(ADD_NAME) $(BIN_DIR)/$(MUL_NAME) $(BIN_DIR)/$(SUB_NAME) $(BIN_DIR)/$(VEC_ADD_NAME) $(BIN_DIR)/$(VEC_CROSS_NAME) $(BIN_DIR)/$(VEC_DOT_NAME) $(BIN_DIR)/$(VEC_SUB_NAME)

objects: $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

clean:
	$(RM) -r $(BIN_DIR)

$(BIN_DIR)/.empty:
	mkdir -p $(BIN_DIR)
	echo "" > $(BIN_DIR)/.empty

# macro.o
$(BIN_DIR)/$(MACRO_NAME).o: $(BIN_DIR)/.empty $(MACRO_NAME).c
	$(CC) $(CCFLAGS) $(MACRO_NAME).c -c -o $(BIN_DIR)/$(MACRO_NAME).o

# asm object files
$(BIN_DIR)/$(ADD_NAME).o: $(BIN_DIR)/.empty $(ADD_NAME).asm
	$(ASM) $(ASMFLAGS) $(ADD_NAME).asm -o $(BIN_DIR)/$(ADD_NAME).o -dera_test

$(BIN_DIR)/$(MUL_NAME).o: $(BIN_DIR)/.empty $(MUL_NAME).asm
	$(ASM) $(ASMFLAGS) $(MUL_NAME).asm -o $(BIN_DIR)/$(MUL_NAME).o -dera_test

$(BIN_DIR)/$(SUB_NAME).o: $(BIN_DIR)/.empty $(SUB_NAME).asm
	$(ASM) $(ASMFLAGS) $(SUB_NAME).asm -o $(BIN_DIR)/$(SUB_NAME).o -dera_test

$(BIN_DIR)/$(VEC_ADD_NAME).o: $(BIN_DIR)/.empty $(VEC_ADD_NAME).asm
	$(ASM) $(ASMFLAGS) $(VEC_ADD_NAME).asm -o $(BIN_DIR)/$(VEC_ADD_NAME).o -dera_test

$(BIN_DIR)/$(VEC_CROSS_NAME).o: $(BIN_DIR)/.empty $(VEC_CROSS_NAME).asm
	$(ASM) $(ASMFLAGS) $(VEC_CROSS_NAME).asm -o $(BIN_DIR)/$(VEC_CROSS_NAME).o -dera_test

$(BIN_DIR)/$(VEC_DOT_NAME).o: $(BIN_DIR)/.empty $(VEC_DOT_NAME).asm
	$(ASM) $(ASMFLAGS) $(VEC_DOT_NAME).asm -o $(BIN_DIR)/$(VEC_DOT_NAME).o -dera_test

$(BIN_DIR)/$(VEC_SUB_NAME).o: $(BIN_DIR)/.empty $(VEC_SUB_NAME).asm
	$(ASM) $(ASMFLAGS) $(VEC_SUB_NAME).asm -o $(BIN_DIR)/$(VEC_SUB_NAME).o -dera_test

# asm executable files
$(BIN_DIR)/$(ADD_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(ADD_NAME).asm -o $(BIN_DIR)/$(ADD_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(ADD_NAME) $(BIN_DIR)/$(ADD_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

$(BIN_DIR)/$(MUL_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(MUL_NAME).asm -o $(BIN_DIR)/$(MUL_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(MUL_NAME) $(BIN_DIR)/$(MUL_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

$(BIN_DIR)/$(SUB_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(SUB_NAME).asm -o $(BIN_DIR)/$(SUB_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(SUB_NAME) $(BIN_DIR)/$(SUB_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

$(BIN_DIR)/$(VEC_ADD_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(VEC_ADD_NAME).asm -o $(BIN_DIR)/$(VEC_ADD_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(VEC_ADD_NAME) $(BIN_DIR)/$(VEC_ADD_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

$(BIN_DIR)/$(VEC_CROSS_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(VEC_CROSS_NAME).asm -o $(BIN_DIR)/$(VEC_CROSS_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(VEC_CROSS_NAME) $(BIN_DIR)/$(VEC_CROSS_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

$(BIN_DIR)/$(VEC_DOT_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(VEC_DOT_NAME).asm -o $(BIN_DIR)/$(VEC_DOT_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(VEC_DOT_NAME) $(BIN_DIR)/$(VEC_DOT_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_SUB_NAME).o

$(BIN_DIR)/$(VEC_SUB_NAME): $(BIN_DIR)/$(MACRO_NAME).o objects
	$(ASM) $(ASMFLAGS) $(VEC_SUB_NAME).asm -o $(BIN_DIR)/$(VEC_SUB_NAME)_main.o
	$(CC) $(LDFLAGS) -o $(BIN_DIR)/$(VEC_SUB_NAME) $(BIN_DIR)/$(VEC_SUB_NAME)_main.o $(BIN_DIR)/$(MACRO_NAME).o $(BIN_DIR)/$(ADD_NAME).o $(BIN_DIR)/$(MUL_NAME).o $(BIN_DIR)/$(SUB_NAME).o $(BIN_DIR)/$(VEC_ADD_NAME).o $(BIN_DIR)/$(VEC_CROSS_NAME).o $(BIN_DIR)/$(VEC_DOT_NAME).o
