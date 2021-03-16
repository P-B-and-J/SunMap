class Folder_Selector{
  float X, Y;
  float selectorWidth, selectorHeight;
  color primaryColor = #FFFFFF;
  float textSize;
  String folderPath = "No folder selected";
  String buttonText = "Browse...";
  float buttonX, buttonY;
  float buttonWidth, buttonHeight;
  float folderWidth, folderHeight;
  float folderX, folderY;
  boolean visible;
  float buffer = 20;
  
  Folder_Selector(float _X, float _Y, float _selectorWidth, float _selectorHeight){
    X = _X;
    Y = _Y;
    selectorWidth = _selectorWidth;
    selectorHeight = _selectorHeight;
    selectorSetup();
    X = 450;
    Y = 300;
    folderWidth = 100;
    folderHeight = 85;
  }
  
  Button browseButton;
  
  void selectorSetup(){
    browseButton = new Button(buttonX, buttonY, buttonWidth, buttonHeight);
    browseButton.text = buttonText;
  }
  
  void drawFolderIcon(){
    rect(X, Y + folderHeight / 7, folderWidth, folderHeight - folderHeight / 7, folderHeight / 6);
    rect(X, Y, folderWidth / 2, folderHeight, folderHeight / 6);
  }
  
  void display(){
    pushStyle();
    stroke(primaryColor);
    fill(primaryColor);
    drawFolderIcon();
    text(folderPath, X + folderWidth + buffer, Y + folderHeight / 7 + (folderHeight - folderHeight / 7) / 2);
    
    popStyle();
  }
}
