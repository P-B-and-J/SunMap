class editInt {
  int val;
  editInt(int v) {
    val=v;
  }
}
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
  private color lastColor;
  int x=0;
  int y=0;
  private int size;
  private PGraphics graphics;
  private editInt offsetX;
  private editInt offsetY;
  private boolean useG;

  Color_Picker(int _type, color defaultColor, int _size) {
    graphics=g;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
    useG=true;
    size=_size;
    type=_type;
    lastColor=defaultColor;
    setPickedColor(defaultColor);
    pickedColor = defaultColor;
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

  boolean colorChanged() {
    boolean ret = (pickedColor != lastColor);
    lastColor = pickedColor;
    return ret;
  }

  void display(int _x, int _y) {
    x=_x;
    y=_y;
    if (!useG) {
      graphics.beginDraw();
    }
    graphics.pushStyle();
    graphics.colorMode(HSB);
    displayAxisXY();
    displayAxisZ();
    handleInteraction();
    graphics.popStyle();
    if (!useG) {
      graphics.endDraw();
    }
  }

  private void handleInteraction() {
    if (mousePressed &&!lastPressed && hovered(x, y, size, size)) {
      clickedInside=true;
    }
    if (mousePressed &&!lastPressed && hovered(size*1.1+x, y, size*.1, y+size)) {
      clickedInsideAxis=true;
    }
    if (!mousePressed) {
      //cursor();
      clickedInside=false;
      clickedInsideAxis=false;
    }
    if (clickedInside) {
      //noCursor();
      axisx = constrain(mouseX-offsetX.val, x, x+size)-x;
      axisy = constrain(mouseY-offsetY.val, y, y+size)-y;
    }
    if (clickedInsideAxis) {
      axisz=constrain(mouseY-offsetX.val, y, y+size)-y;
    }
    if (clickedInside||clickedInsideAxis) {
      if (type == 1) {
        pickedColor= color(map(axisz, 0, size, 0, 255), map(axisx, 0, size, 0, 255), map(axisy, 0, size, 255, 0));
      } else if (type == 2) {
        pickedColor= color(map(axisx, 0, size, 0, 255), map(axisy, 0, size, 0, 255), map(axisz, 0, size, 255, 0));
      } else if (type == 3) {
        pickedColor=color(map(axisx, 0, size, 0, 255), map(axisz, 0, size, 255, 0), map(axisy, size, 0, 0, 255));
      }
    }
    lastPressed=mousePressed;
    graphics.pushStyle();
    graphics.fill(pickedColor);
    graphics.stroke(255);
    graphics.strokeWeight(2);
    graphics.circle(axisx+x, axisy+y, size/16);
    graphics.popStyle();

    graphics.strokeWeight(size/80);
    graphics.stroke(255);
    graphics.line(x+size*1.1, axisz+y, x+size*1.2, axisz+y);
  }

  private void displayAxisZ() {
    for (int i=0; i<size; i++) {
      graphics.strokeWeight(1);
      if (type == 1) {
        graphics.stroke(color(map(i, 0, size, 0, 255), 255, 255));
      } else if (type == 2) {
        graphics.stroke(color(map(axisx, 0, size, 0, 255), map(axisy, 0, size, 0, 255), map(i, 0, size, 255, 0)));
      } else if (type == 3) {
        graphics.stroke(color(map(axisx, 0, size, 0, 255), map(i, 0, size, 255, 0), map(axisy, size, 0, 0, 255)));
      }
      graphics.line(x+size*1.1, i+y, x+size*1.2, i+y);
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
    graphics.image(picker, x, y);
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
    if (mouseX-offsetX.val > x && mouseX-offsetX.val < x + w && mouseY-offsetY.val > y && mouseY-offsetY.val < y + h) {
      return true;
    } else {
      return false;
    }
  }
};

Color_Picker myCP;

void setup() {
  size(600, 600);
  myCP=new Color_Picker(1, #AA11FF, 300);
}

void draw() {
  background(15);
  myCP.display(200, 200);
  if (myCP.colorChanged()) {
    println(hex(myCP.getPickedColor()));
  }
}
