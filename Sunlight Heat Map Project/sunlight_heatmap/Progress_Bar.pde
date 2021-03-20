class Progress_Bar{
  float X, Y;
  int barHeight, barWidth;
  color primaryColor = #FFFFFF;
  color backgroundColor;
  color textColor1 = primaryColor;
  color textColor2 = backgroundColor;
  float textSize = 25;
  PFont textFont;
  String text = "";
  PImage progressBar;
  PImage background;
  boolean visible = false;
  float textX = 0; 
  float textY = 0;
  float borderWidth = 3;
  boolean rectOn = true;
  int textAlignV = CENTER;
  int textAlignH = LEFT;
  
  Progress_Bar(float _X, float _Y, int _barWidth, int _barHeight){
    X = _X;
    Y = _Y;
    barHeight = _barHeight;
    barWidth = _barWidth;
    textFont = createFont("Lucida Sans Regular", textSize);
    textY = barHeight / 2;
  }
  
  void begin(){
    PGraphics canvas;
    canvas = createGraphics(barWidth, barHeight);
    canvas.beginDraw();
    canvas.noStroke();
    canvas.background(primaryColor);
    canvas.fill(textColor2);
    canvas.textAlign(textAlignH, textAlignV);
    canvas.textSize(textSize);
    canvas.textFont(textFont);
    canvas.text(text, textX, textY);
    canvas.endDraw();
    progressBar = canvas.get();
    
    canvas.beginDraw();
    canvas.noStroke();
    canvas.background(backgroundColor);
    canvas.fill(textColor1);
    canvas.textAlign(textAlignH, textAlignV);
    canvas.textSize(textSize);
    canvas.textFont(textFont);
    canvas.text(text, textX, textY);
    canvas.endDraw();
    background = canvas.get();
  }
  
  void display(float progress){
    image(background, X, Y);
    PGraphics mask;
    mask = createGraphics(barWidth, barHeight);
    mask.beginDraw();
    mask.noStroke();
    mask.background(0);
    mask.fill(255);
    mask.rect(0, 0, progress * barWidth, barHeight);
    mask.endDraw();
    PImage tempImage = progressBar;
    tempImage.mask(mask.get());
    image(tempImage, X, Y);
    if(rectOn){
      pushStyle();
      stroke(primaryColor);
      strokeWeight(borderWidth);
      noFill();
      rect(X - 2 * borderWidth, Y - 2 * borderWidth, barWidth + 4 * borderWidth, barHeight + 4 * borderWidth);
      popStyle();
    }
  }
}
