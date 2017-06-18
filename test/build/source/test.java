import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class test extends PApplet {

public void setup(){
  
}

int posX = 200;
int posY = 200;
int r = 100;
int p = 200+(int)(100/1.41f);
float rad = atan( posY / posX );

public void draw(){
  ellipse(posX, posY, 100, 100); // \u4e0a\u306e\u5186
  ellipse(p, p, 100, 100); // \u4e0b\u306e\u5186
  line(0, p+50, width, p+50); // \u30e9\u30a4\u30f3
  
  // int r = distance(p, p, posX, posY);
  // println(rad);
  
  rad += 0.1f;
  
  posX = (int)(p - r * sin(rad));
  posY = (int)(p + r * cos(rad));
  
  println("(posX, posY)=" + posX + "," + posY );
  
  delay(300);
}

public int distance(int x1, int y1, int x2, int y2){
  int xDiff = x1>x2 ? x1-x2 : x2-x1;
  int yDiff = y1>y2 ? y1-y2 : y2-y1;
  return (int)sqrt( sq(xDiff) + sq(yDiff) );
}
  public void settings() {  size(500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "test" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
