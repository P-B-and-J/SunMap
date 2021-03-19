class Progress_Bar{
  float X, Y;
  int barHeight, barWidth;
  color primaryColor = #FFFFFF;
  color backgroundColor;
  color textColor1 = primaryColor;
  color textColor2 = backgroundColor;
  float textSize;
  PFont textFont;
  String text;
  PImage progressBar;
  boolean visible;
  float textX, textY;
  
  Progress_Bar(float _X, float _Y, int _barWidth, int _barHeight){
    X = _X;
    Y = _Y;
    barHeight = _barHeight;
    barWidth = _barWidth;
  }
  
  void begin(){
    PGraphics canvas;
    canvas = createGraphics(barWidth, barHeight);
    canvas.beginDraw();
    canvas.noStroke();
    canvas.background(primaryColor);
    canvas.fill(textColor2);
    canvas.textAlign(LEFT, CENTER);
    canvas.textSize(textSize);
    canvas.textFont(textFont);
    canvas.text(text, textX, textY);
    canvas.endDraw();
  }
  
  
}
