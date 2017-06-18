// ボールの直径を定義
int bollSize = 100;

// 上の円の中心を計算
float posX = 200;
float posY = 200;

// 下の円の中心を計算
int pX = (int)posX - bollSize/2;
int pY = (int)(posY + bollSize*(1.73/2));

// 右回転を左回転を判定(右回り : 左回り)
int mode = ((int)posX >= pX ? -1 : 1);
float rad;

void setup(){
  size(500, 500);
}

void draw(){
  
  println("(pX, pY)=" + pX + ", " + pY );
  delay(1000);

  // 二つの円の距離
  float xDiff = pX>posX ? pX-posX : posX-pX;
  float yDiff = pY>posY ? pY-posY : posY-pY;
  println("(xDiff, yDiff)=" + xDiff + ", " + yDiff );
  
  // 動く玉と中心になる玉との角度とって radian を -0.05 する
  rad = atan( yDiff / xDiff ) + mode * 0.05; // ここ向き:
  println("rad: " + rad);

  // 動く玉の位置を再定義(**)
  posX = (int)( pX - mode * bollSize * cos(rad) ); // ***
  posY = (int)( pY - bollSize * sin(rad) );
  println("(posX, posY)=" + posX + ", " + posY );
  
  // 玉が地面に達したら終了(**上に入れるかタイミングは要調整)
  if(posY >= pY){
    //noLoop();
    println("Over line");
  }

  // オブジェクトを描画
  ellipse((int)posX, (int)posY, bollSize, bollSize); // 上の円
  ellipse(pX, pY, bollSize, bollSize); // 下の円
  line(0, pY+50, width, pY+50); // ライン

  //delay(500);
}
