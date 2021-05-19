class Color_Picker {
  private PImage picker;
  private int type;
  private int axisx;
  private int axisy;
  private int axisz;
  private boolean clickedInside;
  private boolean clickedInsideAxis;
  private boolean lastPressed;
  private color pickedColor;
  int x=100;
  int y=50;
  private int size;
  private PGraphics graphics;

  Color_Picker(int _type, color defaultColor, int _size) {
    graphics=g;
    size=_size;
    deconstructColor(defaultColor);
    pickedColor = defaultColor;
    type=_type;
    picker = createImage(size, size, RGB);
    clickedInside = false;
    clickedInsideAxis = false;
    lastPressed = false;
  }

  void drawTo(PGraphics _graphics, editInt _offsetX, editInt _offsetY) {
    graphics=_graphics;
    offsetX=_offsetX;
    offsetY=_offsetY;   
    useG=false;
  }

  color getPickedColor() {
    return pickedColor;
  }

  void setPickedColor(color c) {
    deconstructColor(c);
  }

  void display(int _x, int _y) {
    x=_x;
    y=_y;
    displayAxisXY();
    displayAxisZ();
    handleInteraction();
  }

  private void handleInteraction() {
    if (mousePressed &&!lastPressed&& hovered(x, y, size, size)) {
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
    if (clickedInsideAxis) {
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
    line(x+size*1.1, axisz+y, x+size*1.2, axisz+y);
  }

  private void displayAxisZ() {
    for (int i=0; i<size; i++) {
      strokeWeight(1);
      if (type == 1) {
        stroke(color(map(i, 0, size, 0, 255), 255, 255));
      } else if (type == 2) {
        stroke(color(map(axisx, 0, size, 0, 255), map(axisy, 0, size, 0, 255), map(i, 0, size, 255, 0)));
      } else if (type == 3) {
        stroke(color(map(axisx, 0, size, 0, 255), map(i, 0, size, 255, 0), map(axisy, size, 0, 0, 255)));
      }
      line(x+size*1.1, i+y, x+size*1.2, i+y);
    }
  }

  private void displayAxisXY() {
    picker.loadPixels();
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (type == 1) {
          picker.set(i, j, color(map(axisz, 0, size, 0, 255), map(i, 0, size, 0, 255), map(j, 0, size, 255, 0)));
        } else if (type == 2) {
          picker.set(i, j, color(map(i, 0, size, 0, 255), map(j, 0, size, 0, 255), map(axisz, 0, size, 255, 0)));
        } else if (type == 3) {
          picker.set(i, j, color(map(i, 0, size, 0, 255), map(axisz, 0, size, 255, 0), map(j, size, 0, 0, 255)));
        }
      }
    }
    picker.updatePixels();
    if (type == 1) {
      pickedColor= color(map(axisz, 0, size, 0, 255), map(axisx, 0, size, 0, 255), map(axisy, 0, size, 255, 0));
    } else if (type == 2) {
      pickedColor= color(map(axisx, 0, size, 0, 255), map(axisy, 0, size, 0, 255), map(axisz, 0, size, 255, 0));
    } else if (type == 3) {
      pickedColor=color(map(axisx, 0, size, 0, 255), map(axisz, 0, size, 255, 0), map(axisy, size, 0, 0, 255));
    }
    image(picker, x, y);
  }

  private void deconstructColor(color c) {
    if (type == 1) {
      axisz=int(map(hue(c), 0, 255, 0, size));
      axisx=int(map(saturation(c), 0, 255, 0, size));
      axisy=int(map(brightness(c), 255, 0, 0, size));
    } else if (type == 2) {
      axisx=int(map(hue(c), 0, 255, 0, size));
      axisy=int(map(saturation(c), 0, 255, 0, size));
      axisz=int(map(brightness(c), 255, 0, 0, size));
    } else if (type == 3) {
      axisx=int(map(hue(c), 0, 255, 0, size));
      axisz=int(map(saturation(c), 255, 0, 0, size));
      axisy=int(map(brightness(c), 255, 0, 0, size));
    }
  }

  private boolean hovered(float x, float y, float w, float h) {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    } else {
      return false;
    }
  }
};

void setup() {
  size(600, 600);
  colorMode(HSB);
}

void draw() {
  background(15);




  //for debugging
  noStroke();
  fill(pickedColor);
  rect(50, 525, 400, 50);
  ///////////////////////
}
