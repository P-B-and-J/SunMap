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
  
  Slider(float _X, float _Y, float _sliderLength){
    X = _X;
    Y = _Y;
    sliderLength = _sliderLength;
    position = map(value, min, max, radius, sliderLength - radius);
  }
  
  void detectDrag(){                     //< if mouse is within knob in X dimension ->   < if mouse is within knob in Y direction-->
    if(mousePressed && !lastMousePressed && mouseX > X - 25 && mouseX < X + sliderLength + 25 && mouseY > Y - 25 && mouseY < Y + 25){
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
    
    if(pressed && mouseX - X >= knobWidth && mouseX - X <= sliderLength - knobWidth){
      position = mouseX - X;
    }
    else if(pressed && mouseX < X + knobWidth){
      position = knobWidth;
    }
    else if(pressed && mouseX > sliderLength - knobWidth){
      position = sliderLength - knobWidth;
    }
    
    
    value = map(position, radius, sliderLength - radius, min, max);
  }
  
  void showValue(){
    pushStyle();
    textAlign(CENTER);
    textSize(textSize);
    fill(textColor);
    if (pressed){
      text(int(value), X + position, Y - radius - textHeight);
    }
    popStyle();
  }
  
  void display(String label){
    detectDrag();
    pushStyle();
    colorMode(HSB);
    strokeCap(ROUND);
    stroke(primaryColor);
    strokeWeight(weight);
    line(X, Y, X + position, Y);
    stroke(secondaryColor);
    line(X + position, Y, X + sliderLength, Y);
    if(pressed){
      fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25);
      stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25); 
    }
    else if(mouseX > X - radius && mouseX < X + sliderLength + radius && mouseY > Y - radius && mouseY < Y + radius){
      fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30);
      stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30);
    }
    else{
      fill(primaryColor);
      stroke(primaryColor);
    }
    if(style == 1){
      ellipse(X + position, Y, radius * 2, radius * 2);
    }
    else if(style == 2){
      strokeWeight(radius / 2);
      strokeCap(ROUND);
      line(X + position, Y - radius, X + position, Y + radius);
    }
    popStyle();
    if(floatingVal){
      showValue();
    }
    if(label != null){
      pushStyle();
      textSize(textSize);
      fill(textColor);
      text(label, X, Y - labelBuffer);
      popStyle();
    }
  }
}
