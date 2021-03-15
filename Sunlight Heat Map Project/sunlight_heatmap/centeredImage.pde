void centeredImage(PImage image, float xPos, float yPos, float windowWidth, float windowHeight) {
  float imageRatio = 1.0 * image.width / image.height;
  float windowRatio = 1.0 * windowWidth / windowHeight;
    
  if (imageRatio < windowRatio) {
    //window is wider than image
    image(image, xPos + windowWidth / 2 - imageRatio * windowHeight / 2, yPos, imageRatio * windowHeight, windowHeight);
  }
  else{
    //window is taller than image
    image(image, xPos, yPos + windowHeight / 2 - windowWidth / imageRatio / 2, windowWidth, windowWidth / imageRatio);
  }
}
