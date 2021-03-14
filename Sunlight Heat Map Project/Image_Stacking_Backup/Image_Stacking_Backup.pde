String folderPath = null;
boolean imagesLoaded = false;
ArrayList<PImage> images = new ArrayList<PImage>();
boolean imagesStacked = false;
PImage stackedImage;
float[] pixVal;
int imageHeight;
int imageWidth;
boolean stackedImageCreated = false;
int numImages = 0;

void setup() {
  surface.setSize(500, 500);
  surface.setResizable(true);
  noSmooth();
  selectFolder("Select a folder to process:", "folderSelected");
}

void draw() {
  if (folderPath != null && !imagesLoaded){
    println(folderPath);
    
    String[] filenames = listFileNames(folderPath);
    for(String fileName : filenames){
      PImage tempImage = loadImage(folderPath + "/" + fileName);
      tempImage.resize(width / 2, 0);
      images.add(tempImage);
      numImages++;
    }
    imageWidth = images.get(0).width;
    imageHeight = images.get(0).height;
    pixVal = new float[imageWidth * imageHeight];
    imagesLoaded = true;
  }
  
  if(imagesLoaded && !imagesStacked) {
    if(images.size() > 0){
      PImage tempImage = images.remove(0);
      tempImage.loadPixels();
      for(int i = 0; i < pixVal.length; i++){
        pixVal[i] = pixVal[i] + 1.0 * brightness(tempImage.pixels[i]) / numImages;
      }
    }
    else {
      imagesStacked = true;
    }
  }
  
  if(imagesStacked && !stackedImageCreated){
    stackedImage = createImage(imageWidth, imageHeight, RGB);
    stackedImage.loadPixels();
    for(int i = 0; i < pixVal.length; i++){
      stackedImage.pixels[i] = color(pixVal[i]);
    }
    stackedImage.updatePixels();
    stackedImageCreated = true;
  }
  
  if(stackedImageCreated) {
    centeredImage(stackedImage);
  }
  
  //if(imagesLoaded){
  //  float imageRatio = 1.0 * images.get(0).width / images.get(0).height;
  //  float windowRatio = 1.0 * width / height;
    
  //  if (imageRatio < windowRatio) {
  //    //window is wider than image
  //    image(images.get((frameCount / 10) % images.size()), width / 2 - imageRatio * height / 2, 0, imageRatio * height, height);
  //  }
  //  else{
  //    //window is taller than image
  //    image(images.get((frameCount / 10) % images.size()), 0, height / 2 - width / imageRatio / 2, width, width / imageRatio);
  //  }
  //}
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
