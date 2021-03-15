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
