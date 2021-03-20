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
  
  Slider(float _X, float _Y, float _sliderLength){
    X = _X;
    Y = _Y;
    sliderLength = _sliderLength;
    position = map(value, min, max, radius, sliderLength - radius);
  }
  
  void detectDrag(){                     //< if mouse is within knob in X dimension -------------------------->   < if mouse is within knob in Y direction ----->
    if(mousePressed && !lastMousePressed && mouseX > X /*- radius*/ - 25 && mouseX < X + sliderLength /*+ radius*/ + 25 && mouseY > Y /*- radius*/ - 25 && mouseY < Y /*+ radius*/ + 25){
      pressed = true;
    }
    lastMousePressed = mousePressed;
    
    if(!mousePressed){
      pressed = false;
    }
    
    
    if(pressed && mouseX - X >= radius && mouseX - X <= sliderLength - radius){
      position = mouseX - X;
    }
    else if(pressed && mouseX < X + radius){
      position = radius;
    }
    else if(pressed && mouseX > sliderLength - radius){
      position = sliderLength - radius;
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
    ellipse(X + position, Y, radius * 2, radius * 2);
    popStyle();
    if(floatingVal){
      showValue();
    }
    if(label != null){
      fill(textColor);
      text(label, X, Y - labelBuffer);
    }
  }
}
