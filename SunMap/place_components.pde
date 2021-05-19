editInt settingsOffsetX, settingsOffsetY;

Button BGYSel, RYGSel, customRecolor;
Color_Picker recolorCP;

void initializeInputs() {
  settingsOffsetX = new editInt(0);
  settingsOffsetY = new editInt(0);

  settingsButton = new Button(/*width - topBarHeight / 2 - */buffer / 2, buffer / 2, topBarHeight / 2, topBarHeight / 2, settings, settingsOffsetX, settingsOffsetY);
  settingsButton.primaryColor = color(#FFFFFF, 0);
  settingsButton.hoveredColor = settingsButton.primaryColor;
  settingsButton.pressedColor = settingsButton.primaryColor;/*color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 30);*/
  settingsButton.borderOn = false;
  settingsButton.visible = true;
  settingsButton.menu = true;
  //settingsButton.select = true;

  placeSettings();

  processImagesButton = new Button(/*width - sideBarWidth +*/ buffer, /*topBarHeight + buffer*/ height - buffer - 75, sideBarWidth - 2 * buffer, 80, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  processImagesButton.textSize = 25; //HARDCODED
  processImagesButton.borderOn = false;
  processImagesButton.text = "Process Images";
  processImagesButton.visible = true;

  newAnalysis = new Two_Step_Button(/*width - sideBarWidth + */buffer, height - buffer - 75, sideBarWidth - 2 * buffer, 80, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  newAnalysis.textSize = 25; //HARDCODED
  newAnalysis.mainText = "New Analysis";
  newAnalysis.primaryColor = accentBlue;
  newAnalysis.secondaryColor = accentRed;
  newAnalysis.visible = false;
  newAnalysis.begin();

  miniViewY = buffer;

  selectFolder = new Folder_Selector(/*width - sideBarWidth +*/ buffer, miniViewY + miniViewHeight + buffer, sideBarWidth - 2 * buffer, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  selectFolder.useFolderButton.primaryColor = accentBlue;
  selectFolder.useFolderButton.borderColor = accentBlue;
  selectFolder.browseButton.borderColor = selectFolder.browseButton.primaryColor;
  selectFolder.useFolderButton.visible = false;
  selectFolder.visible = true;

  float errorBoxY = selectFolder.Y + selectFolder.folderHeight + selectFolder.buffer + selectFolder.buttonHeight + buffer;
  errorBox = new Label(selectFolder.browseButton.X, errorBoxY, sideBarWidth - selectFolder.browseButton.X - buffer, processImagesButton.Y - buffer - errorBoxY, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  errorBox.setFont("SansSerif.italic", int(.9 * labelSize));
  errorBox.textColor = accentRed;

  smallLeftButton = new Button(width - sideBarWidth + buffer, miniViewY, miniViewWidth / 8, miniViewHeight);
  smallLeftButton.arrowOn = true;
  smallLeftButton.arrowDir = 0;
  smallLeftButton.primaryColor = color(#FFFFFF, 0);
  smallLeftButton.borderOn = false;
  smallLeftButton.visible = true;

  smallRightButton = new Button(width - buffer - miniViewWidth / 8, miniViewY, miniViewWidth / 8, miniViewHeight);
  smallRightButton.arrowOn = true;
  smallRightButton.arrowDir = 2;
  smallRightButton.primaryColor = color(#FFFFFF, 0);
  smallRightButton.borderOn = false;
  smallRightButton.visible = true;

  bigLeftButton = new Button(0, topBarHeight + buffer, displayWidth / 20 * scaleFactor, height - topBarHeight-2*buffer);
  bigLeftButton.arrowOn = true;
  bigLeftButton.arrowDir = 0;
  bigLeftButton.primaryColor = color(#FFFFFF, 0);
  bigLeftButton.borderOn = false;
  bigLeftButton.visible = true;

  bigRightButton = new Button(width - sideBarWidth - displayWidth / 20 * scaleFactor, topBarHeight + buffer, displayWidth / 20 * scaleFactor, height - topBarHeight-2*buffer);
  bigRightButton.arrowOn = true;
  bigRightButton.arrowDir = 2;
  bigRightButton.primaryColor = color(#FFFFFF, 0);
  bigRightButton.borderOn = false;
  bigRightButton.visible = true;

  loadingX = selectFolder.X + selectFolder.folderWidth + 2 * selectFolder.buffer + 1; //+1?
  loadingWidth = int(selectFolder.selectorWidth - (selectFolder.folderWidth + 3*selectFolder.buffer));
  loadingHeight = int(selectFolder.textSize) + 10;  //HARDCODED
  loadingY = selectFolder.Y + selectFolder.folderHeight / 7 + (selectFolder.folderHeight - selectFolder.folderHeight / 7) / 2.5 - loadingHeight / 2;
  loadingProgress = new Progress_Bar(loadingX, loadingY, loadingWidth, loadingHeight, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  loadingProgress.text = "\\sample_folder";
  loadingProgress.textSize = selectFolder.textSize;
  loadingProgress.backgroundColor = sideBarColor;
  //loadingProgress.rectOn = false;
  loadingProgress.begin();

  layeringProgress = new Progress_Bar(processImagesButton.X, processImagesButton.Y, int(processImagesButton.buttonWidth), int(processImagesButton.buttonHeight), sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  layeringProgress.text = "Processing Images...";
  layeringProgress.textAlignH = CENTER;
  layeringProgress.textX = layeringProgress.barWidth / 2;
  layeringProgress.textColor2 = 255;
  layeringProgress.backgroundColor = accentBlue;
  layeringProgress.primaryColor = color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 20);
  layeringProgress.rectOn = false;
  layeringProgress.begin();

  colorModeToggle = new Toggle(.038 * displayWidth);
  colorModeToggle.drawTo(sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  colorModeToggle.labelBuffer = .7 * buffer;
  //colorModeToggle.Y = miniViewY + miniViewHeight + colorModeToggle.labelBuffer + 1.15 * buffer;
  colorModeToggle.textSize = labelSize;
  colorModeToggle.visible = false;

  overlayToggle = new Toggle(.038 * displayWidth);
  overlayToggle.drawTo(sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  overlayToggle.labelBuffer = .7 * buffer;
  //overlayToggle.Y = colorModeToggle.Y + colorModeToggle.slotRadius + overlayToggle.labelBuffer + 1.15 * buffer;
  overlayToggle.textSize = labelSize;
  overlayToggle.visible = false;

  brightnessSlider = new Slider(sideBarWidth - 2 * buffer);
  brightnessSlider.drawTo(sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  brightnessSlider.labelBuffer = .7 * buffer;
  brightnessSlider.textSize = labelSize;
  brightnessSlider.floatingVal = false;
  brightnessSlider.visible = false;

  contrastSlider = new Slider(sideBarWidth - 2 * buffer);
  contrastSlider.drawTo(sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  contrastSlider.labelBuffer = .7 * buffer;
  contrastSlider.textSize = labelSize;
  contrastSlider.floatingVal = false;
  contrastSlider.visible = false;

  overlayStrength = new Slider(sideBarWidth - 2 * buffer);
  overlayStrength.drawTo(sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  overlayStrength.labelBuffer = .7 * buffer;
  overlayStrength.textSize = labelSize;
  overlayStrength.floatingVal = false;
  overlayStrength.visible = false;

  exportButton = new Button(buffer, 0, sideBarWidth / 3, sideBarWidth / 8, sidebarGraphics, sidebarOffsetX, sidebarOffsetY);
  exportButton.primaryColor = accentBlue;
  exportButton.textColor = 255;
  exportButton.textSize = labelSize;
  exportButton.text = "Export...";
  exportButton.borderOn = false;
  exportButton.visible = false;
}


void setVisibility() {
  //if(testProgressBar.visible){
  //  testProgressBar.display(1.0 * counter / numImages);
  //}

  //if(BGYSel.visible){
  //  BGYSel.display();
  //}

  if (selectFolder.visible) {
    selectFolder.display();
    errorBox.display();
  } else {
    errorBox.labelText = "";
  }

  if (processImagesButton.visible) {
    processImagesButton.display();
  }

  if (newAnalysis.visible) {
    newAnalysis.display();
  }

  if (layeringProgress.visible) {
    layeringProgress.speed=4;
    //println(counter+"/"+numImages);
    layeringProgress.display(1.0 * counter / numImages);
    if (counter==numImages) {
      layeringProgress.speed=20;
    }
    if (layeringProgress.targetPos/layeringProgress.barWidth >= .995) {
      imagesLayered = true;
      counter=0;
    }
  }

  if (loadingProgress.visible) {
    loadingProgress.display(1.0 * counter / numImages);
  }


  if (colorModeToggle.visible) {
    colorModeToggle.display(buffer, miniViewY + miniViewHeight + colorModeToggle.labelBuffer + 1.15 * buffer, "Color Mode:", "Heat map", "Grayscale");
  }

  if (overlayToggle.visible) {
    overlayToggle.display(buffer, colorModeToggle.Y + colorModeToggle.slotRadius + overlayToggle.labelBuffer + 1.15 * buffer, "Overlay: ", "On", "Off");
  }

  if (brightnessSlider.visible) {
    brightnessSlider.display(buffer, overlayToggle.Y + overlayToggle.slotRadius + brightnessSlider.labelBuffer + 1.15 * buffer, "Brightness: " + int(brightnessSlider.value));
  }

  if (overlayStrength.visible) {
    overlayStrength.alpha = easeValue(overlayStrength.alpha, 255, 12 / fps);
    overlayStrength.display(buffer, easeValue(overlayStrength.Y, contrastSlider.Y + contrastSlider.radius + overlayStrength.labelBuffer + 1.15 * buffer, 12 / fps), "Overlay Strength: " + int(overlayStrength.value));
    overlayStrength.enabled = true;
  } else {
    overlayStrength.alpha = easeValue(overlayStrength.alpha, 0, 8 / fps);
    overlayStrength.display(buffer, easeValue(overlayStrength.Y, contrastSlider.Y, 8 / fps), "Overlay Strength: " + int(overlayStrength.value));
    overlayStrength.enabled = false;
  }

  if (contrastSlider.visible) {
    contrastSlider.backgroundOn = true;
    contrastSlider.backgroundColor = sideBarColor;
    contrastSlider.display(buffer, brightnessSlider.Y + brightnessSlider.radius + contrastSlider.labelBuffer + 1.15 * buffer, "Contrast: " + int(contrastSlider.value));
  }

  if (overlayStrength.Y<contrastSlider.Y) {
    overlayStrength.Y=contrastSlider.Y;
  }

  if (settingsButton.visible) {
    settingsButton.display();
  }

  if (exportButton.visible) {
    exportButton.Y = overlayStrength.Y + overlayStrength.radius + 1.15 * buffer;
    exportButton.display();
  }


  //float iconWidth = .5 * settingsButton.buttonWidth;
  //float iconHeight = 1.2 * iconWidth;
  //float iconBufferX = (settingsButton.buttonWidth - iconWidth) / 2;
  //float iconBufferY = (settingsButton.buttonHeight - iconHeight) / 2;
  //exportIcon(exportButton.X + iconBufferX, exportButton.Y + iconBufferY, iconWidth, #FFFFFF);



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

  errorBox.labelHeight = processImagesButton.Y - buffer - errorBox.y;

  settingsButton.X = /*width - settingsButton.buttonWidth - */buffer / 2;
}
