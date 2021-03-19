class Button {
  float X;
  float Y;
  float buttonWidth;
  float buttonHeight;
  float borderWeight = 10;
  color primaryColor = #5D5D5D;
  color textColor = #FFFFFF;
  float textSize = 30;
  String text = "";
  PFont font;
  boolean enabled = true;
  boolean pressed = false;
  boolean justPressed = false;
  boolean click = false;
  float clickX;
  float clickY;
  boolean mouseWasPressed = false;
  boolean visible;
  boolean arrowOn = false;
  int arrowDir = 0;
  boolean borderOn = true;
  
  Button(float _X, float _Y, float _buttonWidth, float _buttonHeight){
    X = _X;
    Y = _Y;
    buttonWidth = _buttonWidth;
    buttonHeight = _buttonHeight;
    font = createFont("Lucida Sans Regular", textSize);
  }
  
  void detectClick(){
    if(mousePressed && !mouseWasPressed){
        clickX = mouseX;
        clickY = mouseY;
        mouseWasPressed = true;
    }
    
    click = false;
    if(mousePressed && clickX >= X && clickX <= X + buttonWidth && clickY >= Y && clickY <= Y + buttonHeight){
      pressed = true;
    }
    else{
      pressed = false;
    }
    
    if(pressed){
      justPressed = true;
    }
    
    if(justPressed && !pressed){
      if(!mousePressed && mouseX >= X && mouseX <= X + buttonWidth && mouseY >= Y && mouseY <= Y + buttonHeight){
        click = true;
      }
      justPressed = false;
    }
    
    mouseWasPressed = mousePressed;
  }
  
  void drawText(){
    pushStyle();
    textAlign(CENTER, CENTER);
    textFont(font);
    textSize(textSize);
    fill(textColor);
    text(text, X + buttonWidth / 2, Y + buttonHeight / 2);
    popStyle();
  }
  
  void drawArrow(){
    pushStyle();
    stroke(textColor);
    if(arrowDir == 0){
      line(X + .25 * buttonWidth, Y + .5 * buttonHeight, X + .75 * buttonWidth, Y + .5 * buttonHeight + .5 * buttonWidth);
      line(X + .25 * buttonWidth, Y + .5 * buttonHeight, X + .75 * buttonWidth, Y + .5 * buttonHeight - .5 * buttonWidth);
    }
    if(arrowDir == 1){
      line(X + .5 * buttonWidth, Y + .25 * buttonHeight, X + .5 * buttonWidth + .5 * buttonHeight, Y + .75 * buttonHeight);
      line(X + .5 * buttonWidth, Y + .25 * buttonHeight, X + .5 * buttonWidth - .5 * buttonHeight, Y + .75 * buttonHeight);
    }
    if(arrowDir == 2){
      line(X + .75 * buttonWidth, Y + .5 * buttonHeight, X + .25 * buttonWidth, Y + .5 * buttonHeight + .5 * buttonWidth);
      line(X + .75 * buttonWidth, Y + .5 * buttonHeight, X + .25 * buttonWidth, Y + .5 * buttonHeight - .5 * buttonWidth);
    }
    if(arrowDir == 3){
      line(X + .5 * buttonWidth, Y + .75 * buttonHeight, X + .5 * buttonWidth + .5 * buttonHeight, Y + .25 * buttonHeight);
      line(X + .5 * buttonWidth, Y + .75 * buttonHeight, X + .5 * buttonWidth - .5 * buttonHeight, Y + .25 * buttonHeight);
    }
    popStyle();
  }
  
  void display(){
    if(enabled){
      detectClick();
    }
    pushStyle();
    noStroke();
    colorMode(HSB);
    if(pressed){
      fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30, alpha(primaryColor));
      stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) + 30, alpha(primaryColor)); 
    }
    else if(enabled && mouseX >= X && mouseX <= X + buttonWidth && mouseY >= Y && mouseY <= Y + buttonHeight){
      fill(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25, alpha(primaryColor));
      stroke(hue(primaryColor), saturation(primaryColor), brightness(primaryColor) - 25, alpha(primaryColor));
      if(arrowOn){
        drawArrow();
      }
    }
    else{
      fill(primaryColor);
      stroke(primaryColor);
    }
    strokeCap(SQUARE);
    strokeWeight(borderWeight);
    if(!borderOn){
      noStroke();
    }
    rect(X, Y, buttonWidth, buttonHeight);
    drawText();
    popStyle();
  }
}
