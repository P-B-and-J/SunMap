/**
 * Load and Display 
 * 
 * Images can be loaded and displayed to the screen at their actual size
 * or any other size. 
 */

PImage img;  // Declare variable of type PImage

void setup() {
  size(832, 312);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("heatmaptest.png");  // Load the image into the program 
  
  image(img, width/2, 0, width/2, height);
  
  img.loadPixels();
  for (int i = 0; i < img.width * img.height; i++) {
    if (brightness(img.pixels[i]) > 220){
      img.pixels[i] = color(0, brightness(img.pixels[i]), 0);
    }
    else if (brightness(img.pixels[i]) > 150){
      img.pixels[i] = color(brightness(img.pixels[i]), brightness(img.pixels[i]), 0);
    }
    else { //if brightness is below 150
      img.pixels[i] = color(brightness(img.pixels[i]) + 50, 0, 0);
    }
  }
  img.updatePixels();
  
  image(img, 0, 0, width/2, height);
}

void draw() {
  // Displays the image at its actual size at point (0,0)
}
