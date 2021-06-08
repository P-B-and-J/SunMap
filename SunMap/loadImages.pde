void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    //println("User selected " + selection.getAbsolutePath());
    File file = new File(selection.getAbsolutePath());
    if (file.isDirectory()) {
      folderPath = selection.getAbsolutePath();
      String[] savePath = {folderPath};
      saveStrings("path.txt", savePath);
    }else{
      //println("error, bad path");
      errorBox.labelText = "The folder you selected does not exist. The most recent folder will be used instead.";
    }
  }
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  }
  return null;
}

String[] filenames;
void loadImages() {
  filenames = listFileNames(folderPath);
  if (filenames != null) {
    numImages = filenames.length;
    while(counter < numImages){
      String fileName = filenames[counter];
      File file = new File(folderPath + "/" + fileName);
      if(file.isDirectory()){
        numInvalidImages++;
        String[] fileNamesTemp = listFileNames(folderPath + "/" + fileName);
        for(int i = 0; i < fileNamesTemp.length; i++){
          filenames = append(filenames, fileName + "/" + fileNamesTemp[i]);
        }
        numImages = filenames.length;
      }
      else{
        PImage tempImage = loadImage(folderPath + "/" + fileName);
        if (tempImage != null) {
          tempImage.resize(layerImagesResolution, 0);
          images.add(tempImage);
          if (firstImage == null) {
            firstImage = tempImage;
          }
        }
        else{
          numInvalidImages++;
        }
      }
      counter++;
    }
    
    numImages-=numInvalidImages; 
    counter-=numInvalidImages;
    //imageWidth = images.get(0).width;
    //imageHeight = images.get(0).height;
    //pixVal = new float[imageWidth * imageHeight];
    if(images.size()>0){
      imagesLoaded = true;
    }else{
      loading = false;
      loadingProgress.targetPos=0;
      selectFolder.useFolderButton.click = false;
      errorBox.labelText = "The folder must contain at least one image.";
      counter=10;
      numImages=10;
    }
  }
}
