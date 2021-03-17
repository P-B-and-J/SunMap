void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    //println("User selected " + selection.getAbsolutePath());
    folderPath = selection.getAbsolutePath();
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
    for (String fileName : filenames) {
      PImage tempImage = loadImage(folderPath + "/" + fileName);
      if (tempImage!=null) {
        tempImage.resize(500, 0);
        images.add(tempImage);
        if (firstImage == null) {
          firstImage = tempImage;
        }
        numImages++;
      }
    }
    imageWidth = images.get(0).width;
    imageHeight = images.get(0).height;
    pixVal = new float[imageWidth * imageHeight];
    imagesLoaded = true;
    counter = 0;
  }
}
