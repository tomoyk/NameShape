
int[] bollX = new int[100]; // ボールの静止位置(x座標)を保存する配列
int[] bollY = new int[100]; // ボールの静止位置(y座標)を保存する配列
int bollSize = 50; // ボールの直径

void setup(){
  size(800, 600); // ウィンドウサイズ設定
  back(); // 背景を設定
}

int count = 0;
int bollNowX = 800/2; // 移動中ボールのx座標
int bollNowY = 0; // 移動中ボールのy座標

void draw(){
  
  back();
  
  // 静止ボールの描画
  for(int i=0;i<count;i++){
    ellipse(bollX[i], bollY[i], bollSize, bollSize);
  }
  
  // ボールの位置を変化させて描画
  bollNowX += (int)random(-10, 10);
  bollNowY += 10;
  ellipse(bollNowX, bollNowY, bollSize, bollSize);
  
  // ボールの当たり判定
  if( bollNowY >= height-bollSize/2 ){ // 底面の当たり判定
    bollHit();
  }else if( width-bollSize/2 <= bollNowX ){ // 右壁の当たり判定
    bollHit();
  }else if( bollNowX <= 0+bollSize/2 ){ // 左壁の当たり判定
    bollHit();
  }

  // 他のボールと触れたかチェック
  for(int i=0;i<count;i++){
    if( distance(bollNowX, bollNowY, bollX[i], bollY[i]) <= bollSize  ){
      if(bollNowY < bollSize/2){
        noLoop();
      }

      println("Hit");
      bollHit();
      break;
      
    }
  }

  // delay(10);
}

// 背景
void back(){
  color c = #e6e6fa;
  background(red(c), green(c), blue(c));
}

// 2点の距離を求める
int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}

// ボールが他の物体に衝突
void bollHit(){
  bollX[count] = bollNowX;
  bollY[count] = bollNowY;
  count++;
  bollNowX = 800/2 + (int)random(-300, 300);
  bollNowY = 0;
}
