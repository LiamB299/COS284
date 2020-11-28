#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

int apply(int(*f)(int), int x);

int twice(int x) {
  return x + x;
}

int main(int argc, char *argv[]) {
  
  printf("%d\n", apply(twice, 10)); // 20
  
  return 0;
}
