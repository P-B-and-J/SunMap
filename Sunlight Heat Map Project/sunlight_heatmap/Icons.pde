void saveIcon(float X, float Y, float iconWidth, color primary){
  float iconHeight = 1.2 * iconWidth;
  pushStyle();
  stroke(primary);
  strokeWeight(iconWidth / 8);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  noFill();
  beginShape();
  vertex(X, Y);
  vertex(X + .7 * iconWidth, Y);
  vertex(X + iconWidth, Y + .3 * iconWidth);
  vertex(X + iconWidth, Y + iconHeight);
  vertex(X, Y + iconHeight);
  vertex(X, Y);
  endShape(CLOSE);
  
  strokeWeight(iconWidth / 10);
  line(X + iconWidth / 6, Y + .5 * iconHeight, X + 5 * (iconWidth / 6), Y + .5 * iconHeight);
  line(X + iconWidth / 6, Y + .65 * iconHeight, X + 5 * (iconWidth / 6), Y + .65 * iconHeight);
  line(X + iconWidth / 6, Y + .8 * iconHeight, X + 5 * (iconWidth / 6), Y + .8 * iconHeight);
  
  fill(primary);
  rect(X + iconWidth / 6, Y + iconWidth / 5, iconWidth / 2.25, iconWidth / 4.75);
  popStyle();
}

void exportIcon(float X, float Y, float iconWidth, color primary){
  float iconHeight = 1.2 * iconWidth;
  pushStyle();
  stroke(primary);
  strokeWeight(iconWidth / 8);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  noFill();
  beginShape();
  vertex(X + .7 * iconWidth, Y + .2 * iconHeight);
  vertex(X + .7 * iconWidth, Y);
  vertex(X, Y);
  vertex(X, Y + iconHeight);
  vertex(X + .7 * iconWidth, Y + iconHeight);
  vertex(X + .7 * iconWidth, Y + .8 * iconHeight);
  endShape();
  line(X + .3 * iconWidth, Y + .5 * iconHeight, X + iconWidth, Y + .5 * iconHeight);
  fill(primary);
  strokeJoin(MITER);
  triangle(X + .9 * iconWidth, Y + .4 * iconHeight, X + .9 * iconWidth, Y + .6 * iconHeight, X + iconWidth, Y + .5 * iconHeight);
  popStyle();
}
