foxc: foxc.o
	g++ -o foxc foxc.o

foxc.o: foxc.cpp
	g++ -c foxc.cpp

run:
	make clean
	make
	./foxc

clean:
	rm *.o foxc
