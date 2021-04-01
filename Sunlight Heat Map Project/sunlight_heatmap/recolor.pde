PImage recolor(PImage iimage) {
  pushStyle();
  colorMode(RGB);
  PImage rImage = createImage(iimage.width, iimage.height, RGB);
  iimage.loadPixels();
  rImage.loadPixels();
  for (int i = 0; i < iimage.pixels.length; i++) {
    if (brightness(iimage.pixels[i]) > 220) {
      rImage.pixels[i] = color(0, brightness(iimage.pixels[i]), 0);
    } 
    else if (brightness(iimage.pixels[i]) > 150) {
      rImage.pixels[i] = color(brightness(iimage.pixels[i]), brightness(iimage.pixels[i]), 0);
    } 
    else { //if brightness is below 150
      rImage.pixels[i] = color(brightness(iimage.pixels[i]) + 50, 0, 0);
    }
  }
  rImage.updatePixels();
  popStyle();
  return rImage;
}
