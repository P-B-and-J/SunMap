String folderPath = null;
boolean imagesLoaded = false;
ArrayList<PImage> images = new ArrayList<PImage>();
boolean imagesLayered = false;
PImage layeredImage;
PImage recoloredImage;
PImage firstImage;
float[] pixVal;
int imageHeight;
int imageWidth;
boolean layeredImageCreated = false;
int numImages = 0;
int counter=0;
float contrast = 0;
float brightness = 0;
color backgroundColor = #292929;
color sideBarColor;
float sideBarWidth = 450;
float topBarWidth = 50;
float buffer = 50;  //something's wrong with the toggle class; it works if this is set to 50 but moves too far if it's set to 40
float miniViewWidth = sideBarWidth - 2 * buffer;
float miniViewHeight = 9 * (sideBarWidth - 2 * buffer) / 16;
boolean layering = false;
boolean loading = false;
color accentBlue = #3A7793;
color accentRed = #F00F16;
int numInvalidImages = 0;
float loadingX, loadingY;
int loadingWidth, loadingHeight;
float labelSize = 20;

Folder_Selector selectFolder;
Button processImagesButton;
Two_Step_Button newAnalysis;
Toggle colorModeToggle;
Toggle overlayToggle;
Slider brightnessSlider;
Slider contrastSlider;
Button smallLeftButton;
Button smallRightButton;
Button bigLeftButton;
Button bigRightButton;
Progress_Bar loadingProgress;
Progress_Bar layeringProgress;
//Progress_Bar testProgressBar;

void setup() {
  frameRate(120);
  colorMode(HSB);
  surface.setSize(3 * displayWidth / 4, 3 * displayHeight / 4);
  surface.setLocation(displayWidth / 8, displayHeight / 8);
  surface.setResizable(true);

  sideBarColor = color(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 10);
  
  processImagesButton = new Button(width - sideBarWidth + buffer, /*topBarWidth + buffer*/ height - buffer - 75, sideBarWidth - 2 * buffer, 80);
  processImagesButton.textSize = 25;
  processImagesButton.borderOn = false;
  processImagesButton.text = "Process Images";
  processImagesButton.visible = true;
  
  newAnalysis = new Two_Step_Button(width - sideBarWidth + buffer, height - buffer - 75, sideBarWidth - 2 * buffer, 80);
  newAnalysis.textSize = 25;
  newAnalysis.mainText = "New Analysis";
  newAnalysis.primaryColor = accentBlue;
  newAnalysis.secondaryColor = accentRed;
  newAnalysis.visible = false;
  newAnalysis.begin();

  selectFolder = new Folder_Selector(width - sideBarWidth + buffer, miniViewHeight + 2 * buffer, sideBarWidth - 2 * buffer);
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
  
  loadingX = selectFolder.X + selectFolder.folderWidth + 2 * selectFolder.buffer + 1;
  loadingWidth = int(selectFolder.selectorWidth - (selectFolder.folderWidth + selectFolder.buffer));
  loadingHeight = int(selectFolder.textSize) + 10;
  loadingY = selectFolder.Y + selectFolder.folderHeight / 7 + (selectFolder.folderHeight - selectFolder.folderHeight / 7) / 2.5 - loadingHeight / 2;
  loadingProgress = new Progress_Bar(loadingX, loadingY, loadingWidth, loadingHeight);
  loadingProgress.text = "\\sample_folder";
  loadingProgress.textSize = selectFolder.textSize;
  loadingProgress.backgroundColor = sideBarColor;
  //loadingProgress.rectOn = false;
  loadingProgress.begin();
  
  layeringProgress = new Progress_Bar(processImagesButton.X, processImagesButton.Y, int(processImagesButton.buttonWidth), int(processImagesButton.buttonHeight));
  layeringProgress.text = "Processing Images...";
  layeringProgress.textAlignH = CENTER;
  layeringProgress.textX = layeringProgress.barWidth / 2;
  layeringProgress.textColor2 = 255;
  layeringProgress.backgroundColor = accentBlue;
  layeringProgress.primaryColor = color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 20);
  layeringProgress.rectOn = false;
  layeringProgress.begin();
  
  colorModeToggle = new Toggle(width - sideBarWidth + buffer, 0, 2 * buffer);
  colorModeToggle.Y = miniViewHeight + colorModeToggle.labelBuffer + 2 * buffer;
  colorModeToggle.textSize = labelSize;
  colorModeToggle.visible = false;
  
  overlayToggle = new Toggle(width - sideBarWidth + buffer, 0, 2 * buffer);
  overlayToggle.Y = colorModeToggle.Y + colorModeToggle.slotRadius + overlayToggle.labelBuffer + buffer;
  overlayToggle.textSize = labelSize;
  overlayToggle.visible = false;
  
  brightnessSlider = new Slider(width - sideBarWidth + buffer, 0, sideBarWidth - 2 * buffer);
  brightnessSlider.Y = overlayToggle.Y + overlayToggle.slotRadius + brightnessSlider.labelBuffer + buffer;
  brightnessSlider.labelBuffer = .7 * buffer;
  brightnessSlider.textSize = labelSize;
  brightnessSlider.floatingVal = false;
  brightnessSlider.visible = false;
  
  contrastSlider = new Slider(width - sideBarWidth + buffer, 0, sideBarWidth - 2 * buffer);
  contrastSlider.Y = brightnessSlider.Y + brightnessSlider.radius + contrastSlider.labelBuffer + buffer;
  contrastSlider.labelBuffer = .7 * buffer;
  contrastSlider.textSize = labelSize;
  contrastSlider.floatingVal = false;
  contrastSlider.visible = false;
  
  //overlayToggle.textSize = brightnessSlider.textSize; //toggle text size is too big and I can't figure out why...
}

void draw() {
  background(backgroundColor);  //setting the background and sidebar
  noStroke();
  fill(sideBarColor);
  rect(width - sideBarWidth, 0, sideBarWidth, height);
  fill(backgroundColor);
  rect(width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
  
  //if(testProgressBar.visible){
  //  testProgressBar.display(1.0 * counter / numImages);
  //}
  
  selectFolder.X = width - sideBarWidth + buffer;  //setting select folder button position and visibility
  if(selectFolder.visible){
    selectFolder.display();
  }
  
  processImagesButton.X = width - sideBarWidth + buffer;  //setting process images button position and visibility
  processImagesButton.Y = height - buffer - 75;
  if(processImagesButton.visible){
    processImagesButton.display();
  }
  
  newAnalysis.X = width - sideBarWidth + buffer;
  newAnalysis.Y = height - buffer - 75;
  if(newAnalysis.visible){
    newAnalysis.display();
  }
  
  layeringProgress.X = processImagesButton.X;
  layeringProgress.Y = processImagesButton.Y;
  if(layeringProgress.visible){
    layeringProgress.display(1.0 * counter / numImages);
  }
  
  loadingProgress.X = /*loadingX; */selectFolder.X + selectFolder.folderWidth + 2 * selectFolder.buffer;
  loadingProgress.Y = /*loadingY; */selectFolder.Y + selectFolder.folderHeight / 7 + (selectFolder.folderHeight - selectFolder.folderHeight / 7) / 2.5 - loadingProgress.barHeight / 2;
  if(loadingProgress.visible){
    loadingProgress.display(1.0 * counter / numImages);
  }
  
  overlayToggle.X = width - sideBarWidth + buffer;  //setting toggle position and visibility
  if(overlayToggle.visible){
    overlayToggle.display("Overlay: ", "On", "Off");
  }
  
  colorModeToggle.X = width - sideBarWidth + buffer;
  if(colorModeToggle.visible){
    colorModeToggle.display("Color Mode:", "Heat map", "Grayscale");
  }
  
  brightnessSlider.X = width - sideBarWidth + buffer;
  if(brightnessSlider.visible){
    brightnessSlider.display("Brightness: " + int(brightnessSlider.value));
  }
  
  contrastSlider.X = width - sideBarWidth + buffer;
  if(contrastSlider.visible){
    contrastSlider.display("Contrast: " + int(contrastSlider.value));
  }

  if (selectFolder.browseButton.click) {  //the main code
    reset();
    selectFolder("Select a folder to process:", "folderSelected");
  }
  
  if(folderPath != null){
    selectFolder.setText(folderPath);
    selectFolder.useFolderButton.visible = true;
  }
  else{
    selectFolder.useFolderButton.visible = false;
  }
  
  if(selectFolder.useFolderButton.click){
    imagesLoaded = false;
    imagesLayered = false;
    layeredImageCreated = false;
    if(!imagesLoaded){
      loading = true;
      counter = 0;
      numInvalidImages = 0;
    }
  }
  
    if(loading && !imagesLoaded){
      loadImages();
      if(loadingProgress.text != selectFolder.folderReadout){
        loadingProgress.text = selectFolder.folderReadout;
        loadingProgress.textSize = selectFolder.textSize;
        loadingProgress.begin();
      }
      loadingProgress.visible = true;
      //selectFolder.useFolderButton.enabled = false;
    }
    else{
      loading=false;
      loadingProgress.visible = false;
      selectFolder.useFolderButton.enabled = true;
    }
  
  if(imagesLoaded){
    int previewImage = 0;
    processImagesButton.enabled = true;
    processImagesButton.primaryColor = accentBlue;
    processImagesButton.textColor = #FFFFFF;
    if(!layeredImageCreated){
      centeredImage(images.get(previewImage), buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    if(!overlayToggle.toggling && !colorModeToggle.toggling){ 
      centeredImage(images.get(previewImage), width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
    }
    
    
    if(smallRightButton.click && previewImage < numImages){
      previewImage++;
    }
    else if(smallRightButton.click && previewImage == numImages){
      previewImage = 0;
    }
    
    if(smallLeftButton.click && previewImage > 0){
      previewImage--;
    }
    else if(smallLeftButton.click && previewImage == 0){
      previewImage = numImages;
    }
  }
  else{
    processImagesButton.enabled = false;
    processImagesButton.primaryColor = #5D5D5D;
    processImagesButton.textColor = color(#FFFFFF, 150);
  }
  
  if (processImagesButton.click && !imagesLayered) {
    layering = true;
    counter = 0;
  }
  
  if(layering && !imagesLayered){
    layeringProgress.visible = true;
    layerImages();
  }
  else{
    layeringProgress.visible = false;
    layering = false;
  }
  
  contrast = contrastSlider.value;
  brightness = brightnessSlider.value * 50;

  if (imagesLayered) {
    createImageFromArray();
    overlayToggle.visible = true;
    colorModeToggle.visible = true;
    brightnessSlider.visible = true;
    contrastSlider.visible = true;
    selectFolder.visible = false;
  }
  else{
    overlayToggle.visible = false;
    colorModeToggle.visible = false;
    brightnessSlider.visible = false;
    contrastSlider.visible = false;
    selectFolder.visible = true;
  }
  
  if(layeredImageCreated){
    processImagesButton.visible = false;
    newAnalysis.visible = true;
  }
  else{
    processImagesButton.visible = true;
    newAnalysis.visible = false;
  }

  if (layeredImageCreated && !overlayToggle.toggling && !colorModeToggle.toggling) {
    if(colorModeToggle.toggled){
      recolor();
      centeredImage(recoloredImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    else{
      centeredImage(layeredImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    centeredImage(firstImage, width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
    if(overlayToggle.toggled){
      tint(255, 160);
      centeredImage(firstImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    noTint();
  }
  
  if(newAnalysis.confirmed){
    reset();
  }
  
  smallLeftButton.X = width - sideBarWidth + buffer;
  smallLeftButton.display();
  
  smallRightButton.X = width - buffer - miniViewWidth / 8;
  smallRightButton.display();
}

void reset(){
  folderPath = null;
  imagesLoaded = false;
  imagesLayered = false;
  layeredImageCreated = false;
  selectFolder.folderReadout = "No folder selected";
}
