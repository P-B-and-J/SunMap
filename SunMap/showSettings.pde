

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
    //customRecolor.display();
    
    
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
      //recolorID = 2;
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
    
    BGYSel.visible = false;
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
}
