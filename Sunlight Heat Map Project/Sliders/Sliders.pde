/*  Slider(X position, Y position, slider length)
    Variables: radius, weight, primaryColor, secondaryColor, textColor, value, min, max
*/


Slider testSlider;

void setup() {
  colorMode(HSB);
  size(500, 500);
  testSlider = new Slider(100, 250, 300);
  testSlider.primaryColor = color(#D33783);
}

void draw() {
  background(color(#292929));
  testSlider.display();
}
