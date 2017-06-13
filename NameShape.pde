// ボールの最終位置を定義する配列
int[] bollX = new int[100];
int[] bollY = new int[100];
int bollSize = 80; // ボールの直径

void setup(){
  size(800, 600);
  back();
}

int count = 0;
int bollNowX = 0;
int bollNowY = 0;

void draw(){
  loop();
  back();
  for(int i=0;i<count;i++){
    ellipse(bollX[i], bollY[i], bollSize, bollSize);
  }
  
  bollNowX += (int)random(0, 5);
  bollNowY += 5;
  ellipse(bollNowX, bollNowY, bollSize, bollSize);
  
  boolean flag = true;

  for(int i=0;i<count && count!=0;i++){
    if( distance(bollNowX, bollNowY, bollX[i], bollY[i]) <= bollSize  ){
      println("true");
      flag = false;
      noLoop();
      break;
    }
  }

  print("\n");
  
  if( bollNowY >= height-bollSize/2 && flag ){
    bollX[count] = bollNowX;
    bollY[count] = bollNowY - bollSize/2;
    count++;
    
    bollNowX = (int)random(0, 5);;
    bollNowY = 0;
    
  }
  
  delay(10);
}

color c = #e6e6fa;

void back(){
  background(red(c), green(c), blue(c));
}

int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}
