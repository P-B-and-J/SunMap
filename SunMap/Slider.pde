class Slider {
  float X;
  float Y;
  float sliderLength;
  float radius = 15;
  float weight = 5;
  color primaryColor = #3A7793;
  float primaryHue;
  float primarySat;
  float primaryVal;
  color secondaryColor = color(#797979);
  color textColor = color(#FFFFFF);
  float textSize = 30;
  float textHeight = 20;
  float position;
  float value = 0;
  float min = 0;
  float max = 10;
  boolean pressed = false;
  boolean floatingVal = true;
  float clickX;
  float clickY;
  boolean lastMousePressed = false;
  boolean visible;
  float labelBuffer = 2 * radius;
  int style = 1;
  float knobWidth;
  PGraphics graphics;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false;
  float alpha = 255;
  boolean enabled = true;
  color backgroundColor;
  boolean backgroundOn = false;
  boolean sticky = false;
  boolean tickMarks = false;
  boolean endpoints = false;
  int clickDiff = 25;
  int hoverDiff = 30;
  
  Slider(float _sliderLength){
    sliderLength = _sliderLength;
    value = (max - min) / 2;
    position = map(value, min, max, radius, sliderLength - radius);
    graphics=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
  }
  
  void drawTo(PGraphics _graphics, editInt _offsetX, editInt _offsetY){
    graphics=_graphics;
    offsetX=_offsetX;
    offsetY=_offsetY;   
    useG=false;
  }

  void detectDrag(){                     //< if mouse is within knob in X dimension ->   < if mouse is within knob in Y direction-->
    if(mousePressed && !lastMousePressed && (mouseX-offsetX.val) > X - 25 && (mouseX-offsetX.val) < X + sliderLength + 25 && (mouseY-offsetY.val) > Y - 25 && (mouseY-offsetY.val) < Y + 25){
      pressed = true;
    }
    lastMousePressed = mousePressed;
    
    if(!mousePressed){
      pressed = false;
    }
    
    if(style == 1){
      knobWidth = radius;
    }
    else if(style == 2){
      knobWidth = radius / 4;
    }
    
    if(pressed && (mouseX-offsetX.val) - X >= knobWidth && (mouseX-offsetX.val) - X <= sliderLength - knobWidth){
      position = (mouseX-offsetX.val) - X;
    }
    else if(pressed && (mouseX-offsetX.val) < X + knobWidth){
      position = knobWidth;
    }
    else if(pressed && (mouseX-offsetX.val) > sliderLength - knobWidth){
      position = sliderLength - knobWidth;
    }
    
    
    value = map(position, radius, sliderLength - radius, min, max);
    if(sticky){
      value = round(value);
      position = map(value, min, max, radius, sliderLength - radius);
    }
  }
  
  void showValue(){
    graphics.pushStyle();
    graphics.textAlign(CENTER);
    graphics.textSize(textSize);
    graphics.fill(textColor);
    if (pressed){
      graphics.text(int(value), X + position, Y - radius - textHeight);
    }
    graphics.popStyle();
  }
  
  void drawBackground(){
    graphics.pushStyle();
    graphics.noStroke();
    graphics.fill(backgroundColor);
    graphics.rect(X - radius, Y - labelBuffer - textSize, sliderLength + 2 * radius, textSize + labelBuffer + 1.5 * radius);
    graphics.popStyle();
  }
  
  void drawTickMarks(){
    graphics.pushStyle();
    graphics.stroke(secondaryColor, alpha);
    graphics.strokeCap(ROUND);
    graphics.strokeWeight(weight / 2);
    for(int i = int(min); i <= max; i++){
      graphics.line(X + map(i, min, max, radius, sliderLength - radius), Y - 1.5 * radius, X + map(i, min, max, radius, sliderLength - radius), Y + 1.5 * radius);
    }
    graphics.pushStyle();
  }
  
  void display(float _X, float _Y, String label){
    X = _X;
    Y = _Y;
    if(enabled){
      detectDrag();
    }
    if(!useG){
      graphics.beginDraw();
    }
    if(backgroundOn){
      drawBackground();
    }
    if(tickMarks){
      drawTickMarks();
    }
    graphics.pushStyle();
    graphics.colorMode(HSB);
    graphics.strokeCap(ROUND);
    graphics.stroke(primaryColor, alpha);
    graphics.strokeWeight(weight);
    graphics.line(X, Y, X + position, Y);
    graphics.stroke(secondaryColor, alpha);
    graphics.line(X + position, Y, X + sliderLength, Y);
    if(pressed){
      graphics.fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - clickDiff, alpha);
      graphics.stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - clickDiff, alpha); 
    }
    else if((mouseX-offsetX.val) > X - radius && (mouseX-offsetX.val) < X + sliderLength + radius && (mouseY-offsetY.val) > Y - radius && (mouseY-offsetY.val) < Y + radius){
      graphics.fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + hoverDiff, alpha);
      graphics.stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + hoverDiff, alpha);
    }
    else{
      graphics.fill(primaryColor, alpha);
      graphics.stroke(primaryColor, alpha);
    }
    if(style == 1){
      graphics.ellipse(X + position, Y, radius * 2, radius * 2);
    }
    else if(style == 2){
      graphics.strokeWeight(radius / 2);
      graphics.strokeCap(ROUND);
      graphics.line(X + position, Y - radius, X + position, Y + radius);
    }
    graphics.popStyle();
    if(floatingVal){
      showValue();
    }
    if(label != null){
      graphics.pushStyle();
      graphics.textSize(textSize);
      graphics.fill(textColor, alpha);
      graphics.text(label, X, Y - labelBuffer);
      graphics.popStyle();
    }
    if(!useG){
      graphics.endDraw();
    }
  }
}
