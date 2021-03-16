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

  selectFolderButton = new Button(width - rightBuffer+50, 150, 300, 75);
}

void draw() {
  background(backgroundColor);
  selectFolderButton.X = width - rightBuffer+50;
  noStroke();
  fill(sideBarColor);
  rect(width - rightBuffer, 0, rightBuffer, height);
  selectFolderButton.display();

  if (selectFolderButton.click) {
    folderPath = null;
    imagesLoaded = false;
    imagesLayered = false;
    layeredImageCreated = false;

    selectFolder("Select a folder to process:", "folderSelected");
  }
  if (folderPath != null && !imagesLoaded) {
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
    //centeredImage(layeredImage, 30, 30, width - 60 - rightBuffer, height - 60);
    recolor();
    centeredImage(recoloredImage, 30, 30, width - 60 - rightBuffer, height - 60);
    tint(255, 160);
    centeredImage(firstImage, 30, 30, width - 60 - rightBuffer, height - 60);
    noTint();
  }
}
