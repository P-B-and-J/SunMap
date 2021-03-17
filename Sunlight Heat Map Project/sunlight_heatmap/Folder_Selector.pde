/* Copy this comment into main code for reference:

   Folder_Selector(float X, float Y, float selectorWidth)  //height calculated automatically

   Parameters: 
   color primaryColor;
   float textSize; 
   String folderPath; 
   String buttonText; 
   float buttonX, buttonY; 
   float buttonWidth, buttonHeight;
   float folderWidth, folderHeight; 
   float folderX, folderY; 
   boolean visible; 
   float buffer;
   float lineWeight;
   float lineLength;
*/

class Folder_Selector{
  float X, Y;
  float selectorWidth, selectorHeight;
  color primaryColor = #FFFFFF;
  float textSize;
  String folderReadout;
  String buttonText = "Browse...";
  float buttonX, buttonY;
  float buttonWidth, buttonHeight;
  float folderWidth, folderHeight;
  float folderX, folderY;
  boolean visible;
  float buffer = 10;
  float lineWeight;
  float lineLength;
  PFont normal;
  PFont italic;
  String folderPath = null;
  
  Folder_Selector(float _X, float _Y, float _selectorWidth){
    X = _X;
    Y = _Y;
    selectorWidth = _selectorWidth;
    folderWidth = selectorWidth / 9;
    folderHeight = folderWidth * 0.8;
    textSize = selectorWidth / 16;
    lineWeight = selectorWidth / 130;
    lineLength = folderWidth / 2;
    buttonHeight = 1.5 * lineLength;
    buttonWidth = buttonHeight * 4;
    buttonX = X + 2 * lineLength + 2 * buffer;
    buttonY = Y + folderHeight + buffer + lineLength + lineWeight / 2 - buttonHeight / 2;
    normal = createFont("Lucida Sans Regular", textSize);
    italic = createFont("SansSerif.italic", textSize);
    folderReadout = "No folder selected";
    selectorHeight = folderHeight + lineLength + 3 * buffer + buttonHeight / 2;
    //selectorHeight = 0.8 * (_selectorWidth / 9) + (_selectorWidth / 9) / 2 + 3 * buffer;
    selectorSetup();
  }
  
  Button browseButton;
  
  void selectorSetup(){
    browseButton = new Button(buttonX, buttonY, buttonWidth, buttonHeight);
    browseButton.font = italic;
    browseButton.text = buttonText;
    browseButton.textSize = textSize;
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
    textAlign(LEFT, CENTER);
    textSize(textSize);
    textFont(normal);
    text(folderReadout, X + folderWidth + 2 * buffer, Y + folderHeight / 7 + (folderHeight - folderHeight / 7) / 2.5);
    strokeWeight(lineWeight);
    strokeCap(SQUARE);
    line(X + lineLength, Y + folderHeight + buffer, X + lineLength, Y + folderHeight + buffer + lineLength + lineWeight / 2);
    line(X + lineLength - lineWeight / 2, Y + folderHeight + buffer + lineLength + lineWeight / 2, X + 2 * lineLength, Y + folderHeight + buffer + lineLength + lineWeight / 2);
    buttonX = X + 2 * lineLength + 2.5 * buffer;
    buttonY = Y + folderHeight + buffer + lineLength + lineWeight / 2 - buttonHeight / 2;
    browseButton.X = buttonX;
    browseButton.Y = buttonY;
    browseButton.buttonWidth = buttonWidth;
    browseButton.buttonHeight = buttonHeight;
    browseButton.display();
    popStyle();
  }
}