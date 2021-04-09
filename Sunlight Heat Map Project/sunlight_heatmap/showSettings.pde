void showSettings(){
  final int fadeSpeed = 100;
  final int opacity = 255;
  
  if(settingsButton.click){
    settingsPage=!settingsPage;
    settingsPageMillis=millis();
  }
  
  if(settingsPage){
    
    fill(backgroundColor,constrain(map(millis()-settingsPageMillis, 0, fadeSpeed, 0, opacity), 0, opacity));
    rect(0,0,width,height);
    
    
    //if(millis()-settingsPageMillis<animationTime){
    //  fill(map(1.0*(millis()-settingsPageMillis)/animationTime,0.0,1.0,brightness(backgroundColor)+30,brightness(backgroundColor)));
    //  circle(settingsButton.X+settingsButton.buttonWidth/2,settingsButton.Y+settingsButton.buttonHeight/2,2*dist(0,0,width,height)*(millis()-settingsPageMillis)/animationTime);
    //}else{
    //  background(backgroundColor);
    //}
  }
  else{
    fill(backgroundColor,constrain(map(millis()-settingsPageMillis, fadeSpeed, 0, 0, opacity), 0, opacity));
    rect(0,0,width,height);
  }
  
  if (settingsButton.visible){
    settingsButton.display();
    float iconWidth = .5 * settingsButton.buttonWidth;
    float iconHeight = 1.2 * iconWidth;
    float iconBufferX = (settingsButton.buttonWidth - iconWidth) / 2;
    float iconBufferY = (settingsButton.buttonHeight - iconHeight) / 2;
    saveIcon(settingsButton.X + iconBufferX, settingsButton.Y + iconBufferY, iconWidth, #FFFFFF);
  }
}
