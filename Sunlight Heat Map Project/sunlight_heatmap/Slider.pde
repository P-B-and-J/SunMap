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
  PGraphics drawTo;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false;
  Slider(float _X, float _Y, float _sliderLength){
    X = _X;
    Y = _Y;
    sliderLength = _sliderLength;
    value = (max - min) / 2;
    position = map(value, min, max, radius, sliderLength - radius);
    drawTo=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
  }

  Slider(float _X, float _Y, float _sliderLength, PGraphics _drawTo,editInt _offsetX, editInt _offsetY){
    this(_X,_Y,_sliderLength);
    drawTo=_drawTo;
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
  }
  
  void showValue(){
    drawTo.pushStyle();
    drawTo.textAlign(CENTER);
    drawTo.textSize(textSize);
    drawTo.fill(textColor);
    if (pressed){
      drawTo.text(int(value), X + position, Y - radius - textHeight);
    }
    drawTo.popStyle();
  }
  
  void display(String label){
    detectDrag();
    if(!useG){
      drawTo.beginDraw();
    }
    drawTo.pushStyle();
    drawTo.colorMode(HSB);
    drawTo.strokeCap(ROUND);
    drawTo.stroke(primaryColor);
    drawTo.strokeWeight(weight);
    drawTo.line(X, Y, X + position, Y);
    drawTo.stroke(secondaryColor);
    drawTo.line(X + position, Y, X + sliderLength, Y);
    if(pressed){
      drawTo.fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25);
      drawTo.stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25); 
    }
    else if((mouseX-offsetX.val) > X - radius && (mouseX-offsetX.val) < X + sliderLength + radius && (mouseY-offsetY.val) > Y - radius && (mouseY-offsetY.val) < Y + radius){
      drawTo.fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30);
      drawTo.stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30);
    }
    else{
      drawTo.fill(primaryColor);
      drawTo.stroke(primaryColor);
    }
    if(style == 1){
      drawTo.ellipse(X + position, Y, radius * 2, radius * 2);
    }
    else if(style == 2){
      drawTo.strokeWeight(radius / 2);
      drawTo.strokeCap(ROUND);
      drawTo.line(X + position, Y - radius, X + position, Y + radius);
    }
    drawTo.popStyle();
    if(floatingVal){
      showValue();
    }
    if(label != null){
      drawTo.pushStyle();
      drawTo.textSize(textSize);
      drawTo.fill(textColor);
      drawTo.text(label, X, Y - labelBuffer);
      drawTo.popStyle();
    }
    if(!useG){
      drawTo.endDraw();
    }
  }
}
