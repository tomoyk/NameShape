void setup(){
  size(500, 500);
}

int posX = 200;
int posY = 200;
int r = 100;
int p = 200+(int)(100/1.41);
float rad = atan( posY / posX );

void draw(){
  ellipse(posX, posY, 100, 100); // 上の円
  ellipse(p, p, 100, 100); // 下の円
  line(0, p+50, width, p+50); // ライン
  
  // int r = distance(p, p, posX, posY);
  // println(rad);
  
  rad += 0.1;
  
  // posX = (int)(p - r * sin(rad));
  // posY = (int)(p + r * cos(rad));
  
  println("(posX, posY)=" + posX + ", " + posY );
  
  delay(300);
}

int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}
