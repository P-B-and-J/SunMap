void showSettings(){
  final int fadeSpeed = 100;
  final int opacity = 255;
  
  if(settingsButton.click){
    settingsPage=!settingsPage;
    settingsPageMillis=millis();
  }
  
  settings.beginDraw();
  if(settingsPage){
    
    settings.fill(backgroundColor,constrain(map(millis()-settingsPageMillis, 0, fadeSpeed, 0, opacity), 0, opacity));
    settings.rect(0,0,width,height);
    

    settings.fill(settingsTextColor);
    settings.textSize(.015 * displayWidth * scaleFactor);
    settings.text("Recolor Style:", 2 * buffer, topBarHeight + buffer);
    settings.pushStyle();
    settings.textAlign(CENTER, CENTER);
    settings.text("More settings coming soon", width / 2, height / 2);
    settings.popStyle();
    BGYSel.display();
    RYGSel.display();
    customRecolor.display();
    
    
    if(BGYSel.click){
      BGYSel.toggle = true;
      RYGSel.toggle = false;
      customRecolor.toggle = false;
      recolorID = 0;
    }
    if(RYGSel.click){
      RYGSel.toggle = true;
      BGYSel.toggle = false;
      customRecolor.toggle = false;
      recolorID = 1;
    }
    if(customRecolor.click){
      customRecolor.toggle = true;
      BGYSel.toggle = false;
      RYGSel.toggle = false;
      recolorID = 2;
    }
    
    if(recolorID == 2){
      color1.display();
      color2.display();
      color3.display();
      //recolorCP.display(int(3 * buffer), int(customRecolor.Y + 2 * buffer));
    }
    recolorCP.y=int(color1.Y+2*buffer);
    
    if(color1.click){
      color2.toggle = false;
      color3.toggle = false;
    }
    if(color1.toggle){  
      color1.borderOn = true;
      recolorCP.display(int(3 * buffer), recolorCP.y);
    }
    else{
      color1.borderOn = false;
    }
    
    if(color2.click){
      color1.toggle = false;
      color3.toggle = false;
    }
    if(color2.toggle){
      color2.borderOn = true;
      recolorCP.display(int(3 * buffer), recolorCP.y);
    }
    else{
      color2.borderOn = false;
    }
    
    if(color3.click){
      color1.toggle = false;
      color2.toggle = false;
    }
    if(color3.toggle){
      color3.borderOn = true;
      recolorCP.display(int(3 * buffer), recolorCP.y);
    }
    else{
      color3.borderOn = false;
    }
          
    
    //if(millis()-settingsPageMillis<animationTime){
    //  fill(map(1.0*(millis()-settingsPageMillis)/animationTime,0.0,1.0,brightness(backgroundColor)+30,brightness(backgroundColor)));
    //  circle(settingsButton.X+settingsButton.buttonWidth/2,settingsButton.Y+settingsButton.buttonHeight/2,2*dist(0,0,width,height)*(millis()-settingsPageMillis)/animationTime);
    //}else{
    //  background(backgroundColor);
    //}
  }
  else{
    settings.fill(backgroundColor,constrain(map(millis()-settingsPageMillis, fadeSpeed, 0, 0, opacity), 0, opacity));
    settings.rect(0,0,width,height);
  }
  
  //if (settingsButton.visible){
    settingsButton.display();
    //float iconWidth = .5 * settingsButton.buttonWidth;
    //float iconHeight = 1.2 * iconWidth;
    //float iconBufferX = (settingsButton.buttonWidth - iconWidth) / 2;
    //float iconBufferY = (settingsButton.buttonHeight - iconHeight) / 2;
    //saveIcon(settingsButton.X + iconBufferX, settingsButton.Y + iconBufferY, iconWidth, #FFFFFF);
  //}
  
  image(settings, 0, 0);
  settings.endDraw();
}


Button color1, color2, color3;

void placeSettings(){
  BGYSel = new Button(3 * buffer, topBarHeight + 2.5 * buffer, .01 * displayWidth, .01 * displayWidth, settings, settingsOffsetX, settingsOffsetY);
  BGYSel.text = "BGY";
  BGYSel.borderOn = false;
  BGYSel.select = true;
  
  RYGSel = new Button(3 * buffer, BGYSel.Y + BGYSel.buttonHeight + buffer, .01 * displayWidth, .01 * displayWidth, settings, settingsOffsetX, settingsOffsetY);
  RYGSel.text = "RYG";
  RYGSel.borderOn = false;
  RYGSel.select = true;
  
  customRecolor = new Button(3 * buffer, RYGSel.Y + RYGSel.buttonHeight + buffer, .01 * displayWidth, .01 * displayWidth, settings, settingsOffsetX, settingsOffsetY);
  customRecolor.text = "Custom";
  customRecolor.borderOn = false;
  customRecolor.select = true;
  
  color1 = new Button(4 * buffer, customRecolor.Y + 2 * buffer, .015 * displayWidth, .01 * displayWidth, settings, settingsOffsetX, settingsOffsetY);
  color1.borderOn = false;
  color1.borderColor = accentBlue;
  color1.primaryColor = colorPalette[2][0];
  color1.hoveredColor = color1.primaryColor;
  color1.pressedColor = color1.primaryColor;
  
  color2 = new Button(color1.X + color1.buttonWidth + buffer, customRecolor.Y + 2 * buffer, .015 * displayWidth, .01 * displayWidth, settings, settingsOffsetX, settingsOffsetY);
  color2.borderOn = false;
  color2.borderColor = accentBlue;
  color2.primaryColor = colorPalette[2][1];
  color2.hoveredColor = color2.primaryColor;
  color2.pressedColor = color2.primaryColor;
  
  color3 = new Button(color2.X + color2.buttonWidth + buffer, customRecolor.Y + 2 * buffer, .015 * displayWidth, .01 * displayWidth, settings, settingsOffsetX, settingsOffsetY);
  color3.borderOn = false;
  color3.borderColor = accentBlue;
  color3.primaryColor = colorPalette[2][2];
  color3.hoveredColor = color3.primaryColor;
  color3.pressedColor = color3.primaryColor;
  
  
  recolorCP=new Color_Picker(1,#FFFFFF,displayWidth/10);
  recolorCP.drawTo(settings, settingsOffsetX, settingsOffsetY);
}
