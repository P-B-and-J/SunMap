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
  PGraphics drawTo;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false;
  boolean smooth = true;
  float targetPos;
  int speed = 1;
  
  Progress_Bar(float _X, float _Y, int _barWidth, int _barHeight){
    X = _X;
    Y = _Y;
    barHeight = _barHeight;
    barWidth = _barWidth;
    textY = barHeight / 2;
    drawTo=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
  }
  Progress_Bar(float _X, float _Y, int _barWidth, int _barHeight, PGraphics _drawTo,editInt _offsetX, editInt _offsetY){
    this(_X,_Y,_barWidth,_barHeight);
    drawTo=_drawTo;
    offsetX=_offsetX;
    offsetY=_offsetY;   
    useG=false;
  }
  void begin(){
    PGraphics canvas;
    textFont = createFont("Lucida Sans Regular", textSize);
    canvas = createGraphics(barWidth, barHeight);
    canvas.smooth();
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
    if(!useG){
      drawTo.beginDraw();
    }
    drawTo.image(background, X, Y);
    PGraphics mask;
    mask = createGraphics(barWidth, barHeight);
    mask.smooth();
    mask.beginDraw();
    mask.noStroke();
    mask.background(0);
    mask.fill(255);
    if(smooth){
      if(targetPos > progress * barWidth){
        targetPos = 0;
      }
      targetPos = easeValue(targetPos, progress * barWidth, speed / fps);
      mask.rect(0, 0, targetPos, barHeight);
    }
    else{
      mask.rect(0, 0, progress * barWidth, barHeight);
    }
    mask.endDraw();
    PImage tempImage = progressBar;
    tempImage.mask(mask.get());
    drawTo.image(tempImage, X, Y);
    if(rectOn){
      drawTo.pushStyle();
      drawTo.stroke(primaryColor);
      drawTo.strokeWeight(borderWidth);
      drawTo.noFill();
      drawTo.rect(X - 2 * borderWidth, Y - 2 * borderWidth, barWidth + 4 * borderWidth, barHeight + 4 * borderWidth);
      drawTo.popStyle();
    }
    if(!useG){
      drawTo.endDraw();
    }
  }
}
