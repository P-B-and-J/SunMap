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


Folder_Selector selectFolder;
Button processImagesButton;
Toggle overlayToggle;

void setup() {
  frameRate(120);
  colorMode(HSB);
  surface.setSize(3 * displayWidth / 4, 3 * displayHeight / 4);
  surface.setLocation(displayWidth / 8, displayHeight / 8);
  surface.setResizable(true);

  sideBarColor = color(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 10);
  
  processImagesButton = new Button(width - sideBarWidth + buffer, /*topBarWidth + buffer*/ height - buffer - 75, sideBarWidth - 2 * buffer, 75);
  processImagesButton.textSize = 25;
  processImagesButton.text = "Process Images";
  processImagesButton.visible = true;

  selectFolder = new Folder_Selector(width - sideBarWidth + buffer, miniViewHeight + 2 * buffer, sideBarWidth - 2 * buffer);
  selectFolder.useFolderButton.primaryColor = #3A7793;
  //selectFolder.useFolderButton.text = "Load images";
  selectFolder.useFolderButton.visible = false;
  selectFolder.visible = true;
  
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
    selectFolder.folderReadout = "Loading images...";
    loadImages();
  }
  
  
  if(imagesLoaded){
    int previewImage = 0;
    processImagesButton.enabled = true;
    processImagesButton.primaryColor = #3A7793;
    processImagesButton.textColor = #FFFFFF;
    centeredImage(images.get(previewImage), width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
    centeredImage(images.get(previewImage), buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    
    if(mouseX >= width - sideBarWidth + buffer && mouseX <= width - sideBarWidth + 2 * buffer && mouseY >= buffer && mouseY <= buffer + miniViewHeight){
      pushStyle();
      stroke(#FFFFFF);
      line(width - sideBarWidth + 1.25 * buffer, buffer + miniViewHeight / 2, width - sideBarWidth + 1.75 * buffer, 1.5 * buffer + miniViewHeight / 2);
      line(width - sideBarWidth + 1.25 * buffer, buffer + miniViewHeight / 2, width - sideBarWidth + 1.75 * buffer, .5 * buffer + miniViewHeight / 2);
      popStyle();
      //add arrow click code here
    }
  }
  else{
    processImagesButton.enabled = false;
    processImagesButton.primaryColor = #5D5D5D;
    processImagesButton.textColor = color(#FFFFFF, 150);
  }
  
  if (processImagesButton.click && !imagesLayered) {
    layering = true;
  }
  
  if(layering && !imagesLayered){
    layerImages();
  }
  else{
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
    if(overlayToggle.toggled){
      tint(255, 160);
      centeredImage(firstImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    }
    noTint();
  }
}
