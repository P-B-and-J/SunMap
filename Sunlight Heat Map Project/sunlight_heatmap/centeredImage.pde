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
