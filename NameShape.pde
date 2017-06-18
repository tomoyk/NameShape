
int[] bollX = new int[1000]; // ボールの静止位置(x座標)を保存する配列
int[] bollY = new int[1000]; // ボールの静止位置(y座標)を保存する配列
int bollSize = 50; // ボールの直径

void setup(){
  size(1000, 310); // ウィンドウサイズ設定
  setBack(); // 背景を設定
  frameRate(120);
}

int wid=1000, hei=310;

int count = 0;
int bollNowX = bollSize/2; // 移動中ボールのx座標
int bollNowY = 0; // 移動中ボールのy座標

void draw(){
  
  setBack(); // 背景を設定
  
  // 静止ボールの描画
  for(int i=0;i<count;i++){
    ellipse(bollX[i], bollY[i], bollSize, bollSize);
  }
  
  // ボールの位置を変化させて描画
  // bollNowX += (int)random(-10, 10);
  bollNowX += 0;
  bollNowY += 5;
  ellipse(bollNowX, bollNowY, bollSize, bollSize);
  
  // ボールと壁の当たり判定
  if( bollNowY >= height-bollSize/2 ){ // 底面の当たり判定
    println("Bottom Hit");
    bollHit();
  }else if( width-bollSize/2 < bollNowX ){ // 右壁の当たり判定
    println("Right Hit");
    bollHit();
  }else if( bollNowX < 0+bollSize/2 ){ // 左壁の当たり判定
    println("Left Hit");
    bollHit();
  }

  // 当たった回数をカウント
  int hitCounter = 0;

  // 他のボールとの当たり判定
  for(int i=0;i<count;i++){
    if( distance(bollNowX, bollNowY, bollX[i], bollY[i]) < bollSize  ){ // ボールがi番目のボールと触れた時
      
      if(bollNowY < bollSize/2){ // ボールが積み上がってウィンドウはみ出たら
        noLoop();
      }
      
      hitCounter++;
      
      if(hitCounter == 1){
        
        // 上の円の中心を計算
        float posX = bollNowX;
        float posY = bollNowY;

        // 下の円の中心を計算
        int pX = bollX[i];
        int pY = bollY[i];

        // 右回転を左回転を判定(右回り : 左回り)
        int mode = ((int)posX >= pX ? -1 : 1);
        float rad;

        while(true){
          
          // println("(pX, pY)=" + pX + ", " + pY );
          // delay(1000);

          // 二つの円の距離
          float xDiff = pX>posX ? pX-posX : posX-pX;
          float yDiff = pY>posY ? pY-posY : posY-pY;
          // println("(xDiff, yDiff)=" + xDiff + ", " + yDiff );
          
          // 動く玉と中心になる玉との角度とって radian を -0.05 する
          rad = atan( yDiff / xDiff ) - 0.05; // ここ向き:
          // println("rad: " + rad);

          // 動く玉の位置を再定義(**)
          posX = (int)( pX - mode * bollSize * cos(rad) ); // ***
          posY = (int)( pY - bollSize * sin(rad) );
          // println("(posX, posY)=" + posX + ", " + posY );
          
          // 玉が地面に達したら終了(**上に入れるかタイミングは要調整)
          if(posY >= pY){
            // noLoop();
            break;
            // println("Over line");
          }

          // オブジェクトを描画
          //ellipse((int)posX, (int)posY, bollSize, bollSize); // 上の円
          // ellipse(pX, pY, bollSize, bollSize); // 下の円
          bollNowX = (int)posX;
          bollNowY = (int)posY;
          
          // delay(500);
        }
        
        println("Hit");
        bollHit();
        break;
      }
      
    }
  }
  
  // ボールをi番目ボール中心に回転させてぶつかったら終了ってループ

  delay(10);
}

// 背景
void setBack(){
  color c = #e6e6fa;
  background(red(c), green(c), blue(c));
}

// 2点の距離を求める
int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}

int center=0;

// ボールが他の物体に衝突
void bollHit(){
  center++;
  
  bollX[count] = bollNowX;
  bollY[count] = bollNowY;
  count++;
  // bollNowX = 800/2 + (int)random(-300, 300);
  int widBollMax = wid/bollSize; // 一行に配置できるボールの数
  if( (center/widBollMax)%2==1 && center%widBollMax == widBollMax-1){
    print("debug:: ");
    center++;
  }
  
  // bollNowX = ((center/widBollMax)%2==0 ? bollSize/2 : bollSize) + (center%widBollMax) * bollSize;
  bollNowX = bollSize/2 + (center%widBollMax) * bollSize;
  bollNowY = 0;
}
