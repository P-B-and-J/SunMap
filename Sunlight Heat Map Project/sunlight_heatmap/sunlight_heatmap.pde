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
float sideBarWidth = 400;
float topBarWidth = 50;
float buffer = 30;


Folder_Selector selectFolder;
Button processImagesButton;

void setup() {
  frameRate(120);
  colorMode(HSB);
  surface.setSize(3 * displayWidth / 4, 3 * displayHeight / 4);
  surface.setLocation(displayWidth / 8, displayHeight / 8);
  surface.setResizable(true);

  sideBarColor = color(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 10);
  
  processImagesButton = new Button(width - sideBarWidth + buffer, topBarWidth + buffer, sideBarWidth - 2 * buffer, 75);
  processImagesButton.textSize = 25;
  processImagesButton.text = "Process Images";
  processImagesButton.visible = true;

  selectFolder = new Folder_Selector(width - sideBarWidth + buffer, processImagesButton.Y + processImagesButton.buttonHeight + buffer, sideBarWidth - 2 * buffer);
  selectFolder.visible = true;
  
}

void draw() {
  background(backgroundColor);  //setting the background and sidebar
  noStroke();
  fill(sideBarColor);
  rect(width - sideBarWidth, 0, sideBarWidth, height);
  
  
  selectFolder.X = width - sideBarWidth + buffer;  //setting select folder button position and visibility
  if(selectFolder.visible){
    selectFolder.display();
  }
  
  processImagesButton.X = width - sideBarWidth + buffer;  //setting process images button position and visibility
  if(processImagesButton.visible){
    processImagesButton.display();
  }

  if (selectFolder.browseButton.click) {  //the main code
    folderPath = null;
    imagesLoaded = false;
    imagesLayered = false;
    layeredImageCreated = false;
    selectFolder("Select a folder to process:", "folderSelected");
    if(folderPath != null){
      selectFolder.folderReadout = folderPath;
    }
  }
  
  if (processImagesButton.click && folderPath != null && !imagesLoaded) {
    loadImages();
  }
  
  if (imagesLoaded && !imagesLayered) {
    layerImages();
  }
  
  contrast = mouseX * 10.0 / width;
  brightness = -mouseY * 255 / height + 127;

  if (imagesLayered) {
    createImageFromArray();
  }

  if (layeredImageCreated) {
    recolor();
    centeredImage(recoloredImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    tint(255, 160);
    centeredImage(firstImage, buffer, topBarWidth + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarWidth);
    noTint();
  }
}
