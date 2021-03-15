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

void setup() {
  surface.setSize(500, 500);
  surface.setResizable(true);
  noSmooth();
  selectFolder("Select a folder to process:", "folderSelected");
}

void draw() {
  loadImages();
  layerImages();
  contrast = mouseX * 10.0 / width;
  brightness = -mouseY * 255 / height + 127;
  createImageFromArray();
  
  
  if(layeredImageCreated) {
    //centeredImage(layeredImage);
    recolor();
    centeredImage(recoloredImage);
    tint(255, 160);
    centeredImage(firstImage);
    noTint();
  }
}
