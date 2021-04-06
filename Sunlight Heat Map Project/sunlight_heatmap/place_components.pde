void initializeInputs() {
  processImagesButton = new Button(/*width - sideBarWidth +*/ buffer, /*topBarHeight + buffer*/ height - buffer - 75, sideBarWidth - 2 * buffer, 80,sidebarGraphics,sidebarOffsetX,sidebarOffsetY);
  processImagesButton.textSize = 25;
  processImagesButton.borderOn = false;
  processImagesButton.text = "Process Images";
  processImagesButton.visible = true;

  newAnalysis = new Two_Step_Button(/*width - sideBarWidth + */buffer, height - buffer - 75, sideBarWidth - 2 * buffer, 80,sidebarGraphics,sidebarOffsetX,sidebarOffsetY);
  newAnalysis.textSize = 25;
  newAnalysis.mainText = "New Analysis";
  newAnalysis.primaryColor = accentBlue;
  newAnalysis.secondaryColor = accentRed;
  newAnalysis.visible = false;
  newAnalysis.begin();

  selectFolder = new Folder_Selector(/*width - sideBarWidth +*/ buffer, miniViewHeight + 2 * buffer, sideBarWidth - 2 * buffer,sidebarGraphics,sidebarOffsetX,sidebarOffsetY);
  selectFolder.useFolderButton.primaryColor = accentBlue;
  selectFolder.useFolderButton.visible = false;
  selectFolder.visible = true;

  smallLeftButton = new Button(width - sideBarWidth + buffer, buffer, miniViewWidth / 8, miniViewHeight);
  smallLeftButton.arrowOn = true;
  smallLeftButton.arrowDir = 0;
  smallLeftButton.primaryColor = color(#FFFFFF, 0);
  smallLeftButton.borderWeight = 15;
  smallLeftButton.visible = true;

  smallRightButton = new Button(width - buffer - miniViewWidth / 8, buffer, miniViewWidth / 8, miniViewHeight);
  smallRightButton.arrowOn = true;
  smallRightButton.arrowDir = 2;
  smallRightButton.primaryColor = color(#FFFFFF, 0);
  smallRightButton.borderWeight = 15;
  smallRightButton.visible = true;

  bigLeftButton = new Button(0, topBarHeight + buffer, displayWidth / 20 * scaleFactor, height - topBarHeight-2*buffer);
  bigLeftButton.arrowOn = true;
  bigLeftButton.arrowDir = 0;
  bigLeftButton.primaryColor = color(#FFFFFF, 0);
  bigLeftButton.borderWeight = 15;
  bigLeftButton.visible = true;

  bigRightButton = new Button(width - sideBarWidth - displayWidth / 20 * scaleFactor, topBarHeight + buffer, displayWidth / 20 * scaleFactor, height - topBarHeight-2*buffer);
  bigRightButton.arrowOn = true;
  bigRightButton.arrowDir = 2;
  bigRightButton.primaryColor = color(#FFFFFF, 0);
  bigRightButton.borderWeight = 15;
  bigRightButton.visible = true;

  loadingX = selectFolder.X + selectFolder.folderWidth + 2 * selectFolder.buffer + 1;
  loadingWidth = int(selectFolder.selectorWidth - (selectFolder.folderWidth + 3*selectFolder.buffer));
  loadingHeight = int(selectFolder.textSize) + 10;
  loadingY = selectFolder.Y + selectFolder.folderHeight / 7 + (selectFolder.folderHeight - selectFolder.folderHeight / 7) / 2.5 - loadingHeight / 2;
  loadingProgress = new Progress_Bar(loadingX, loadingY, loadingWidth, loadingHeight,sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  loadingProgress.text = "\\sample_folder";
  loadingProgress.textSize = selectFolder.textSize;
  loadingProgress.backgroundColor = sideBarColor;
  //loadingProgress.rectOn = false;
  loadingProgress.begin();

  layeringProgress = new Progress_Bar(processImagesButton.X, processImagesButton.Y, int(processImagesButton.buttonWidth), int(processImagesButton.buttonHeight),sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  layeringProgress.text = "Processing Images...";
  layeringProgress.textAlignH = CENTER;
  layeringProgress.textX = layeringProgress.barWidth / 2;
  layeringProgress.textColor2 = 255;
  layeringProgress.backgroundColor = accentBlue;
  layeringProgress.primaryColor = color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 20);
  layeringProgress.rectOn = false;
  layeringProgress.begin();

  colorModeToggle = new Toggle(/*width - sideBarWidth +*/ buffer, 0, 2 * buffer, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  colorModeToggle.Y = miniViewHeight + colorModeToggle.labelBuffer + 2 * buffer;
  colorModeToggle.textSize = labelSize;
  colorModeToggle.visible = false;

  overlayToggle = new Toggle(/*width - sideBarWidth +*/ buffer, 0, 2 * buffer, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  overlayToggle.Y = colorModeToggle.Y + colorModeToggle.slotRadius + overlayToggle.labelBuffer + buffer;
  overlayToggle.textSize = labelSize;
  overlayToggle.visible = false;

  brightnessSlider = new Slider(buffer, 0, sideBarWidth - 2 * buffer, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  brightnessSlider.Y = overlayToggle.Y + overlayToggle.slotRadius + brightnessSlider.labelBuffer + buffer;
  brightnessSlider.labelBuffer = .7 * buffer;
  brightnessSlider.textSize = labelSize;
  brightnessSlider.floatingVal = false;
  brightnessSlider.visible = false;

  contrastSlider = new Slider(buffer, 0, sideBarWidth - 2 * buffer, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  contrastSlider.Y = brightnessSlider.Y + brightnessSlider.radius + contrastSlider.labelBuffer + buffer;
  contrastSlider.labelBuffer = .7 * buffer;
  contrastSlider.textSize = labelSize;
  contrastSlider.floatingVal = false;
  contrastSlider.visible = false;
  
  overlayStrength = new Slider(buffer, 0, sideBarWidth - 2 * buffer, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  overlayStrength.Y = contrastSlider.Y + contrastSlider.radius + overlayStrength.labelBuffer + buffer;
  overlayStrength.labelBuffer = .7 * buffer;
  overlayStrength.textSize = labelSize;
  overlayStrength.floatingVal = false;
  overlayStrength.visible = false;
  
  saveButton = new Button(5, 5, topBarHeight - 5, topBarHeight - 5);
  saveButton.primaryColor = color(#FFFFFF, 0);
  saveButton.hoveredColor = accentBlue;
  saveButton.pressedColor = color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 30);
  saveButton.borderOn = false;
  saveButton.visible = true;
  
  exportButton = new Button(saveButton.X + saveButton.buttonWidth + 5, 5, topBarHeight - 5, topBarHeight - 5);
  exportButton.primaryColor = color(#FFFFFF, 0);
  exportButton.hoveredColor = accentBlue;
  exportButton.pressedColor = color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 30);
  exportButton.borderOn = false;
  exportButton.visible = true;
}


void setVisibility() {
  //if(testProgressBar.visible){
  //  testProgressBar.display(1.0 * counter / numImages);
  //}

  if (selectFolder.visible) {
    selectFolder.display();
  }

  if (processImagesButton.visible) {
    processImagesButton.display();
  }

  if (newAnalysis.visible) {
    newAnalysis.display();
  }

  if (layeringProgress.visible) {
    layeringProgress.display(1.0 * counter / numImages);
  }

  if (loadingProgress.visible) {
    loadingProgress.display(1.0 * counter / numImages);
  }

  if (overlayToggle.visible) {
    overlayToggle.display("Overlay: ", "On", "Off");
  }

  if (colorModeToggle.visible) {
    colorModeToggle.display("Color Mode:", "Heat map", "Grayscale");
  }

  if (brightnessSlider.visible) {
    brightnessSlider.display("Brightness: " + int(brightnessSlider.value));
  }

  if (contrastSlider.visible) {
    contrastSlider.display("Contrast: " + int(contrastSlider.value));
  }
  
  if (overlayStrength.visible) {
    overlayStrength.display("Overlay Strength: " + int(overlayStrength.value));
  }

  if (saveButton.visible){
    saveButton.display();
    float iconWidth = .5 * saveButton.buttonWidth;
    float iconHeight = 1.2 * iconWidth;
    float iconBufferX = (saveButton.buttonWidth - iconWidth) / 2;
    float iconBufferY = (saveButton.buttonHeight - iconHeight) / 2;
    saveIcon(saveButton.X + iconBufferX, saveButton.Y + iconBufferY, iconWidth, #FFFFFF);
  }
  
  if (exportButton.visible){
    exportButton.display();
    float iconWidth = .5 * saveButton.buttonWidth;
    float iconHeight = 1.2 * iconWidth;
    float iconBufferX = (saveButton.buttonWidth - iconWidth) / 2;
    float iconBufferY = (saveButton.buttonHeight - iconHeight) / 2;
    exportIcon(exportButton.X + iconBufferX, exportButton.Y + iconBufferY, iconWidth, #FFFFFF);
  }
  smallLeftButton.display();
  smallRightButton.display();
  bigLeftButton.display();
  bigRightButton.display();
}

void setCoords() {
  sidebarOffsetX.val=int(width - sideBarWidth);
  //selectFolder.X = width - sideBarWidth + buffer;  //setting select folder button position and visibility

  //processImagesButton.X = width - sideBarWidth + buffer;  //setting process images button position and visibility
  processImagesButton.Y = height - buffer - 75;

  //newAnalysis.X = width - sideBarWidth + buffer;
  newAnalysis.Y = height - buffer - 75;

  //layeringProgress.X = processImagesButton.X;
  layeringProgress.Y = processImagesButton.Y;
  //loadingProgress.X = /*loadingX; */selectFolder.X + selectFolder.folderWidth + 2 * selectFolder.buffer;
  //loadingProgress.Y = /*loadingY; */selectFolder.Y + selectFolder.folderHeight / 7 + (selectFolder.folderHeight - selectFolder.folderHeight / 7) / 2.5 - loadingProgress.barHeight / 2;

  //overlayToggle.X = width - sideBarWidth + buffer;  //setting toggle position and visibility

  //colorModeToggle.X = width - sideBarWidth + buffer;

  //brightnessSlider.X = width - sideBarWidth + buffer;

  //contrastSlider.X = width - sideBarWidth + buffer;

  smallLeftButton.X = width - sideBarWidth + buffer;
  smallRightButton.X = width - buffer - miniViewWidth / 8;
  bigRightButton.X = width - sideBarWidth - bigRightButton.buttonWidth;

  bigLeftButton.buttonWidth = displayWidth / 20 * scaleFactor;
  bigLeftButton.buttonHeight = height - topBarHeight-2*buffer;
  bigRightButton.buttonWidth = displayWidth / 20 * scaleFactor;
  bigRightButton.buttonHeight = height - topBarHeight-2*buffer;
}
