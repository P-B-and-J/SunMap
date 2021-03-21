class Two_Step_Button{
  float X, Y;
  float buttonWidth, buttonHeight;
  color primaryColor = #3A7793;
  color secondaryColor = #3A7793;
  color textColor = #FFFFFF;
  String mainText = "Text";
  String yesText = "Confirm";
  String noText = "Cancel";
  String label = "Confirm?";
  float textSize = 25;
  boolean uncovered = false;
  boolean confirmed;
  boolean visible;
  float buffer = 10;
  
  Two_Step_Button(float _X, float _Y, float _buttonWidth, float _buttonHeight){
    X = _X;
    Y = _Y;
    buttonWidth = _buttonWidth;
    buttonHeight = _buttonHeight;
  }
  
  Button mainButton;
  Button confirmButton;
  Button cancelButton;
  
  void begin(){
    mainButton = new Button(X, Y, buttonWidth, buttonHeight);
    mainButton.primaryColor = primaryColor;
    mainButton.borderOn = false;
    mainButton.textSize = textSize;
    mainButton.textColor = textColor;
    mainButton.text = mainText;
    mainButton.visible = true;
    
    confirmButton = new Button(X, Y, buttonWidth / 2 - buffer, buttonHeight);
    confirmButton.primaryColor = secondaryColor;
    confirmButton.borderOn = false;
    confirmButton.textSize = textSize;
    confirmButton.textColor = textColor;
    confirmButton.text = yesText;
    confirmButton.visible = false;
  }
  
  void display(){
    mainButton.display();
    if(confirmButton.visible){
      confirmButton.display();
    }
    
    if(mainButton.click && !uncovered){
      confirmButton.visible = true;
      uncovered = true;
      mainButton.text = noText;
      mainButton.X = X + buttonWidth / 2 + buffer;
      mainButton.buttonWidth = buttonWidth / 2 - buffer;
    }
    else if(mainButton.click && uncovered){
      confirmButton.visible = false;
      uncovered = false;
      mainButton.text = mainText;
      mainButton.X = X;
      mainButton.buttonWidth = buttonWidth;
    }
    
    if(confirmButton.click){
      confirmed = true;
    }
    else{
      confirmed = false;
    }
  }
}
