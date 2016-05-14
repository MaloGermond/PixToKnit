PImage file;
PGraphics work;

PImage rabatDroitSimple, rabatGaucheSimple;
int zoom = 10;


void setup() {
  size(500, 500);

  loadFile(10);
}

void draw() {
  background(255);
  image(work, -mouseX+file.width/2, -mouseY+file.height/2);
}

void loadFile() {
  loadFile(20);
}

void loadFile(int zoom) {
  file = loadImage("neutre.png");
  work = createGraphics(file.width * zoom + 200, file.height*zoom+1);


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
    work.text("L :"+j,work.width-180,j*zoom-zoom);
    
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
          work.line(posX+zoom/5,posY+zoom/2,posX+zoom-zoom/5, posY+zoom/2);
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


void keyReleased() {
  if (key == 'e') {
    loadFile();
    work.save("export.jpg");
  }
}
