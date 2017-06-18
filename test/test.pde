// ボールの直径を定義
int bollSize = 100;

// 上の円の中心を計算
int posX = 200;
int posY = 200;

// 下の円の中心を計算
//float pX = posX + bollSize/2;
float pX = posX - bollSize/2;
float pY = posY + bollSize*(1.73/2);

// 右回転を左回転を判定(右回り : 左回り)
int mode = posX >= (int)pX ? 1 : -1;

// arcTanを計算
float rad;

void setup(){
  size(500, 500);
}

void draw(){
  // オブジェクトを描画
  ellipse((int)posX, (int)posY, bollSize, bollSize); // 上の円
  ellipse(pX, pY, bollSize, bollSize); // 下の円
  line(0, pY+50, width, pY+50); // ライン
  
  // 動く玉と中心になる玉との角度とって radian を -0.05 する
  float xDiff = pX>posX ? pX-posX : posX-pX;
  float yDiff = pY>posY ? pY-posY : posY-pY;
  
  // 回転方向の増減
  rad = atan( yDiff / xDiff ) +/* ここ */ mode * 0.05;
  println("rad: " + rad);

  // 動く玉の位置を再定義(**)
  posX = (int)( pX +/* ここ　*/ mode * bollSize * cos(rad) );
  posY = (int)( pY - bollSize * sin(rad) );
  println("(posX, posY)=" + posX + ", " + posY );
  
  // 玉が地面に達したら終了(**上に入れるかタイミングは要調整)
  if(posY >= pY){
    noLoop();
  }

  // delay(500);
}
