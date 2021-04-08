float easeValue(float input, float end, float amt){
  float d = end - input;
  input += d * constrain(amt,0.0,1.0);
  if(abs(d) < .001){
    d = 0;
    input = end;
  }
  return input;
}

boolean hovered(float x, float y, float w, float h){
  if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h){
    return true;
  }
  else{
    return false;
  }
}
