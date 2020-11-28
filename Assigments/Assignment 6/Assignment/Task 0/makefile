all: main.o func.o
	gcc -g -m64 -static -no-pie main.o func.o -o main

main.o: main.c
	gcc -g -m64 -c main.c

func.o: func.asm
	yasm -f elf64 -g dwarf2 func.asm -o func.o

run: all
	./main

clean:
	rm *.o main
