PImage recolor(PImage iimage, int c1, int c2, int c3, int t12, int t23) {
  PImage rImage = createImage(iimage.width, iimage.height,RGB);
  iimage.loadPixels();
  rImage.loadPixels();
  for (int i = 0; i < iimage.pixels.length; i++) {
    if (bitShiftBrightness(iimage.pixels[i]) > t23) {
      rImage.pixels[i] = bsColorBright(c3,bitShiftBrightness(iimage.pixels[i]));
//      bitShiftColor(0, int(bitShiftBrightness(iimage.pixels[i])), 0);  //c3
    } 
    else if (bitShiftBrightness(iimage.pixels[i]) > t12) {
      rImage.pixels[i] = bsColorBright(c2,bitShiftBrightness(iimage.pixels[i]));
      //      rImage.pixels[i] = bitShiftColor(int(bitShiftBrightness(iimage.pixels[i])), int(bitShiftBrightness(iimage.pixels[i])), 0);  //c2
    } 
    else { //if bitShiftbitShiftBrightness is below t12
      rImage.pixels[i] = bsColorBright(c1,bitShiftBrightness(iimage.pixels[i])+100);
//      rImage.pixels[i] = bitShiftColor(int(bitShiftBrightness(iimage.pixels[i]) + 50), 0, 0); //c1
    }
  }
  rImage.updatePixels();
  return rImage;
}
int bsColorBright(int c,int bright){
  return bitShiftColor(bsRed(c)*bright/255,bsGreen(c)*bright/255,bsBlue(c)*bright/255);
}
int bitShiftColor(int r,int g,int b){
// Equivalent to "color argb = color(r, g, b, 255)" but faster 
// and doesn't require setting colorMode(RGB)
  return  (0xFF<<24) | (r<<16) | (g<<8) | b;
}
int bitShiftBrightness(int argb){
  int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
  int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
  int b = argb & 0xFF; 
  return max(max(r,g),b);
}

int bsRed(int argb){
  int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
  //int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
  //int b = argb & 0xFF; 
  return r;
}
int bsGreen(int argb){
  //int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
  int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
  //int b = argb & 0xFF; 
  return g;
}
int bsBlue(int argb){
  //int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
  //int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
  int b = argb & 0xFF; 
  return b;
}
