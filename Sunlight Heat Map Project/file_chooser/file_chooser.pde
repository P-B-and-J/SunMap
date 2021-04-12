import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Stage;
import javafx.stage.Stage.*;
import processing.javafx.PSurfaceFX;
Stage stage;
void setup() {
  size(500, 500, JAVA2D);
  background(0);
}
void draw() {
  
  FileChooser fileChooser = new FileChooser();
  fileChooser.setTitle("Open Resource File");
  fileChooser.getExtensionFilters().addAll(
    new ExtensionFilter("PNG", "*.png"), 
    new ExtensionFilter("JPG", "*.jpg"),
    new ExtensionFilter("TIFF", "*.tif"),
    new ExtensionFilter("PDF", "*.pdf"));
  File selectedFile = fileChooser.showSaveDialog(stage);
  println("---");
  if (selectedFile != null) {
    println(selectedFile.getAbsolutePath());
  }
}
