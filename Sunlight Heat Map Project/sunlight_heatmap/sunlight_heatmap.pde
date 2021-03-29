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
float sideBarWidth = 450;
float topBarHeight = 70;
float buffer = 50;  //something's wrong with the toggle class; it works if this is set to 50 but moves too far if it's set to 40
float miniViewWidth = sideBarWidth - 2 * buffer;
float miniViewHeight = 9 * (sideBarWidth - 2 * buffer) / 16;
boolean layering = false;
boolean loading = false;
color accentBlue = #3A7793;
color accentRed = #F00F16;
int numInvalidImages = 0;
float loadingX, loadingY;
int loadingWidth, loadingHeight;
float labelSize = 20;
int previewImage = 0;
PGraphics displayImages;
int scaleFactor = 1;
PGraphics sidebarGraphics;
editInt sidebarOffsetX = new editInt(0);
editInt sidebarOffsetY = new editInt(0);

Folder_Selector selectFolder;
Button processImagesButton;
Two_Step_Button newAnalysis;
Toggle colorModeToggle;
Toggle overlayToggle;
Slider brightnessSlider;
Slider contrastSlider;
Button smallLeftButton;
Button smallRightButton;
Button bigLeftButton;
Button bigRightButton;
Progress_Bar loadingProgress;
Progress_Bar layeringProgress;
Button saveButton;
Button exportButton;

void setup() {
  frameRate(120);
  colorMode(HSB);
  size(1920, 1080, JAVA2D);
  noSmooth();
  surface.setSize(2 * displayWidth / 4, 2 * displayHeight / 4);
  surface.setLocation(displayWidth / 12, displayHeight / 12);
  surface.setResizable(true);
  sidebarGraphics=createGraphics(int(sideBarWidth), displayHeight);
  sidebarGraphics.smooth(3);
  //sideBarWidth = 0.16 * displayWidth;
  //buffer = .02 * displayWidth;
  //miniViewWidth = sideBarWidth - 2 * buffer;
  //miniViewHeight = 9 * (sideBarWidth - 2 * buffer) / 16;

  sideBarColor = color(hue(backgroundColor), saturation(backgroundColor), brightness(backgroundColor) + 10);
  
  background(backgroundColor);
  
  initializeInputs();
  
  String[] loadPath = loadStrings("path.txt");
  
  if(loadPath != null){
    folderPath = loadPath[0];
  }
}

void draw() {
  if(focused||frameCount<5||loading||layering){
    noStroke();
    fill(backgroundColor);
    rect(0, 0, width - sideBarWidth, height);
    fill(sideBarColor);
    rect(width - sideBarWidth, 0, sideBarWidth, height);
    sidebarGraphics.beginDraw();
    sidebarGraphics.background(color(255,0));
    sidebarGraphics.endDraw();
    fill(backgroundColor);
    rect(width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
    
    println(frameRate);
    
    setVisibility();
    setCoords();
  
    if (selectFolder.browseButton.click) {                                  //folder selection >>>
      if(folderPath == null){
        selectFolder("Select a folder to process:", "folderSelected");
      }
      else{
        selectFolder("Select a folder to process:", "folderSelected", dataFile(folderPath));
      }
    }
    
    if(folderPath != null){
      String[] savePath = {folderPath};
      saveStrings("path.txt", savePath);
      selectFolder.setText(folderPath);
      selectFolder.useFolderButton.visible = true;
    }
    else{
      selectFolder.useFolderButton.visible = false;
      selectFolder.folderReadout = "No folder selected";
    }
    
    if(selectFolder.useFolderButton.click){
      reset();
      if(!imagesLoaded){
        loading = true;
        counter = 0;
        numInvalidImages = 0;
      }
    }                                                                       //<<< folder selection
    
    if(loading && !imagesLoaded){                                           //Image loading >>>
      loadImages();
      if(loadingProgress.text != selectFolder.folderReadout){
        loadingProgress.text = selectFolder.folderReadout;
        loadingProgress.textSize = selectFolder.textSize;
        loadingProgress.begin();
      }
      loadingProgress.visible = true;
      //selectFolder.useFolderButton.enabled = false;
    }
    else{
      loading=false;
      loadingProgress.visible = false;
      selectFolder.useFolderButton.enabled = true;
    }                                                                       //<<< Image loading
    
    if(imagesLoaded){                                                       //>>> Showing a preview image, enabling image processing
      processImagesButton.enabled = true;
      processImagesButton.primaryColor = accentBlue;
      processImagesButton.textColor = #FFFFFF;
      if(!layeredImageCreated){
        centeredImage(images.get(previewImage), buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);
      }
      centeredImage(images.get(previewImage), width - sideBarWidth + buffer, buffer, miniViewWidth, miniViewHeight);
      
      
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
    }
    
    if(layering && !imagesLayered){
      layeringProgress.visible = true;
      layerImages();
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
      selectFolder.visible = false;
    }
    else{
      overlayToggle.visible = false;
      colorModeToggle.visible = false;
      brightnessSlider.visible = false;
      contrastSlider.visible = false;
      //contrastSlider.visible = true; 
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
        recolor();
        centeredImage(recoloredImage, buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);  //showing recolored image in main image viewer
      }
      else{
        centeredImage(layeredImage, buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);  //showing grayscale image in main area
      }
      
      
      if(overlayToggle.toggled){
        tint(255, 160);
        centeredImage(images.get(previewImage), buffer, topBarHeight + buffer, width - 2 * buffer - sideBarWidth, height - 2 * buffer - topBarHeight);  //showing first image as an overlay
        noTint();
      } 
    }                                                                                    //<<< Displaying images in their proper locations
    
    if(newAnalysis.confirmed){                                                           // Reset vvv
      reset();
    }
    image(sidebarGraphics,width-sideBarWidth,0);
  }
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
}
