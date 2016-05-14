import drop.*;

SDrop drop;

void initGUI(){
  drop = new SDrop(this);
}

void dropEvent(DropEvent theDropEvent) {
  println("");
  println("isFile()\t"+theDropEvent.isFile());
  println("isImage()\t"+theDropEvent.isImage());
  println("isURL()\t"+theDropEvent.isURL());
  
  // if the dropped object is an image, then 
  // load the image into our PImage.
  if(theDropEvent.isImage()) {
    println("### loading image ...");
    //file = theDropEvent.loadImage();
    String path[] = split(theDropEvent.filePath(),'/'); 
    //println(path[path.length-1]);
    file = loadImage(path[path.length-1]);
    //file.loadImage(path);
    println("### image loaded ...");
    //println("file size:"+file.width+"/"+file.height);
    loadFile(10);
    println("### file loaded ...");
  }
}