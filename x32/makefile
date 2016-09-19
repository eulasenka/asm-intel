CC=gcc
CFLAGS=-m32 -g

ASM=nasm
AFLAGS=-f elf32

all:result

hex_decoder.o: hex_decoder.c
	$(CC) $(CFLAGS) -c hex_decoder.c -o hex_decoder.o
func.o: func.asm
	$(ASM) $(AFLAGS) func.asm
result: hex_decoder.o func.o
	$(CC) $(CFLAGS) hex_decoder.o func.o -o result

debug: result
	gdb ./result
clean: 
	rm *.o
	rm result
