all: main.o shape.o square.o rectangle.o ellipse.o circle.o
	gcc -g -m64 -static -no-pie main.o shape.o square.o rectangle.o ellipse.o circle.o -o main

main.o: main.c
	gcc -g -m64 -c main.c

shape.o: shape.asm
	yasm -f elf64 -g dwarf2 shape.asm -o shape.o
	
square.o: square.asm
	yasm -f elf64 -g dwarf2 square.asm -o square.o

rectangle.o: rectangle.asm
	yasm -f elf64 -g dwarf2 rectangle.asm -o rectangle.o

ellipse.o: ellipse.asm
	yasm -f elf64 -g dwarf2 ellipse.asm -o ellipse.o

circle.o: circle.asm
	yasm -f elf64 -g dwarf2 circle.asm -o circle.o

run: all
	./main

clean:
	rm *.o main
