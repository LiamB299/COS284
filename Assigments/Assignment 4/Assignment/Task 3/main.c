#include <stdio.h>
#include <stdlib.h>

extern char* sort(char* string, int numberOfWords, int lengthOfWords);

int main()
{   
	char c[] = "OOP EEP RUN YUM MAP APP";
	//char c[] = "oop eep run yum map app";
	//char c[] = "q w e r t y u i o p l k j h g f d s a z x c v b n m";
	//char c[] = "qq ww ee rr tt yy uu ii oo pp aa ss dd ff gg hh jj kk ll zz xx cc vv bb nn mm pl ok";
	//char c[] = "hh pp cc hh ee ff gg aa ii jj kk ll mm nn bb oo dd rr ss";
	
	//char c[] = "CADDY HEFFT WOWWW PLOUG CATCH";
	char* res = sort(c, 6, 3);
	
	printf("%s", res);
	
    return 0;
}

