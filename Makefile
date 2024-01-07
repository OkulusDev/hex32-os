ASM := nasm
ASM_FLAGS := -f bin
VM := qemu-system-i386
VM_FLAGS := -fda

BIN_DIR := bin
SRC_DIR := src

TARGET := $(BIN_DIR)/hex32os.bin
ASM_SOURCES := $(shell find $(SRC_DIR)/boot/*.asm)
ASM_OBJECTS := $(patsubst $(SRC_DIR)/boot/%.asm,$(BIN_DIR)/%.o,$(ASM_SOURCES))
OBJECTS := $(shell find $(BIN_DIR)/*.o)

build: $(ASM_OBJECTS)

$(BIN_DIR)/%.o: $(SRC_DIR)/boot/%.asm
	$(ASM) $(ASM_FLAGS) -o $@ $<

run:
	$(VM) $(VM_FLAGS) $(OBJECTS)

clean:
	rm $(BIN_DIR)/*
