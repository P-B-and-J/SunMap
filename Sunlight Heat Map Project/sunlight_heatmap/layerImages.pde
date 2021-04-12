void layerImages() {
  if (counter<numImages) {
    PImage tempImage = images.get(counter).get();
    tempImage.resize(layerImagesResolution, 0);
    imageWidth = tempImage.width;
    imageHeight = tempImage.height;
    if (counter == 0) {
      pixVal = new float[imageWidth * imageHeight];
    }
    counter++;
    tempImage.loadPixels();
    for (int i = 0; i < pixVal.length; i++) {
      pixVal[i] = pixVal[i] + 1.0 * bitShiftBrightness(tempImage.pixels[i]) / numImages;
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

void exportThread() {
  float Econtrast=contrast;
  float Ebrightness=brightness;
  exportProgress=0.0;
  ArrayList<PImage> EImages=new ArrayList<PImage>(images.size());
  if (!stopExport) {
    for (PImage im : images) {
      EImages.add(im);
    }
  }
  int ECounter=0;
  int ENumImages=EImages.size();
  int EImageWidth = EImages.get(0).width;
  int EImageHeight = EImages.get(0).height;
  float[] EPixVal = new float[EImageWidth * EImageHeight];
  while (ECounter<ENumImages&&!stopExport) {
    PImage tImage = EImages.get(ECounter);
    //tImage.resize(EResolution, 0);
    //imageWidth = tempImage.width;
    //imageHeight = tempImage.height;
    tImage.loadPixels();
    for (int i = 0; i < EPixVal.length; i++) {
      EPixVal[i] = EPixVal[i] + 1.0 * brightness(tImage.pixels[i]) / ENumImages;
    }
    ECounter++;
    exportProgress=.5*ECounter/ENumImages;
  }
  if (!stopExport) {
    exportProgress=.75;
    PImage ELayeredImage = createImage(EImageWidth, EImageHeight, RGB);
    ELayeredImage.loadPixels();
    for (int i = 0; i < EPixVal.length; i++) {
      ELayeredImage.pixels[i] = bitShiftColor(int((EPixVal[i]-127) * Econtrast + 127 + Ebrightness));
    }
    ELayeredImage.updatePixels();
    if (!overlayToggle.toggled) {
      if (colorModeToggle.toggled) {
        exportProgress=.90;
        PImage ErecoloredImage=recolor(ELayeredImage, recolor1, recolor2, recolor3, recolorThreshold1, recolorThreshold2);
        exportProgress=.99;
        ErecoloredImage.save(exportPath);        
        launch(exportPath);
      } else {
        exportProgress=.99;
        ELayeredImage.save(exportPath);
        launch(exportPath);
      }
    } else {
      //TODO: overlay yay
    }
  }
  exportProgress=-1.0;
  stopExport=false;
  exportPath=null;
}

int bitShiftColor(int b) {
  b=constrain(b, 0, 255);
  // Equivalent to "color argb = color(b)" but faster 
  // and doesn't require setting colorMode(RGB)
  return  (0xFF<<24) | (b<<16) | (b<<8) | b;
}
