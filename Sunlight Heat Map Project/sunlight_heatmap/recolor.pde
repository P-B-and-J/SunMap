
PImage recolor(PImage iimage) {
  PImage rImage = createImage(iimage.width, iimage.height,RGB);
  iimage.loadPixels();
  rImage.loadPixels();
  for (int i = 0; i < iimage.pixels.length; i++) {
    if (brightness(iimage.pixels[i]) > 220) {
      rImage.pixels[i] = bitShiftColor(0, int(brightness(iimage.pixels[i])), 0);
    } 
    else if (brightness(iimage.pixels[i]) > 150) {
      rImage.pixels[i] = bitShiftColor(int(brightness(iimage.pixels[i])), int(brightness(iimage.pixels[i])), 0);
    } 
    else { //if bitShiftBrightness is below 150
      rImage.pixels[i] = bitShiftColor(int(brightness(iimage.pixels[i]) + 50), 0, 0);
    }
  }
  rImage.updatePixels();
  return rImage;
}
int bitShiftColor(int r,int g,int b){
// Equivalent to "color argb = color(r, g, b, 255)" but faster 
// and doesn't require setting colorMode(RGB)
  return  (0xFF<<24) | (r<<16) | (g<<8) | b;
}
//int bitShiftBrightness(int argb){
//  int r = (argb >> 16) & 0xFF;  // Faster way of getting red(argb)
//  int g = (argb >> 8) & 0xFF;   // Faster way of getting green(argb)
//  int b = argb & 0xFF; 
//  return max(max(r,g),b);
//}
