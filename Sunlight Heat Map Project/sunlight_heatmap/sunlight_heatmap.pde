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

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    //println("User selected " + selection.getAbsolutePath());
    folderPath = selection.getAbsolutePath();
  }
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  }
  return null;
}

void loadImages(){
  if (folderPath != null && !imagesLoaded){
    println(folderPath);
    
    String[] filenames = listFileNames(folderPath);
    for(String fileName : filenames){
      PImage tempImage = loadImage(folderPath + "/" + fileName);
      tempImage.resize(width, 0);
      images.add(tempImage);
      if(firstImage == null){
        firstImage = tempImage;
      }
      numImages++;
    }
    imageWidth = images.get(0).width;
    imageHeight = images.get(0).height;
    pixVal = new float[imageWidth * imageHeight];
    imagesLoaded = true;
  }
}

void layerImages(){
  if(imagesLoaded && !imagesLayered) {
    if(images.size() > 0){
      PImage tempImage = images.remove(0);
      tempImage.loadPixels();
      for(int i = 0; i < pixVal.length; i++){
        pixVal[i] = pixVal[i] + 1.0 * brightness(tempImage.pixels[i]) / numImages;
      }
    }
    else {
      imagesLayered = true;
    }
  }
}
  
void createImageFromArray(){
  if(imagesLayered){
    layeredImage = createImage(imageWidth, imageHeight, RGB);
    layeredImage.loadPixels();
    for(int i = 0; i < pixVal.length; i++){
      layeredImage.pixels[i] = color((pixVal[i]-127) * contrast + 127 + brightness);
    }
    layeredImage.updatePixels();
    layeredImageCreated = true;
  }
}

void recolor(){
  recoloredImage = createImage(imageWidth, imageHeight, RGB);
  layeredImage.loadPixels();
  recoloredImage.loadPixels();
  for (int i = 0; i < layeredImage.pixels.length; i++) {
    if (brightness(layeredImage.pixels[i]) > 220){
      recoloredImage.pixels[i] = color(0, brightness(layeredImage.pixels[i]), 0);
    }
    else if (brightness(layeredImage.pixels[i]) > 150){
      recoloredImage.pixels[i] = color(brightness(layeredImage.pixels[i]), brightness(layeredImage.pixels[i]), 0);
    }
    else { //if brightness is below 150
      recoloredImage.pixels[i] = color(brightness(layeredImage.pixels[i]) + 50, 0, 0);
    }
  }
  recoloredImage.updatePixels();
}

void centeredImage(PImage image) {
  float imageRatio = 1.0 * image.width / image.height;
  float windowRatio = 1.0 * width / height;
    
  if (imageRatio < windowRatio) {
    //window is wider than image
    image(image, width / 2 - imageRatio * height / 2, 0, imageRatio * height, height);
  }
  else{
    //window is taller than image
    image(image, 0, height / 2 - width / imageRatio / 2, width, width / imageRatio);
  }
}
