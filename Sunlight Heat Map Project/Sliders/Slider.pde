class Slider {
  float X;
  float Y;
  float sliderLength;
  float radius = 15;
  float weight = 5;
  color primaryColor = color(#3A7793);
  float primaryHue;
  float primarySat;
  float primaryVal;
  color secondaryColor = color(#797979);
  //color knobColor1 = color(#5095B4);
  //color knobColor2 = color(#235267);
  color textColor = color(#FFFFFF);
  float position;
  float value = 0;
  float min = 0;
  float max = 10;
  boolean pressed = false;
  
  Slider(float _X, float _Y, float _sliderLength){
    X = _X;
    Y = _Y;
    sliderLength = _sliderLength;
    position = map(value, min, max, 0, sliderLength);
  }
  
  void detectDrag(){ //< if mouse is within knob in X dimension -------------------------->   < if mouse is within knob in Y direction ----->
    if(mousePressed && mouseX > X - radius - 25 && mouseX < X + sliderLength + radius + 25 && mouseY > Y - radius - 25 && mouseY < Y + radius + 25){
      pressed = true;
    }
    if(pressed && mouseX - X >= 0 && mouseX - X <= sliderLength){
      position = mouseX - X;
    }
    if(!mousePressed){
      pressed = false;
    }
    value = map(position, 0, sliderLength, min, max);
  }
  
  void showValue(){
    pushStyle();
    textAlign(CENTER);
    textSize(30);
    fill(color(textColor));
    if (pressed){
      text(int(value), X + position, Y - radius - 30);
    }
    popStyle();
  }
  
  void display(){
    primaryHue = hue(primaryColor);
    primarySat = saturation(primaryColor);
    primaryVal = brightness(primaryColor);
    pushStyle();
    strokeCap(ROUND);
    stroke(primaryColor);
    strokeWeight(weight);
    line(X, Y, X + position, Y);
    stroke(secondaryColor);
    line(X + position, Y, X + sliderLength, Y);
    if(pressed){
      fill(primaryHue, primarySat, primaryVal - 25);
      stroke(primaryHue, primarySat, primaryVal - 25); 
    }
    else if(mouseX > X - radius && mouseX < X + sliderLength + radius && mouseY > Y - radius && mouseY < Y + radius){
      fill(primaryHue, primarySat, primaryVal + 30);
      stroke(primaryHue, primarySat, primaryVal + 30);
    }
    else{
      fill(primaryColor);
      stroke(primaryColor);
    }
    ellipse(X + position, Y, radius * 2, radius * 2);
    popStyle();
    showValue();
    detectDrag();
  }
}
