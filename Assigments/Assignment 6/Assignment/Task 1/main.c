#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct canvas {
  unsigned *data;
  int width, height;
} canvas;

struct shape;
typedef struct shape_vtable {
  void(*draw)(struct shape *, struct canvas *);
  void(*add)(struct shape *, struct shape *);
} shape_vtable;

typedef struct shape {
  shape_vtable *vtable;
  struct shape **children;
  unsigned num_children;
  unsigned color;
} shape;

typedef struct square {
  shape base;
  int x, y, w;
} square;

typedef struct rectangle {
  square super;
  int h;
} rectangle;

typedef struct ellipse {
  shape base;
  int x, y, w, h;
} ellipse;

typedef struct circle {
  ellipse super;
} circle;

extern square *square_init(unsigned color, int x, int y, int w);
extern ellipse *ellipse_init(unsigned color, int x, int y, int w, int h);
extern circle *circle_init(unsigned color, int x, int y, int r);
extern rectangle *rectangle_init(unsigned color, int x, int y, int w, int h);

int main(int argc, char *argv[]) {
  
  square *sq = square_init(1, 2, 3, 4);

  rectangle *rec = rectangle_init(1,2,3,4,5);

  ellipse *ell = ellipse_init(1, 2, 3, 4, 5);

  circle *cir = circle_init(1, 2, 3, 4);

  free(sq);
  free(rec);
  free(ell);
  free(cir);

  return 0;
}
