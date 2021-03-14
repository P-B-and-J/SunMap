class Button {
  float X;
  float Y;
  float buttonWidth;
  float buttonHeight;
  float borderWeight = 10;
  color primaryColor = #5D5D5D;
  color textColor = #FFFFFF;
  float textSize = 30;
  String text;
  boolean enabled = true;
  boolean pressed = false;
  boolean justPressed = false;
  boolean click = false;
  
  Button(float _X, float _Y, float _buttonWidth, float _buttonHeight){
    X = _X;
    Y = _Y;
    buttonWidth = _buttonWidth;
    buttonHeight = _buttonHeight;
  }
  
  void detectClick(){
    click = false;
    if(mousePressed && mouseX >= X && mouseX <= X + buttonWidth && mouseY >= Y && mouseY <= Y + buttonHeight){
      pressed = true;
    }
    else{
      pressed = false;
    }
    
    if(pressed){
      justPressed = true;
    }
    
    if(justPressed &! pressed){
      click = true;
      justPressed = false;
    }
  }
  
  void drawText(){
    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(textSize);
    fill(color(textColor));
    text(text, X + buttonWidth / 2, Y + buttonHeight / 2);
    popStyle();
  }
  
  void display(){
    detectClick();
    pushStyle();
    colorMode(HSB);
    if(pressed){
      fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30);
      stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30); 
    }
    else if(mouseX >= X && mouseX <= X + buttonWidth && mouseY >= Y && mouseY <= Y + buttonHeight){
      fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25);
      stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25);
    }
    else{
      fill(primaryColor);
      stroke(primaryColor);
    }
    strokeCap(SQUARE);
    strokeWeight(borderWeight);
    rect(X, Y, buttonWidth, buttonHeight);
    popStyle();
    drawText();
  }
}
