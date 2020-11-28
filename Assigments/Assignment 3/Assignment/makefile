make:
	yasm -f elf64 -g dwarf2 -l exit.lst *.asm
	ld -o main main.o
	./main
