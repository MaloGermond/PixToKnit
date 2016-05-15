import drop.*;

SDrop drop;
MyDropListener dropZone;

void initGUI() {
  drop = new SDrop(this);
  dropZone = new MyDropListener(width-110, 10, 100);
  drop.addDropListener(dropZone);
}

void drawGUI() {

  dropZone.draw();
  
}

void dropEvent(DropEvent theDropEvent) {
  println("please drop you image on the good area");
}


// a custom DropListener class.
class MyDropListener extends DropListener {

  color dropIn = color(255, 0, 0);
  color dropOut = color(100);
  color myColor = dropOut;
  int pos[] = new int[2];
  int size;

  MyDropListener(int _x, int _y, int _s) {
    // set a target rect for drop event.

    pos[0] = _x;
    pos[1] = _y;
    size = _s;
    setTargetRect( pos[0], pos[1], size, size );
  }

  void draw() {
    fill(myColor);
    rect( pos[0], pos[1], size, size );
  }

  // if a dragged object enters the target area.
  // dropEnter is called.
  void dropEnter() {
    myColor = dropIn;
  }

  // if a dragged object leaves the target area.
  // dropLeave is called.
  void dropLeave() {
    myColor = dropOut;
  }

  void dropEvent(DropEvent theDropEvent) {
    /*
  println("");
     println("isFile()\t"+theDropEvent.isFile());
     println("isImage()\t"+theDropEvent.isImage());
     println("isURL()\t"+theDropEvent.isURL());
     */

    // if the dropped object is an image, then 
    // load the image into our PImage.
    if (theDropEvent.isImage()) {
      println("### loading image ...");
      //file = theDropEvent.loadImage();
      String path[] = split(theDropEvent.filePath(), '/'); 
      //println(path[path.length-1]);
      file = loadImage(path[path.length-1]);
      //file.loadImage(path);
      //println("### image loaded ...");
      //println("file size:"+file.width+"/"+file.height);
      loadFile(10);
      //println("### file loaded ...");
    }
  }
}