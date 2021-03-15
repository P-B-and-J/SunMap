class Folder_Selector{
  float X, Y;
  float selectorWidth, selectorHeight;
  color primaryColor = #FFFFFF;
  float textSize;
  String folderPath = "No folder selected";
  String buttonText = "Browse...";
  float buttonX, buttonY;
  float buttonWidth, buttonHeight;
  float folderX, folderY;
  float folderWidth, folderHeight;
  boolean visible;
  
  Folder_Selector(float _X, float _Y, float _selectorWidth, float _selectorHeight){
    X = _X;
    Y = _Y;
    selectorWidth = _selectorWidth;
    selectorHeight = _selectorHeight;
    selectorSetup();
  }
  
  Button browseButton;
  
  void selectorSetup(){
    browseButton = new Button(buttonX, buttonY, buttonWidth, buttonHeight);
    browseButton.text = buttonText;
  }
  
  void drawFolderIcon(){
    rect(folderX, folderY + folderHeight / 5, folderWidth, folderHeight - (folderY + folderHeight / 5), folderHeight / 8);
    rect(folderX, folderY, folderWidth / 2, folderHeight, folderHeight / 8);
  }
  
  void display(){
    pushStyle();
    stroke(primaryColor);
    fill(primaryColor);
    drawFolderIcon();
    popStyle();
  }
}
