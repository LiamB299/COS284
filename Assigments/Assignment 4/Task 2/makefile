a.out: main.o task2.o
	gcc main.o task2.o -o a.out -g -m64 -static

main.o: main.c
	gcc -c main.c -g -m64

task2.o: task2.asm
	yasm -f elf64 -g dwarf2 task2.asm -o task2.o

run: a.out
	./a.out
	
clean: 
	rm -rf *.o a.out
