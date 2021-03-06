class Label {
  float x, y, labelWidth, labelHeight;
  String labelText = "";
  PFont font;
  int textSize = 10;
  color textColor = #FFFFFF;
  editInt offsetX;
  editInt offsetY;
  PGraphics drawTo;
  boolean useG = false;
  
  Label(float _x, float _y, float _w, float _h){
    x = _x;
    y = _y;
    labelWidth = _w;
    labelHeight = _h;
    drawTo=g;
    useG=true;
    offsetX=new editInt(0);
    offsetY=new editInt(0);
    //font = createFont("SansSerif.italic", textSize);
  }
  Label(float _x, float _y, float _w, float _h, PGraphics _drawTo, editInt _offsetX, editInt _offsetY){
    this(_x,_y,_w,_h);
    drawTo=_drawTo;
    offsetX=_offsetX;
    offsetY=_offsetY;
    useG=false;
  }
  
  void setFont(String fontName, int _textSize){ 
    textSize = _textSize;
    font = createFont(fontName, textSize);
  }
  
  void display(){
    if(!useG){
      drawTo.beginDraw();
    }
    drawTo.pushStyle();
    drawTo.noStroke();
    drawTo.textFont(font);
    drawTo.textSize(textSize);
    drawTo.fill(textColor);
    drawTo.text(labelText, int(x), int(y), int(labelWidth), int(labelHeight));
    drawTo.popStyle();
    
    if(!useG){
      drawTo.endDraw();
    }
  }
}
