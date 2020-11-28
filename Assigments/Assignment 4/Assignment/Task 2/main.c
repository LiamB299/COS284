#include <stdio.h>
#include <stdlib.h>

extern char* swapWords(char string[], int element1, int element2, int wordSize);

int calculateIndexOfWord(int elementNumber, int lengthOfWord)
{
	return elementNumber*(lengthOfWord+1);
}

int main(int argc, char** argv)
{
	char biggerWords[] = "HAT CAT BAT SAT MAP LAP APP";//"ELEPHANT ABSOLUTE SUPPOSED WITHDRAW";
    
	printf("Before swapWords:\t%s\n", biggerWords);
	char * result = swapWords(biggerWords, 4, 6, 3); //Should give: "ABSOLUTE ELEPHANT SUPPOSED WITHDRAW"
	printf("After swapWords:\t%s\n", result);
    
    return 0;
}
