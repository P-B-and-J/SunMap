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

class Folder_Selector {
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
  PGraphics drawTo;
  editInt offsetX;
  editInt offsetY;
  boolean useG=false; 

  Folder_Selector(float _X, float _Y, float _selectorWidth) {
    X = _X;
    Y = _Y;
    drawTo=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
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
  Folder_Selector(float _X, float _Y, float _selectorWidth, PGraphics _drawTo, editInt _offsetX, editInt _offsetY) {
    this(_X, _Y, _selectorWidth);
    drawTo=_drawTo;
    useG=false;
    offsetX=_offsetX;
    offsetY=_offsetY;
    selectorSetup();
  }

  Button browseButton;
  Button useFolderButton;

  void selectorSetup() {
    browseButton = new Button(buttonX, buttonY, buttonWidth, buttonHeight, drawTo, offsetX, offsetY);
    browseButton.font = italic;
    browseButton.text = buttonText;
    browseButton.textSize = textSize;

    useFolderButton = new Button(buttonX + buttonWidth + buffer, buttonY, buttonWidth, buttonHeight, drawTo, offsetX, offsetY);
    useFolderButton.font = normal;
    useFolderButton.text = "Load files";
    useFolderButton.textSize = textSize;
  }

  void drawFolderIcon() {
    drawTo.rect(X, Y + folderHeight / 7, folderWidth, folderHeight - folderHeight / 7, folderHeight / 6);
    drawTo.rect(X, Y, folderWidth / 2, folderHeight, folderHeight / 6);
  }

  void setText(String text) {
    drawTo.pushStyle();
    drawTo.textAlign(LEFT, CENTER);
    drawTo.textSize(textSize);
    drawTo.textFont(normal);
    folderReadout = shortenText(text, selectorWidth - (folderWidth + 2 * buffer), 6,drawTo);
    drawTo.popStyle();
  }

  void display() {
    if (!useG) {
      drawTo.beginDraw();
    }
    drawTo.pushStyle();
    drawTo.stroke(primaryColor);
    drawTo.fill(primaryColor);
    drawFolderIcon();
    drawTo.textAlign(LEFT, CENTER);
    drawTo.textSize(textSize);
    drawTo.textFont(normal);
    drawTo.text(folderReadout, X + folderWidth + 2 * buffer, Y + folderHeight / 7 + (folderHeight - folderHeight / 7) / 2.5);
    drawTo.strokeWeight(lineWeight);
    drawTo.strokeCap(SQUARE);
    drawTo.line(X + lineLength, Y + folderHeight + buffer, X + lineLength, Y + folderHeight + buffer + lineLength + lineWeight / 2);
    drawTo.line(X + lineLength - lineWeight / 2, Y + folderHeight + buffer + lineLength + lineWeight / 2, X + 2 * lineLength, Y + folderHeight + buffer + lineLength + lineWeight / 2);
    drawTo.popStyle();
    if (!useG) {
      drawTo.endDraw();
    }
    buttonX = X + 2 * lineLength + 2.5 * buffer;
    buttonY = Y + folderHeight + buffer + lineLength + lineWeight / 2 - buttonHeight / 2;
    browseButton.X = buttonX;
    browseButton.display();
    useFolderButton.X = buttonX + buttonWidth + 2 * buffer;
    if (useFolderButton.visible) {
      useFolderButton.display();
    }
  }
}


String shortenText(String s, float w, int start) {
  if (textWidth(s) <= w) {
    return s;
  }
  int stringLength = s.length() - start;
  while (textWidth(s + "...") > w) {
    s = s.substring(0, start) + "..." + s.substring(s.length() - stringLength);
    stringLength--;
  }
  return s;
}

String shortenText(String s, float w, int start,PGraphics dt) {
  if (dt.textWidth(s) <= w) {
    return s;
  }
  int stringLength = s.length() - start;
  while (dt.textWidth(s + "...") > w) {
    s = s.substring(0, start) + "..." + s.substring(s.length() - stringLength);
    stringLength--;
  }
  return s;
}
