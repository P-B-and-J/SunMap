void layerImages() {
  if (counter<numImages) {
    PImage tempImage = images.get(counter);
    counter++;
    tempImage.loadPixels();
    for (int i = 0; i < pixVal.length; i++) {
      pixVal[i] = pixVal[i] + 1.0 * brightness(tempImage.pixels[i]) / numImages;
    }
  } else {
    imagesLayered = true;
    counter=0;
  }
}

void createImageFromArray() {
  layeredImage = createImage(imageWidth, imageHeight, RGB);
  layeredImage.loadPixels();
  for (int i = 0; i < pixVal.length; i++) {
    layeredImage.pixels[i] = color((pixVal[i]-127) * contrast + 127 + brightness);
  }
  layeredImage.updatePixels();
  layeredImageCreated = true;
  counter=0;
}