void setup(){
  size(500, 500);
}

float posX = 200;
float posY = 200;
int r = 100;
int p = 200+(int)(100/1.41);
float rad = atan( posY / posX );

void draw(){
  ellipse((int)posX, (int)posY, 100, 100); // 上の円
  ellipse(p, p, 100, 100); // 下の円
  line(0, p+50, width, p+50); // ライン
  
  rad = atan( (p-posY) / (p-posX) );
  println("rad: " + rad);
  
  // posX = (int)(p - r * sin(rad));
  // posY = (int)(p + r * cos(rad));
  posX = p - r * sin(rad);
  posY = p - r * cos(rad);
  
  println("(posX, posY)=" + posX + ", " + posY );
  
  delay(1000);
}

int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}
