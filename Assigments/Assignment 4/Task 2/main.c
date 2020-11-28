#include <stdio.h>
#include <stdlib.h>

extern char* rotateString(char* word, int length, int deg);

int main()
{    
	char c[44] = "the quick brown fox jumped over the lazy dog";
	char* num = rotateString(c,44,0);
	
	printf("%s", num);
	
    return 0;
}

