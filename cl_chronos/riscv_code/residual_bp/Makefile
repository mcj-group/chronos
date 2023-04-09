# Amazon FPGA Hardware Development Kit
#
# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use
# this file except in compliance with the License. A copy of the License is
# located at
#
#    http://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
# implied. See the License for the specific language governing permissions and
# limitations under the License.

#VPATH = src:include:$(HDK_DIR)/common/software/src:$(HDK_DIR)/common/software/include

INCLUDES = -I$(SDK_DIR)/userspace/include 

#CC = riscv-none-embed-gcc
#CFLAGS = -march=rv32i -mabi=ilp32 -T linker_script 
CC = riscv64-unknown-elf-g++
CFLAGS = -march=rv32if -mabi=ilp32f  -T linker_script -DRISCV -specs=nosys.specs -lm

all: main 

main: main.cpp main.h types.h utils.h
	$(CC) $(CFLAGS) -O3 -o main.o main.cpp
	riscv64-unknown-elf-objdump -D main.o > main.dump
	riscv64-unknown-elf-objcopy --output-target=ihex main.o main.hex

clean:
	rm -f *.o *.hex *.dump $(BIN)

