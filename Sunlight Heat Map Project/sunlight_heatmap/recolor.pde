PImage recolor(PImage image) {
  pushStyle();
  colorMode(RGB);
  recoloredImage = createImage(image.width, image.height, RGB);
  image.loadPixels();
  recoloredImage.loadPixels();
  for (int i = 0; i < image.pixels.length; i++) {
    if (brightness(image.pixels[i]) > 220) {
      recoloredImage.pixels[i] = color(0, brightness(image.pixels[i]), 0);
    } 
    else if (brightness(image.pixels[i]) > 150) {
      recoloredImage.pixels[i] = color(brightness(image.pixels[i]), brightness(image.pixels[i]), 0);
    } 
    else { //if brightness is below 150
      recoloredImage.pixels[i] = color(brightness(image.pixels[i]) + 50, 0, 0);
    }
  }
  recoloredImage.updatePixels();
  popStyle();
  return recoloredImage;
}
