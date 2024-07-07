ASM=nasm
SRC_DIR=src
BUILD_DIR=build
OBJ_DIR=obj

.PHONY: all clean

all: build_tree main

build_tree:
	@if [ ! -d "$(BUILD_DIR)" ]; then\
		mkdir -pv $(BUILD_DIR);\
	fi
	@if [ ! -d "$(OBJ_DIR)" ]; then\
		mkdir -pv $(OBJ_DIR);\
	fi

main: $(BUILD_DIR)/main

$(BUILD_DIR)/main: $(OBJ_DIR)/main.o
	ld -o $(BUILD_DIR)/main $(OBJ_DIR)/main.o

$(OBJ_DIR)/main.o: $(SRC_DIR)/main.asm
	nasm -f elf64 -g -F dwarf $(SRC_DIR)/main.asm -o $(OBJ_DIR)/main.o

clean:
	@rm -rvf {$(BUILD_DIR),$(OBJ_DIR)}
