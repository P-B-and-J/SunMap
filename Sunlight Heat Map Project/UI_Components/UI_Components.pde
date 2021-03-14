/*  Slider(X position, Y position, slider length)
    Variables: radius, weight, primaryColor, secondaryColor, textColor, value, min, max
*/

color backgroundColor = #292929;

Slider testSlider;
Button testButton;
Toggle testToggle;

void setup() {
  frameRate(60);
  surface.setSize(3*displayWidth/4, 3*displayHeight/4);
  surface.setLocation(displayWidth/8, displayHeight/8);
  surface.setResizable(true);
  
  testSlider = new Slider(100, 300, 300);
 // testSlider.primaryColor = #D33783;
  
  testButton = new Button(100, 150, 300, 75);
  testButton.textSize = 20;
  testButton.text = "Process Images";
  
  testToggle = new Toggle(100, 375, 100);
  //testToggle.fillColorOn = #D33783;;
 // testToggle.borderColorOn = #D33783;
}

void draw() {
  background(backgroundColor);
  testSlider.X = width - 400;
  testButton.X = width - 400;
  testToggle.X = width - 400;
  noStroke();
  colorMode(HSB);
  fill(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 25);
  rect(width - 450, 0, 450, height);
  testSlider.display();
  testButton.display();
  testToggle.display();
}
