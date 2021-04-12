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


void loadImages() {
  String[] filenames = listFileNames(folderPath);
  if (filenames!=null) {
    numImages=filenames.length;
    while(counter<numImages){
      String fileName=filenames[counter];
      PImage tempImage = loadImage(folderPath + "/" + fileName);
      if (tempImage!=null) {
        images.add(tempImage);
        if (firstImage == null) {
          firstImage = tempImage;
        }
      }
      else{
        numInvalidImages++;
      }
      counter++;
    }
    
    numImages-=numInvalidImages; 
    counter-=numInvalidImages;
    //imageWidth = images.get(0).width;
    //imageHeight = images.get(0).height;
    //pixVal = new float[imageWidth * imageHeight];
    imagesLoaded = true;
}
}
