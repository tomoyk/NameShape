void setup(){
  size(500, 500);
}

// 上の円の中心を計算
float posX = 200;
float posY = 200;

// 下の円の中心を計算
int pX = 200+(int)(100/2);
int pY = 200+(int)(100*(1.73/2));

// arcTanを計算
float rad = atan( posY / posX );

int r = 100;

void draw(){
  ellipse((int)posX, (int)posY, 100, 100); // 上の円
  ellipse(pX, pY, 100, 100); // 下の円
  line(0, pY+50, width, pY+50); // ライン
  
  rad = atan( (pY-posY) / (pX-posX) ) - 0.1;
  println("rad: " + rad);
    
  posX = pX - r * cos(rad);
  posY = pY - r * sin(rad);

  //posX = pX - r * sin(rad);
  //posY = pY - r * cos(rad);
  
  println("(posX, posY)=" + posX + ", " + posY );
  
  delay(500);
}

int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}
