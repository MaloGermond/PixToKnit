PImage file;
PGraphics work;

PImage rabatDroitSimple, rabatGaucheSimple;
int zoom = 10;
PVector posWork;

void setup() {
  size(800, 500);
  initGUI();
  posWork = new PVector(0, 0);
}


void draw() {
  background(255);
  keyPress();
  mousePress();
  if (file != null) {
    image(work, posWork.x, posWork.y);
  }
  drawGUI();
}

void loadFile() {
  loadFile(zoom);
}

void loadFile(int zoom) {
  work = createGraphics(file.width * zoom + 200, file.height*zoom+1);
  println("file size:"+file.width+"/"+file.height);

  file.loadPixels();

  work.beginDraw();
  work.background(255);


  work.ellipseMode(CORNER);
  work.imageMode(CENTER);
  int index = 0;

  for (int j=0; j<file.height; j++) {
    work.noFill();
    work.stroke(0);
    work.textSize(zoom);
    work.text("L :"+j, work.width-180, j*zoom-zoom);

    for (int i=0; i<file.width; i++) {
      int posX = i *zoom, posY = j*zoom;  

      work.noFill();
      work.stroke(0);
      work.rect(posX, posY, zoom, zoom);

      int type = file.get(i+1, (j+1));

      if (type == color(0)) {
        index ++;
        if (index%5 == 0) {
          work.stroke(0);
          work.noFill();
          work.line(posX+zoom/5, posY+zoom/2, posX+zoom-zoom/5, posY+zoom/2);
        } else {
          work.noStroke();
          work.fill(0);
          work.ellipse(posX + 2, posY + 2, zoom -4, zoom -4);
        }
      } else {
        index = 0;
      }
    }
  }

  work.endDraw();
}

//=======================================
//
//    Events
//
//=======================================

PVector mouseClicked;
void mousePressed() {
  mouseClicked = new PVector(mouseX, mouseY);
  //println("mouseClicked: [x]:"+mouseClicked.x+"  [y]:"+mouseClicked.y);
  //println(posWork);
}

void keyPress() {
  if (keyPressed == true && keyCode == SHIFT) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}

void mousePress() {
  if (mousePressed == true) {

    if ( keyPressed == true && keyCode == SHIFT && file!=null) {
      cursor(CROSS);
      if (posWork.x < -work.width) {
        posWork.x = -work.width;
      }
      if (posWork.x > work.width) {
        posWork.x = work.width;
      }
      if (posWork.y < -work.height) {
        posWork.y = -work.height;
      }
      if (posWork.y > work.height) {
        posWork.y = work.height;
      }

      if (posWork.x >= -work.width && posWork.x <= work.width
        && posWork.y >= -work.height && posWork.y <= work.height) {         
        posWork.set(mouseX - mouseClicked.x, mouseY - mouseClicked.y);
      }
    }
  }
}

void keyReleased() {
  if (key == 'e' && file !=null) {
    loadFile();
    work.save("export.jpg");
  }
}