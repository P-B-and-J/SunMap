void recolor(){
  pushStyle();
  colorMode(RGB);
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
  popStyle();
}
