class Toggle{
  float X;
  float Y;
  float slotLength;
  float slotWidth;
  float slotRadius;
  float toggleRadius;
  float borderWeight = 4;
  color fillColorOn = #3A7793;
  color fillColorOff = color(#FFFFFF, 0);
  color borderColorOn = #3A7793;
  color borderColorOff = #5D5D5D;
  color knobColorOn = #FFFFFF;
  color knobColorOff = #5D5D5D;
  boolean enabled;
  boolean clicked;
  boolean pressed = false;
  boolean justPressed = false;
  boolean toggled = false;
  float position = 0;
  float clickX;
  float clickY;
  boolean mouseWasPressed = false;
  
  Toggle(float _X, float _Y, float _slotLength){
    X = _X;
    Y = _Y;
    slotLength = _slotLength;
    slotWidth = slotLength / 2.5;
    slotRadius = slotWidth / 2;
  }
  
  void detectClick(){
    if(mousePressed && !mouseWasPressed){
        clickX = mouseX;
        clickY = mouseY;
        mouseWasPressed = true;
    }
    
    clicked = false;
    if(mousePressed && clickX >= X - toggleRadius - 25 && clickX <= X + slotLength + toggleRadius + 25 && clickY >= Y - toggleRadius - 25 && clickY <= Y + slotWidth + toggleRadius + 25){
      pressed = true;
    }
    else{
      pressed = false;
    }
    
    if(pressed){
      justPressed = true;
    }
    
    if(justPressed && !pressed){
      if(!mousePressed){
        clicked = true;
      }
      justPressed = false;
    }
    
    mouseWasPressed = mousePressed;
  }
  
  void setColorOn(color c, color k){
    fillColorOn = c;
    borderColorOn = c;
    knobColorOn = k;
  }
  
  void setColorOn(color c){
    fillColorOn = c;
    borderColorOn = c;
  }
  
  void setColorOff(color c){
    fillColorOff = c;
    borderColorOff = c;
    knobColorOff = c;
  }
  
 // void drawSlot(){
    
  
  void display(){
    detectClick();
    pushStyle();
    colorMode(HSB);
    strokeWeight(borderWeight);
    
    
    if(clicked){
      if(!toggled){
        toggled = true;
      }
      else{
        toggled = false;
      }
    }
    
    color fillColor;
    color borderColor;
    color knobColor;
    
    
    if(pressed){
      fillColor = borderColorOff;
      borderColor = borderColorOff;
      knobColor = knobColorOn;
    }
    else if (toggled){
      fillColor = fillColorOn;
      borderColor = borderColorOn;
      knobColor = knobColorOn;
    }
    else{
      fillColor = fillColorOff;
      borderColor = borderColorOff;
      knobColor = knobColorOff;
    }
    
    
    fill(fillColor);  //fill the center of the rectangle
    noStroke();
    rect(X + slotRadius, Y - slotRadius, slotLength - 2 * slotRadius, 2 * slotRadius);
    
    stroke(borderColor);
    line(X + slotRadius, Y - slotRadius, X + slotLength - slotRadius, Y - slotRadius);
    line(X + slotRadius, Y + slotRadius, X + slotLength - slotRadius, Y + slotRadius);
    arc(X + slotRadius, Y, slotWidth, slotWidth, PI / 2, 3 * PI / 2);
    arc(X + slotLength - slotRadius, Y, slotWidth, slotWidth, 3 * PI / 2, 5 * PI / 2);
    
    
    float frames = 20;
    float step = (slotLength - 2 * slotRadius) / frames;
    
    if(toggled && position < step * frames){
      position += step;
    }
    
    if(!toggled && position > 0){
      position -= step;
    }
    
    fill(knobColor);
    stroke(knobColor);
    ellipse(X + slotRadius + position, Y, slotRadius, slotRadius);
    
    popStyle();
  }
}
