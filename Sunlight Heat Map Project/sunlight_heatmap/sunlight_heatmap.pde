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
float buffer = 50;
float miniViewWidth = sideBarWidth - 2 * buffer;
float miniViewHeight = 9 * (sideBarWidth - 2 * buffer) / 16;
boolean layering = false;
boolean loading = false;
color accentBlue = #3A7793;
int numInvalidImages = 0;


Folder_Selector selectFolder;
Button processImagesButton;
Toggle overlayToggle;
Button smallLeftButton;
Button smallRightButton;
Button bigLeftButton;
Button bigRightButton;
Progress_Bar layeringProgress;

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

  selectFolder = new Folder_Selector(width - sideBarWidth + buffer, miniViewHeight + 2 * buffer, sideBarWidth - 2 * buffer);
  selectFolder.useFolderButton.primaryColor = accentBlue;
  //selectFolder.useFolderButton.text = "Load images";
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
  
  layeringProgress = new Progress_Bar(processImagesButton.X, processImagesButton.Y, int(processImagesButton.buttonWidth), int(processImagesButton.buttonHeight));
  layeringProgress.text = "Processing Images...";
  layeringProgress.textAlignH = CENTER;
  layeringProgress.textX = layeringProgress.barWidth / 2;
  layeringProgress.textColor2 = 255;
  layeringProgress.backgroundColor = accentBlue;
  layeringProgress.primaryColor = color(hue(accentBlue), saturation(accentBlue), brightness(accentBlue) + 20);
  layeringProgress.rectOn = false;
  layeringProgress.begin();
  
  overlayToggle = new Toggle(width - sideBarWidth + buffer, selectFolder.Y + selectFolder.selectorHeight + buffer, 2 * buffer);
  overlayToggle.visible = false;
  
}

void draw() {
  background(backgroundColor);  //setting the background and sidebar
  noStroke();
  fill(sideBarColor);
  rect(width - sideBarWidth, 0, sideBarWidth, height);
  fill(backgroundColor);
  rect(width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
  
  
  selectFolder.X = width - sideBarWidth + buffer;  //setting select folder button position and visibility
  if(selectFolder.visible){
    selectFolder.display();
  }
  
  processImagesButton.X = width - sideBarWidth + buffer;  //setting process images button position and visibility
  processImagesButton.Y = height - buffer - 75;
  if(processImagesButton.visible){
    processImagesButton.display();
  }
  
  layeringProgress.X = processImagesButton.X;
  layeringProgress.Y = processImagesButton.Y;
  if(layeringProgress.visible){
    layeringProgress.display(1.0 * counter / numImages);
  }
  
  overlayToggle.X = width - sideBarWidth + buffer;  //setting toggle position and visibility
  if(overlayToggle.visible){
    overlayToggle.display();
  }

  if (selectFolder.browseButton.click) {  //the main code
    folderPath = null;
    imagesLoaded = false;
    imagesLayered = false;
    layeredImageCreated = false;
    selectFolder("Select a folder to process:", "folderSelected");
  }
  
  if(folderPath != null){
    selectFolder.setText(folderPath);
    selectFolder.useFolderButton.visible = true;
    //if(imagesLoaded){
    //  centeredImage(firstImage, width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
    //}
    //else{
    //  loadImages();
    //}
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
  
    if(loading&&!imagesLoaded){
   // selectFolder.folderReadout = "Loading images...";
      loadImages();
      println(counter+"/"+numImages);
    }else{
      loading=false;
    }
  
  if(imagesLoaded){
    int previewImage = 0;
    processImagesButton.enabled = true;
    processImagesButton.primaryColor = accentBlue;
    processImagesButton.textColor = #FFFFFF;
    if(!layeredImageCreated){
      centeredImage(images.get(previewImage), buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    if(!overlayToggle.toggling){ 
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
  
  contrast = 50;//mouseX * 10.0 / width;
  brightness = 50;//-mouseY * 255 / height + 127;

  if (imagesLayered) {
    createImageFromArray();
    overlayToggle.visible = true;
  }

  if (layeredImageCreated && !overlayToggle.toggling) {
    recolor();
    centeredImage(recoloredImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
      centeredImage(firstImage, width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
    if(overlayToggle.toggled){
      tint(255, 160);
      centeredImage(firstImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    noTint();
  }
  
  smallLeftButton.X = width - sideBarWidth + buffer;
  smallLeftButton.display();
  
  smallRightButton.X = width - buffer - miniViewWidth / 8;
  smallRightButton.display();
}
