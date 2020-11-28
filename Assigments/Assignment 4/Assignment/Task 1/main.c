#include <stdio.h>
#include <stdlib.h>

extern char* swapLetters(char* string, int inA, int inB);

int main()
{    
	char c[] = "A B C D E F G";
	char* res = swapLetters(c,2,10);
	
	printf("Swap %s", res);
	
    return 0;
}

