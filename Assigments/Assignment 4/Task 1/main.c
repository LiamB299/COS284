#include <stdio.h>
#include <stdlib.h>

extern int64_t countWords(char* word, int length);

int main()
{    
	char c[44] = "I am Liam";
	int64_t num = countWords(c,44);
	printf("%ld", num);

	char c1[0] = "";
	num = countWords(c1,0);
	printf("%ld", num);

	char c2[46] = "the quick brown fox jumped over the lazy dog";
	num = countWords(c2,46);
	printf("%ld", num);

	char c3[0] = "";
	num = countWords(c3,0);
	printf("%ld", num);

	char c4[5] = "ttttt";
	num = countWords(c4,5);
	printf("%ld", num);
	
    return 0;
}



