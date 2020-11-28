a.out: main.o swapLetters.o
	gcc main.o swapLetters.o -o a.out -g -m64 -static

main.o: main.c
	gcc -c main.c -g -m64

swapLetters.o: swapLetters.asm
	yasm -f elf64 -g dwarf2 swapLetters.asm -o swapLetters.o

run: a.out
	./a.out
	
clean: 
	rm -rf *.o a.out
