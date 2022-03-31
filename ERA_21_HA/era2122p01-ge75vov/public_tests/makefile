# ------------------------------------------------------------------------------
# Copyright 2021, Lehrstuhl für Rechnerarchitektur & Parallele Systeme,
# Fakultät für Informatik, Technische Universität München
# ------------------------------------------------------------------------------

TARGET:=public_test

ADD_NAME:=fix_add
MUL_NAME:=fix_mul
SUB_NAME:=fix_sub
VEC_ADD_NAME:=fix_vec_add
VEC_CROSS_NAME:=fix_vec_cross
VEC_DOT_NAME:=fix_vec_dot
VEC_SUB_NAME:=fix_vec_sub
MAIN_NAME:=main
DEFINITIONS_NAME:=definitions
PARSE_CSV_NAME:=parse_csv
TESTS_NAME:=tests
MACRO_NAME:=macro
UNDERSCORE_NAME:=underscore_helper

BIN_DIR:=bin
ASS_DIR:=../assignment
SRC_DIR:=src

CPP_OBJS_LIST:=$(MAIN_NAME).o $(DEFINITIONS_NAME).o $(PARSE_CSV_NAME).o $(TESTS_NAME).o
C_OBJS_LIST:=$(MACRO_NAME).o
ASM_OBJS_LIST:=$(ADD_NAME).o $(MUL_NAME).o $(SUB_NAME).o $(VEC_ADD_NAME).o $(VEC_CROSS_NAME).o $(VEC_DOT_NAME).o $(VEC_SUB_NAME).o

CPP_OBJS:=$(addprefix $(BIN_DIR)/,$(CPP_OBJS_LIST))
C_OBJS:=$(addprefix $(BIN_DIR)/,$(C_OBJS_LIST))
ASM_OBJS:=$(addprefix $(ASS_DIR)/$(BIN_DIR)/,$(ASM_OBJS_LIST))

# define programs that will be used
CC?=gcc
ASM?=nasm
CXX?=g++

# define flags for programs
CXXFLAGS:=-O3 -m32 -std=c++17
CCFLAGS:=-O3 -m32
LDFLAGS:=-m32 -static-libstdc++ -static-libgcc
ASMFLAGS:=-f elf32 -dera_test
export ASMFLAGS

# add flags for operating systems
ifeq ($(OS),Windows_NT)
	ASMFLAGS += -dera_os_win
else
	ASMFLAGS += -dera_os_unix
endif

.PHONY: all asm_objects cpp_objects c_objects clean

# phonies
all: $(BIN_DIR)/$(TARGET)

asm_objects: $(BIN_DIR)/$(UNDERSCORE_NAME).o
	$(MAKE) -C $(ASS_DIR) objects

cpp_objects: $(CPP_OBJS)

c_objects: $(C_OBJS)

clean:
	$(RM) -r $(BIN_DIR)

$(BIN_DIR)/.empty:
	mkdir -p $(BIN_DIR)
	echo "" > $(BIN_DIR)/.empty

# macro.o
$(BIN_DIR)/$(MACRO_NAME).o: $(BIN_DIR)/.empty $(ASS_DIR)/$(MACRO_NAME).c
	$(CC) $(CCFLAGS) $(ASS_DIR)/$(MACRO_NAME).c -c -o $(BIN_DIR)/$(MACRO_NAME).o

# asm object files
$(BIN_DIR)/$(UNDERSCORE_NAME).o: $(BIN_DIR)/.empty $(SRC_DIR)/$(UNDERSCORE_NAME).asm
	$(ASM) $(ASMFLAGS) $(SRC_DIR)/$(UNDERSCORE_NAME).asm -o $(BIN_DIR)/$(UNDERSCORE_NAME).o

# cpp object files
$(BIN_DIR)/$(MAIN_NAME).o: $(BIN_DIR)/.empty $(SRC_DIR)/$(MAIN_NAME).cpp $(wildcard $(SRC_DIR)/*.hpp) $(wildcard $(SRC_DIR)/*.h)
	$(CXX) $(CXXFLAGS) $(SRC_DIR)/$(MAIN_NAME).cpp -c -o $(BIN_DIR)/$(MAIN_NAME).o

$(BIN_DIR)/$(DEFINITIONS_NAME).o: $(BIN_DIR)/.empty $(SRC_DIR)/$(DEFINITIONS_NAME).cpp $(wildcard $(SRC_DIR)/*.hpp) $(wildcard $(SRC_DIR)/*.h)
	$(CXX) $(CXXFLAGS) $(SRC_DIR)/$(DEFINITIONS_NAME).cpp -c -o $(BIN_DIR)/$(DEFINITIONS_NAME).o

$(BIN_DIR)/$(PARSE_CSV_NAME).o: $(BIN_DIR)/.empty $(SRC_DIR)/$(PARSE_CSV_NAME).cpp $(wildcard $(SRC_DIR)/*.hpp) $(wildcard $(SRC_DIR)/*.h)
	$(CXX) $(CXXFLAGS) $(SRC_DIR)/$(PARSE_CSV_NAME).cpp -c -o $(BIN_DIR)/$(PARSE_CSV_NAME).o

$(BIN_DIR)/$(TESTS_NAME).o: $(BIN_DIR)/.empty $(SRC_DIR)/$(TESTS_NAME).cpp $(wildcard $(SRC_DIR)/*.hpp) $(wildcard $(SRC_DIR)/*.h)
	$(CXX) $(CXXFLAGS) $(SRC_DIR)/$(TESTS_NAME).cpp -c -o $(BIN_DIR)/$(TESTS_NAME).o

# linking executable
$(BIN_DIR)/$(TARGET):	asm_objects cpp_objects c_objects
	$(CXX) $(LDFLAGS) $(CPP_OBJS) $(C_OBJS) $(ASM_OBJS) $(BIN_DIR)/$(UNDERSCORE_NAME).o -o $(BIN_DIR)/$(TARGET)
