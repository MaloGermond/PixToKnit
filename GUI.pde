import controlP5.*;
import drop.*;

ControlP5 cp5;
SDrop drop;
MyDropListener dropZone;

void initGUI() {
  cp5 = new ControlP5(this);
  drop = new SDrop(this);
  
  
  dropZone = new MyDropListener(width-110, 10, 100);
  drop.addDropListener(dropZone);
  
  cp5.addSlider("sliderZoom")
     .setPosition(width-110, 120)
     .setSize(100,10)
     .setRange(10,20)
     .setSliderMode(Slider.FLEXIBLE)
     //.setColor(110,212,186)
     ;
}

void drawGUI() {

  dropZone.draw();
}


void sliderZoom(int _zoom) {
  zoom = _zoom;
  if(file!=null){
  loadFile(zoom);
  }
  //println("the zoom is equal to  "+zoom);
}

void dropEvent(DropEvent theDropEvent) {
  println("please drop you image on the good area");
}


// a custom DropListener class.
class MyDropListener extends DropListener {

  color dropIn = color(#15BAEA);
  color dropOut = color(200);
  color myColor = dropOut;
  int pos[] = new int[2];
  int size;
  boolean active = false;

  MyDropListener(int _x, int _y, int _s) {
    // set a target rect for drop event.

    pos[0] = _x;
    pos[1] = _y;
    size = _s;
    setTargetRect( pos[0], pos[1], size, size );
  }

  void draw() {
    stroke(0);

    if (file == null) {
      fill(myColor);
      rect( pos[0], pos[1], size, size );
      if (active) {
        fill(0);
        text("drop your .png", pos[0]+3, pos[1]+(size/2)-10, size, size);
      } else {
        fill(0);
        text("drop your .png here", pos[0]+3, pos[1]+(size/2)-10, size, size);
      }
    } else {
      
      fill(255);
      rect(pos[0]-1, pos[1]-1, size+1, size+1);
      image(file, pos[0], pos[1], size, size);
      
      if(active){
        fill(100,200);
        noStroke();
        rect(pos[0], pos[1], size+1, size+1);
      }
    }
  }

  // if a dragged object enters the target area.
  // dropEnter is called.
  void dropEnter() {
    myColor = dropIn;
    active = true;
  }

  // if a dragged object leaves the target area.
  // dropLeave is called.
  void dropLeave() {
    myColor = dropOut;
    active = false;
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
      loadFile(zoom);
      //println("### file loaded ...");
    }
  }
}