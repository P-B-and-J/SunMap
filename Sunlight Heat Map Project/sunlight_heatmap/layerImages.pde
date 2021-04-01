void layerImages(int resolution) {
  if (counter<numImages) {
    PImage tempImage = images.get(counter).get();
    tempImage.resize(resolution, 0);
    imageWidth = tempImage.width;
    imageHeight = tempImage.height;
    if (counter == 0) {
      pixVal = new float[imageWidth * imageHeight];
    }
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

void exportThread() {
  float Econtrast=contrast;
  float Ebrightness=brightness;
  exportProgress=0.0;
  ArrayList<PImage> EImages=new ArrayList<PImage>(images.size());
  for (PImage im : images) {
    EImages.add(im);
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
    ECounter++;
    tImage.loadPixels();
    for (int i = 0; i < pixVal.length; i++) {
      EPixVal[i] = EPixVal[i] + 1.0 * brightness(tImage.pixels[i]) / ENumImages;
    }

    ECounter++;
    exportProgress=1.0*ECounter/ENumImages;
  }

  PImage ELayeredImage = createImage(EImageWidth, EImageHeight, RGB);
  ELayeredImage.loadPixels();
  println(contrast);
  println(Econtrast);
  println(brightness);
  println(Ebrightness);
  for (int i = 0; i < pixVal.length; i++) {
    ELayeredImage.pixels[i] = color((EPixVal[i]-127) * Econtrast + 127 + Ebrightness);
  }
  ELayeredImage.updatePixels();

  if (!overlayToggle.toggled) {
    if (colorModeToggle.toggled) {
      PImage ErecoloredImage=recolor(ELayeredImage);
      ErecoloredImage.save("test_photo_recolored-#####.jpg");
    } else {
      ELayeredImage.save("test_photo_grayscale-#####.jpg");
    }
  } else {
    //overlay yay
  }

  exportProgress=-1.0;
  stopExport=false;
}
