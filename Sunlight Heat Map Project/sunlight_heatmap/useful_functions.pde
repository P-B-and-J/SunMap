float easeValue(float val, float end, float amt){
  float d = end - val;
  val += d * constrain(amt,0.0,1.0);
  if(abs(d) < .001){
    d = 0;
    val = end;
  }
  return val;
}

boolean hovered(float x, float y, float w, float h){
  if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h){
    return true;
  }
  else{
    return false;
  }
}
