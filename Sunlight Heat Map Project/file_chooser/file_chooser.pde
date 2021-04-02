import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Stage;
import javafx.stage.Stage.*;
import processing.javafx.PSurfaceFX;
Stage stage;
void setup() {
  size(500, 500, FX2D);
  background(0);
}
void draw() {
  FileChooser fileChooser = new FileChooser();
  fileChooser.setTitle("Open Resource File");
  fileChooser.getExtensionFilters().addAll(
    new ExtensionFilter("PNG Image", "*.png"), 
    new ExtensionFilter("JPG Image", "*.jpg"));
  File selectedFile = fileChooser.showOpenDialog(stage);
  println("---");
  if (selectedFile != null) {
    println(selectedFile.getAbsolutePath());
  }
}
