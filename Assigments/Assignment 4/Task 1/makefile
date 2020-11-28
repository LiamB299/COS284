a.out: main.o task1.o
	gcc main.o task1.o -o a.out -g -m64 -static

main.o: main.c
	gcc -c main.c -g -m64

task1.o: task1.asm
	yasm -f elf64 -g dwarf2 task1.asm -o task1.o
	
run: a.out
	./a.out
	
clean: 
	rm -rf *.o a.out