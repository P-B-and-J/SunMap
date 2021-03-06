String folderPath = null;
boolean imagesLoaded = false;
ArrayList<PImage> images = new ArrayList<PImage>();
boolean imagesLayered = false;
PImage layeredImage;
PImage recoloredImage;
PImage firstImage;
float[] pixVal;
int imageHeight;
int imageWidth;
boolean layeredImageCreated = false;
int numImages = 0;
int counter=0;
float contrast = 0;
float brightness = 0;
color backgroundColor = #292929;
color topBarColor = #242424;  //for custom title bar mode
color sideBarColor;
float sideBarWidth;
float topBarHeight;
float buffer = 25;  //something's wrong with the toggle class; it works if this is set to 50 but moves too far if it's set to 40
float miniViewWidth = sideBarWidth - 2 * buffer;
float miniViewHeight = 9 * (sideBarWidth - 2 * buffer) / 16;
boolean layering = false;
boolean loading = false;
color accentBlue = #3A7793;
color accentRed = #F00F16;
int numInvalidImages = 0;
float loadingX, loadingY;
int loadingWidth, loadingHeight;
float labelSize = 20; //HARDCODED
int previewImage = 0;
PGraphics displayImages;
int scaleFactor = 1;
PGraphics sidebarGraphics;
editInt sidebarOffsetX = new editInt(0);
editInt sidebarOffsetY = new editInt(0);
int lastHeight=0;
int lastWidth=0;
float exportProgress=-1.0;
boolean stopExport=false;
String exportPath;
boolean exportButtonClicked=false;
long lastDrawMillis=0;
float fps=0.01;
boolean settingsPage=false;
long settingsPageMillis=0;
PGraphics settings;
color[][] colorPalette = {{#003393, #14FF00, #FFEA00}, {#FF0000, #FFFF00, #00FF00}};
int recolorID = 0;
int recolorThreshold1 = 100;
int recolorThreshold2 = 200;
int layerImagesResolution = 500;
float miniViewX, miniViewY;
color settingsTextColor = 255;


import javax.swing.*;
import javax.swing.JFileChooser.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import processing.awt.PSurfaceAWT.SmoothCanvas;
import javax.swing.JFrame;
import java.awt.Dimension;
import java.awt.*;

JFileChooser export;
FileNameExtensionFilter png, jpg, tif, tga;
Folder_Selector selectFolder;
Button processImagesButton;
Two_Step_Button newAnalysis;
Toggle colorModeToggle;
Toggle overlayToggle;
Slider brightnessSlider;
Slider contrastSlider;
Slider overlayStrength;
Button smallLeftButton;
Button smallRightButton;
Button bigLeftButton;
Button bigRightButton;
Progress_Bar loadingProgress;
Progress_Bar layeringProgress;
Button settingsButton;
Button exportButton;
Label errorBox;

void setup() {
  try {
    // Set System L&F
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
  } 
  catch (UnsupportedLookAndFeelException e) {
       // handle exception
  }
  catch (ClassNotFoundException e) {
     // handle exception
  }
  catch (InstantiationException e) {
     // handle exception
  }
  catch (IllegalAccessException e) {
     // handle exception
  }
  
  export = new JFileChooser();

  export.setFileSelectionMode(JFileChooser.FILES_ONLY);
  png = new FileNameExtensionFilter(".png", ".png");
  jpg = new FileNameExtensionFilter(".jpg", ".jpg");
  tif = new FileNameExtensionFilter(".tif", ".tif");
  tga = new FileNameExtensionFilter(".tga", ".tga");
  
  frameRate(120);
  colorMode(HSB);
  size(500, 500, JAVA2D);
  noSmooth();
  surface.setSize(2 * displayWidth / 4, 2 * displayHeight / 4);
  surface.setLocation(displayWidth / 12, displayHeight / 12);
  surface.setResizable(true);
  sideBarWidth = 0.21 * displayWidth;
  buffer = .017 * displayWidth;
  miniViewWidth = sideBarWidth - 2 * buffer;
  miniViewHeight = 9 * (sideBarWidth - 2 * buffer) / 16;
  topBarHeight = .075 * displayHeight;
  sidebarGraphics = createGraphics(int(sideBarWidth), displayHeight);
  sidebarGraphics.smooth(3);
  settings = createGraphics(displayWidth, displayHeight);
  settings.smooth(3);
  
  PImage sunMap = loadImage("icon.png");
  surface.setIcon(sunMap);
  
  SmoothCanvas sc = (SmoothCanvas) getSurface().getNative();
  JFrame jf = (JFrame) sc.getFrame();
  jf.setMinimumSize(new Dimension(2 * displayWidth / 3, 5 * displayHeight / 6));
  ((java.awt.Canvas) surface.getNative()).requestFocus();

  sideBarColor = color(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 10);
  
  background(backgroundColor);
  
  initializeInputs();
  BGYSel.toggle = true;
  
  String[] loadPath = loadStrings("path.txt");
  
  if(loadPath != null){
    folderPath = loadPath[0];
  }
}

void draw() {
  if ((focused||frameCount<5||loading||layering||(lastWidth!=width||lastHeight!=height)) && !settingsPage && !settingsButton.click){
    noStroke();
    fill(backgroundColor);
    rect(0, 0, width - sideBarWidth, height);
    fill(sideBarColor);
    rect(width - sideBarWidth, 0, sideBarWidth, height);
    sidebarGraphics.beginDraw();
    sidebarGraphics.background(color(255, 255, 255, 0));
    sidebarGraphics.endDraw();
    fill(backgroundColor);
    miniViewX = width - sideBarWidth + buffer;
    miniViewY = buffer;
    rect(miniViewX, miniViewY, miniViewWidth, miniViewHeight);
    
    settings.beginDraw();
    settings.background(color(255, 255, 255, 0));
    settings.endDraw();
    
    //println(frameRate);
    
    setCoords();
  
    if (selectFolder.browseButton.click) {                                  //folder selection >>>
      if(folderPath == null){
        selectFolder("Select a folder to process:", "folderSelected");
      }
      else{
        selectFolder("Select a folder to process:", "folderSelected", dataFile(folderPath));
      }
    }
    
    if(folderPath == null){      
      selectFolder.useFolderButton.visible = false;
      selectFolder.folderReadout = "No folder selected";
    }else{ 
      selectFolder.setText(folderPath);
      selectFolder.useFolderButton.visible = true;
    }
    
    if(selectFolder.useFolderButton.click && !layering){
      reset();
      if(!imagesLoaded){
        loading = true;
        counter = 0;
        numInvalidImages = 0;
        thread("loadImages");
      }
    }                                                                       //<<< folder selection
    
    if(loading && !imagesLoaded){                                           //Image loading >>>
      if(loadingProgress.text != selectFolder.folderReadout){
        loadingProgress.text = selectFolder.folderReadout;
        loadingProgress.textSize = selectFolder.textSize;
        loadingProgress.begin();
      }
      loadingProgress.visible = true;
      loadingProgress.speed = 1;
      selectFolder.useFolderButton.text = "Loading";
      selectFolder.useFolderButton.enabled = false;
    }
    else{
      loading=false;
      loadingProgress.speed = 10;
      if(loadingProgress.targetPos / loadingProgress.barWidth == 1){
        loadingProgress.visible = false;
      }
      selectFolder.useFolderButton.text = "Load Files";
      selectFolder.useFolderButton.enabled = true;
    }                                                                       //<<< Image loading
    
    if(imagesLoaded){                                                       //>>> Showing a preview image, enabling image processing
      processImagesButton.enabled = true;
      processImagesButton.primaryColor = accentBlue;
      processImagesButton.textColor = #FFFFFF;
      if(!layeredImageCreated){
        centeredImage(images.get(previewImage), buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);
      }
      centeredImage(images.get(previewImage), width - sideBarWidth + buffer, miniViewY, miniViewWidth, miniViewHeight);
      
      
      if(smallRightButton.click || bigRightButton.click){  //Image cycling still isn't working
        previewImage++;
      }
      if(previewImage > numImages - 1){
        previewImage = 0;
      }
      
      if(smallLeftButton.click || bigLeftButton.click){
        previewImage--;
      }
      if(previewImage < 0){
        previewImage = numImages - 1;
      }
      //println(previewImage);
    }
    else{
      
      processImagesButton.enabled = false;
      processImagesButton.primaryColor = #5D5D5D;
      processImagesButton.textColor = color(#FFFFFF, 150);
    }                                                                       //<<< Showing a preview image, enabling image processing
    
    if (processImagesButton.click && !imagesLayered) {                      //>>> Layering images
      layering = true;
      counter = 0;
      thread("layerImages");
    }
    
    if(layering && !imagesLayered){
      layeringProgress.visible = true;
    }
    else{
      layeringProgress.visible = false;
      layering = false;
    }                                                                       //<<< Layering images
    
    contrast = map(contrastSlider.value, 0, 10, 1.5, 8);                                        //>>> Setting contrast and brightness
    brightness = map(brightnessSlider.value, 0, 10, -50, 100);                               //<<<
  
    if (imagesLayered) {                                                    //>>> Creating an image from layered image array, advancing UI to next phase
      createImageFromArray();
      overlayToggle.visible = true;
      colorModeToggle.visible = true;
      brightnessSlider.visible = true;
      contrastSlider.visible = true;
      exportButton.visible = true;
      selectFolder.visible = false;
    }
    else{
      overlayToggle.visible = false;
      colorModeToggle.visible = false;
      brightnessSlider.visible = false;
      contrastSlider.visible = false;
      exportButton.visible = false;
      selectFolder.visible = true;
    }
    
    if(layeredImageCreated){
      processImagesButton.visible = false;
      newAnalysis.visible = true;
    }
    else{
      processImagesButton.visible = true;
      newAnalysis.visible = false;
    }                                                                       //<<< Creating an image from layered image array, advancing UI to next phase
  
    
    if (layeredImageCreated) {   //>>> Displaying images in their proper locations
      //noStroke();
      //fill(backgroundColor);
      //rect(0, 0, width - sideBarWidth, height);
      if(colorModeToggle.toggled){
        recoloredImage=recolor(layeredImage, colorPalette[recolorID][0], colorPalette[recolorID][1], colorPalette[recolorID][2], recolorThreshold1, recolorThreshold2);
        centeredImage(recoloredImage, buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);  //showing recolored image in main image viewer
      }
      else{
        centeredImage(layeredImage, buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);  //showing grayscale image in main area
      }
      
      
      if(overlayToggle.toggled){
        overlayStrength.visible = true;
        tint(255, map(overlayStrength.value, 0, 10, 100, 220));
        centeredImage(images.get(previewImage), buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);  //showing first image as an overlay
        noTint();
      } 
      else{
        overlayStrength.visible = false;
      }
      
      if(exportButton.click){
        export.addChoosableFileFilter(png);
        export.addChoosableFileFilter(jpg);
        export.addChoosableFileFilter(tif);
        export.addChoosableFileFilter(tga);
        export.setAcceptAllFileFilterUsed(false);
        export.setMultiSelectionEnabled(false);
        export.setDialogType(JFileChooser.SAVE_DIALOG); //not sure why this is necessary but it is a workaround for a bug in the JFileChooser class that results in export button text not being set properly
        export.setDialogTitle("Export Image");
        export.setApproveButtonText("Export");
        int returnVal = export.showSaveDialog(null);
        if(returnVal == JFileChooser.APPROVE_OPTION) {
          exportPath = export.getSelectedFile().getAbsolutePath() + export.getFileFilter().getDescription();
          exportButtonClicked = true;
        }
        else{
          exportPath = null;
        }
        //selectOutput("choose where to save", "exportFileSelected", dataFile(folderPath+"/export.png"));
      }
    }       //<<< Displaying images in their proper locations
    
    //println(exportPath);
    if(exportPath!=null&&exportButtonClicked){
        thread("exportThread");
        exportButtonClicked=false;
    }
      
    if(newAnalysis.confirmed){                                                           // Reset vvv
      reset();
    }
    
    setVisibility();

    image(sidebarGraphics,width-sideBarWidth,0);
  }
  
  showSettings();
  
  lastWidth = width;
  lastHeight = height;
  fps=1000.0/(millis()-lastDrawMillis);
  lastDrawMillis=millis();  
}

class editInt{
  int val;
  editInt(int v){
    val=v;
  }
}

void reset(){
  imagesLoaded = false;
  imagesLayered = false;
  layeredImageCreated = false;
  newAnalysis.confirmButton.click = false;
  images.clear();
  errorBox.labelText = "";
  colorModeToggle.toggled = false;
  overlayToggle.toggled = false;
  overlayStrength.visible = false;
}
