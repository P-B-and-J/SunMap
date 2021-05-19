int axisz = 150;
PImage picker;
int type = 1;
int axisx=100;
int axisy=100;
boolean clickedInside=false;
boolean clickedInsideAxis=false;
boolean lastPressed=false;
color pickedColor;

int x=100;
int y=50;
int size=300;

void setup() {
  size(600, 600);
  colorMode(HSB);
  picker = createImage(size,size, RGB);
  deconstructColor(#05FF13);
}

void draw() {
  background(15);

  for(int i=0;i<size;i++){
    strokeWeight(1);
    if (type == 1) {
      stroke(color(map(i,0,size,0,255), 255,255));
    }
    else if (type == 2) {
      stroke(color(map(axisx, 0, size, 0, 255), map(axisy, 0, size, 0, 255), map(i,0,size,255,0)));
    }
    else if (type == 3) {
      stroke(color(map(axisx, 0, size, 0, 255), map(i,0,size,255,0), map(axisy, size, 0, 0, 255)));
    }
      line(x+size*1.1,i+y, x+size*1.2,i+y);
  }

  picker.loadPixels();
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      if (type == 1) {
        picker.set(i, j, color(map(axisz,0,size,0,255), map(i, 0, size, 0, 255), map(j, 0, size, 255, 0)));
      } else if (type == 2) {
        picker.set(i, j, color(map(i, 0, size, 0, 255), map(j, 0, size, 0, 255), map(axisz,0,size,255,0)));
      } else if (type == 3) {
        picker.set(i, j, color(map(i, 0, size, 0, 255), map(axisz,0,size,255,0), map(j, size, 0, 0, 255)));
      }
    }
  }
  picker.updatePixels();
  if (type == 1) {
    pickedColor= color(map(axisz,0,size,0,255), map(axisx, 0, size, 0, 255), map(axisy, 0, size, 255, 0));
  }
  else if (type == 2) {
    pickedColor= color(map(axisx, 0, size, 0, 255), map(axisy, 0, size, 0, 255), map(axisz,0,size,255,0));
  }
  else if (type == 3) {
    pickedColor=color(map(axisx, 0, size, 0, 255), map(axisz,0,size,255,0), map(axisy, size, 0, 0, 255));
  }
  //fill(255);
  //noStroke();
  //rect(48, 48, 403, 403);
  image(picker, x, y);
  if (mousePressed &&!lastPressed&& hovered(x, y,size,size)) {
    clickedInside=true;
  }
  if (mousePressed &&!lastPressed&& hovered(size*1.1+x, y, size*.1, y+size)) {
    clickedInsideAxis=true;
  }
  if (!mousePressed) {
    //cursor();
    clickedInside=false;
    clickedInsideAxis=false;
  }
  if (clickedInside) {
    //noCursor();
    axisx = constrain(mouseX, x, x+size)-x;
    axisy = constrain(mouseY, y, y+size)-y;
  }
  if(clickedInsideAxis){
    axisz=constrain(mouseY, y, y+size)-y;
  }
  lastPressed=mousePressed;
  pushStyle();
  fill(pickedColor);
  stroke(255);
  strokeWeight(2);
  circle(axisx+x, axisy+y, size/16);
  popStyle();
  
  strokeWeight(size/80);
  stroke(255);
  line(x+size*1.1,axisz+y, x+size*1.2,axisz+y);
  
  //for debugging
  noStroke();
  fill(pickedColor);
  rect(50,525,400,50);
  ///////////////////////
}

void deconstructColor(color c){
  if (type == 1) {
    axisz=int(map(hue(c),0,255,0,size));
    axisx=int(map(saturation(c),0,255,0,size));
    axisy=int(map(brightness(c),255,0,0,size));
  }
  else if (type == 2) {
    axisx=int(map(hue(c),0,255,0,size));
    axisy=int(map(saturation(c),0,255,0,size));
    axisz=int(map(brightness(c),255,0,0,size));
  }
  else if (type == 3) {
    axisx=int(map(hue(c),0,255,0,size));
    axisz=int(map(saturation(c),255,0,0,size));
    axisy=int(map(brightness(c),255,0,0,size));
    //println(axisx);println(axisy);println(axisz);
  }
}

boolean hovered(float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    return true;
  } else {
    return false;
  }
}
