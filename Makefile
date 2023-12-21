WORK_DIR  = $(shell pwd)
INC_PATH ?= $(WORK_DIR)/include
INCFLAGS = $(addprefix -I, $(INC_PATH))

CC := gcc
CFLAGS := -O2 -std=gnu99 -mavx2 -g -ggdb $(INCFLAGS)
LDFLAGS := -lm -lpthread
BUILD_DIR := $(WORK_DIR)/build
CSRC = $(shell find $(abspath ./csrc) -name "*.c" -or -name "*.cc" -or -name "*.cpp")

all: $(BUILD_DIR)/oai_dfts_avx2

$(BUILD_DIR)/oai_dfts_avx2: $(CSRC) | $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) -DMR_MAIN

$(BUILD_DIR):
	mkdir -p $@

run: $(BUILD_DIR)/oai_dfts_avx2
	cd $(BUILD_DIR) && ./oai_dfts_avx2

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean

