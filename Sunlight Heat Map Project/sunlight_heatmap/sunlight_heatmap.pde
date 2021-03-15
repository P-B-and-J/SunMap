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
float contrast = 0;
float brightness = 0;
color backgroundColor = #292929;
color sideBarColor;
float rightBuffer = 400;

Button selectFolderButton;

void setup() {
  frameRate(120);
  colorMode(HSB);
  surface.setSize(3 * displayWidth / 4, 3 * displayHeight / 4);
  surface.setLocation(displayWidth / 8, displayHeight / 8);
  surface.setResizable(true);
  
  sideBarColor = color(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 10);
  
  noSmooth();
  
  selectFolderButton = new Button(width - rightBuffer, 150, 300, 75);
  
  selectFolder("Select a folder to process:", "folderSelected");
  

}

void draw() {
  //background(backgroundColor);
  selectFolderButton.X = width - rightBuffer;
  noStroke();
  fill(sideBarColor);
  rect(width - 450, 0, 450, height);
  selectFolderButton.display();
  
  //if(selectFolderButton.click){
    //  selectFolder("Select a folder to process:", "folderSelected");
      loadImages();
  //}
  
  layerImages();
  contrast = mouseX * 10.0 / width;
  brightness = -mouseY * 255 / height + 127;
  createImageFromArray();
  
  
  if(layeredImageCreated) {
    //centeredImage(layeredImage);
    recolor();
    centeredImage(recoloredImage, 30, 30, width - 60, height - 60);
    tint(255, 160);
    centeredImage(firstImage, 30, 30, width - 60, height - 60);
    noTint();
  }
}
