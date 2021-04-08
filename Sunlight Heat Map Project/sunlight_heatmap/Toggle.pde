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
  boolean toggling = false;
  float position = 0;
  float clickX;
  float clickY;
  boolean mouseWasPressed = false;
  boolean visible;
  float labelBuffer = 30;
  color textColor = knobColorOn;
  float textSize = 25;
  PGraphics drawTo;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false;

  
  Toggle(float _X, float _Y, float _slotLength){
    X = _X;
    Y = _Y;
    slotLength = _slotLength;
    slotWidth = slotLength / 2.5;
    slotRadius = slotWidth / 2;
    drawTo=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
  }
  Toggle(float _X, float _Y, float _slotLength, PGraphics _drawTo,editInt _offsetX, editInt _offsetY){
    this(_X,_Y,_slotLength);
    drawTo=_drawTo;
    offsetX=_offsetX;
    offsetY=_offsetY;
    useG=false;
  }
  
  void detectClick(){
    if(mousePressed && !mouseWasPressed){
        clickX = (mouseX-offsetX.val);
        clickY = (mouseY-offsetY.val);
        mouseWasPressed = true;
    }
    
    clicked = false;
    if(mousePressed && clickX >= X - toggleRadius && clickX <= X + slotLength + toggleRadius && clickY >= Y - slotRadius - borderWeight && clickY <= Y + slotRadius + borderWeight){
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
    
  
  void display(String label, String on, String off){
    if(!useG){
      drawTo.beginDraw();
    }
    drawTo.pushStyle();
    drawTo.textSize(textSize); //This shouldn't need to be set manually...
    drawTo.fill(textColor);
    drawTo.text(label, X, Y - 1.25 * labelBuffer);
    if(toggled){
      drawTo.text(on, X + slotLength + .5 * labelBuffer, Y + .5 * slotRadius);
    }
    else{
      drawTo.text(off, X + slotLength + .5 * labelBuffer, Y + .5 * slotRadius);
    }
    drawTo.popStyle();
    
    detectClick();
    drawTo.pushStyle();
    drawTo.colorMode(HSB);
    drawTo.strokeWeight(borderWeight);
    
    
    if(clicked && (mouseX-offsetX.val) >= X - toggleRadius && (mouseX-offsetX.val) <= X + slotLength + toggleRadius && (mouseY-offsetY.val) >= Y - slotRadius - borderWeight && (mouseY-offsetY.val) <= Y + slotRadius + borderWeight){
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
    
    
    drawTo.fill(fillColor);  //fill the center of the rectangle
    drawTo.noStroke();
    drawTo.rect(X + slotRadius, Y - slotRadius, slotLength - 2 * slotRadius, 2 * slotRadius);
    
    drawTo.stroke(borderColor);
    drawTo.line(X + slotRadius, Y - slotRadius, X + slotLength - slotRadius, Y - slotRadius);
    drawTo.line(X + slotRadius, Y + slotRadius, X + slotLength - slotRadius, Y + slotRadius);
    drawTo.arc(X + slotRadius, Y, slotWidth, slotWidth, PI / 2, 3 * PI / 2);
    drawTo.arc(X + slotLength - slotRadius, Y, slotWidth, slotWidth, 3 * PI / 2, 5 * PI / 2);
    
    
    //float frames = 15;
    //float step = (slotLength - 2 * slotRadius) / frames;
    
    //if(toggled && position < step * frames){
    //  position += step;
    //  toggling = true;
    //}
    //else if(!toggled && position > 0){
    //  position -= step;
    //  toggling = true;
    //}
    //else{
    //  toggling = false;
    //}
    
    if(toggled){
      position = easeValue(position, slotLength - 2 * slotRadius, 5 / frameRate);
    }
    else{
      position = easeValue(position, 0, 5 / frameRate);
    }
    
    drawTo.fill(knobColor);
    drawTo.stroke(knobColor);
    drawTo.ellipse(X + slotRadius + position, Y, slotRadius, slotRadius);
    drawTo.popStyle();
    if(!useG){
      drawTo.endDraw();
    }
  }
}
