# Compiler and flags
NASM := nasm
QEMU := qemu-system-x86_64
OBJCOPY := objcopy

# Directories
SRC_DIR := src
BIN_DIR := bin
BIN_STAGE_1_DIR := $(BIN_DIR)/stage_1
BIN_STAGE_2_DIR := $(BIN_DIR)/stage_2

# Source files
ASM_STAGE_1_FILES := $(wildcard $(SRC_DIR)/stage_1/*.asm)
ASM_STAGE_2_FILES := $(wildcard $(SRC_DIR)/stage_2/*.asm)

OBJ_STAGE_1_FILES := $(patsubst $(SRC_DIR)/stage_1/%.asm,$(BIN_STAGE_1_DIR)/%.bin,$(ASM_STAGE_1_FILES))
OBJ_STAGE_2_FILES := $(patsubst $(SRC_DIR)/stage_2/%.asm,$(BIN_STAGE_2_DIR)/%.bin,$(ASM_STAGE_2_FILES))

# Targets
all: $(OBJ_STAGE_1_FILES) $(OBJ_STAGE_2_FILES)

$(BIN_STAGE_1_DIR)/%.bin: $(SRC_DIR)/stage_1/%.asm | $(BIN_STAGE_1_DIR)
	$(NASM) -f bin -o $@ $<

$(BIN_STAGE_2_DIR)/%.bin: $(SRC_DIR)/stage_2/%.asm | $(BIN_STAGE_2_DIR)
	$(NASM) -f bin -o $@ $<

$(BIN_STAGE_1_DIR) $(BIN_STAGE_2_DIR):
	mkdir -p $@

.PHONY: run
run: $(BIN_STAGE_1_DIR)/mortar_s1.bin
	$(QEMU) -fda $<

.PHONY: clean
clean:
	rm -rf $(BIN_DIR)
