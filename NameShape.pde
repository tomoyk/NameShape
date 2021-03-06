boolean debug = false; // デバッグモードの設定

int[] bollX = new int[200]; // ボールの静止位置(x座標)を保存する配列
int[] bollY = new int[200]; // ボールの静止位置(y座標)を保存する配列
int bollSize = 50; // ボールの直径
color[] bollColor = new color[200]; // ボールのカラー

int bollCount = 0; // 描画した静止しているボール数
int bollNowX = bollSize/2; // 移動中ボールのx座標
int bollNowY = 0; // 移動中ボールのy座標
int startPoint = 0; // ボールが他の物体に衝突

void setup(){
  size(1000, 380); // ウィンドウサイズ設定
  frameRate(1200); // 1秒間の描画数
  bollColor[0] = color(111+(int)(random(0, 7)*10), 81+(int)(random(3, 10)*10), 150+(int)(random(2, 8)*10)); // 1つ目のぼーるの色を初期化
}

void draw(){
  background(230,230,255); // 背景の設定
  
  // 静止ボールの描画
  for(int i=0;i<bollCount;i++){
    // ボールの枠線と太さを設定
    stroke(255);
    strokeWeight(3);
    
    // 個別のボールへの設定
    switch(i){
      // コの文字
      case 118: case 99: case 100: case 101: case 102: case 82: case 62:  case 42: case 41:  case 40: case 59:
        fill(120,120,0);
        break;
      // ヤの文字
      case 124: case 104: case 105: case 106: case 107: case 108: case 109: case 86: case 89: case 67: case 48:
        fill(120,0,0);
        break;
      // マの文字
      case 111: case 112: case 113: case 114: case 115: case 116: case 95: case 75: case 74: case 55:
        fill(0,120,120);
        break;
      // それ以外の文字
      default:
        noStroke();
        fill(bollColor[i]);
        break;
    }
    
    // 描画するオブジェクトをモードで切り替え
    if(!debug) {
      ellipse(bollX[i], bollY[i], bollSize, bollSize);
    }else{
      drawBoll(bollX[i], bollY[i], bollSize, i);
    }
      
  }
  
  // 落下するボールの色
  fill(40,0,76);
  
  // ボールの位置を変化
  bollNowY += 5;
  
  // 落下するボールを描画
  ellipse(bollNowX, bollNowY, bollSize, bollSize);
  
  // ボールと壁の当たり判定
  if( bollNowY >= height-bollSize/2 ){ // 底面の当たり判定
    if(debug) println("Bottom Hit");
    bollHit();
  }else if( width-bollSize/2 < bollNowX ){ // 右壁の当たり判定
    if(debug) println("Right Hit");
    bollHit();
  }else if( bollNowX < 0+bollSize/2 ){ // 左壁の当たり判定
    if(debug) println("Left Hit");
    bollHit();
  }

  // 他のボールとの当たり判定
  for(int i=0;i<bollCount;i++){
    
    if( distance(bollNowX, bollNowY, bollX[i], bollY[i]) < bollSize ){ // ボールがi番目のボールと触れた時
        
      // 上の円の中心を計算
      float posX = bollNowX;
      float posY = bollNowY;

      // 下の円の中心を計算
      int pX = bollX[i];
      int pY = bollY[i];

      // 右回転を左回転を判定(右回り : 左回り)
      int mode = ((int)posX >= pX ? -1 : 1);
      float rad;

      // ボール回転のループ
      while(true){
        
        if(debug) println("(pX, pY)=" + pX + ", " + pY );
        
        // 二つの円の距離
        float xDiff = pX>posX ? pX-posX : posX-pX;
        float yDiff = pY-posY;
        if(debug) println("(xDiff, yDiff)=" + xDiff + ", " + yDiff );
        
        // 動く玉と中心になる玉との角度とって radian を -0.03 する
        rad = atan( yDiff / xDiff ) - 0.03;
        if(debug) println("rad: " + rad);
        
        // 動く玉の位置を再定義
        posX = pX - mode * bollSize * cos(rad);
        posY = pY - bollSize * sin(rad);
        if(debug) println("(posX, posY)=" + posX + ", " + posY );
        
        //
        boolean state = false;
        
        // ボールと触れているか判定
        for(int j=0;j<bollCount;j++){
          if(i==j) continue; // 接触している1つ目のボールを除く
          if( distance((int)posX, (int)posY, bollX[j], bollY[j]) < bollSize ){ // ボールがi番目のボールと触れた時
            state = true;
            break;
          }
        }
        
        // ボールが地面に達したら終了
        if(state){
          if(debug) println("Over line");
          break;
        }
        
        // オブジェクトを描画
        bollNowX = (int)posX;
        bollNowY = (int)posY;
        ellipse(bollNowX, bollNowY, bollSize, bollSize);
      }
      
      // ボールが静止
      if(debug) println("Hit");
      bollHit();
      break;
    }
    
    // ボールが積み上がってウィンドウはみ出たら
    if(bollY[i] < bollSize/2){
      noLoop();
      if(debug) println("End");
      break;
    }
  }
}

// 2点の距離を求める
int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}

// ボールが他の物体に衝突
void bollHit(){ // bollNum番目のボールの横の位置
  startPoint++;
  
  // 静止ボールを配列に追加
  bollX[bollCount] = bollNowX;
  bollY[bollCount] = bollNowY;
  bollCount++;

  int widBollMax = width/bollSize; // 一行に配置できるボールの数
  if( (startPoint/widBollMax)%2==1 && startPoint%widBollMax == widBollMax-1){
    startPoint++;
  }
  
  // ボールの位置を再設定
  bollNowX = bollSize/2 + (startPoint%widBollMax) * bollSize;
  bollNowY = 0;
  
  // ボールの色を再設定
  bollColor[bollCount] = color(111+(int)(random(0, 7)*10), 81+(int)(random(3, 10)*10), 150+(int)(random(2, 8)*10));
}

// 番号付きの数字を描画する関数
void drawBoll(int x, int y, int r, int num){
  ellipse(x, y, r, r);
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text(num, x, y);
  fill(255);
}
