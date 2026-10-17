
import java.io.*;

VideoExporter exporter;
boolean recording = true;

int x = (int)random(width), y = (int) random(height);
int velX = (int) random(2, 10), velY = (int) random(2, 10) ;

PGraphics buf;

void setup() {
  size(120 * 4, 96 * 4);
  frameRate(8);
  colorMode(RGB, 255);

  exporter = new VideoExporter("boing.BIN");

  noStroke();
  textAlign(CENTER, CENTER);
  //textSize(width/3);
  textSize(24);

  x = (int)random(width); y = (int) random(height);
  velX = (int) random(-30, 30);
  velY = (int) random(-30, 30);
  buf = createGraphics(width, height);
  buf.beginDraw();
  buf.background(0);
  buf.fill(255);
  buf.endDraw();
  
}

void draw() {
  buf.beginDraw();
  buf.fill(0, 100);
  buf.rect(0, 0, width, height);
  
  buf.fill(255);
  buf.ellipse(x, y, 20, 20);
  buf.endDraw();
  x += velX;
  y += velY;
  
  if (x + 11 >= width)  velX *= -1;
  if (x - 11 <= 0)  velX *= -1;
  if (y + 11 >= height) velY *= -1;
  if (y - 11 <= 0) velY *= -1;
  
  bayer2x2(buf, 4);

  //background(0);

  //int i = 1;
  //for (int y = 0; y < height; y += 12 * 4) {
  //  for (int x = 0; x < width; x += 12 * 4) {

  //    if (i % 2 == 0) {
  //      fill(255);
  //    } else {
  //      fill(0);
  //    }

  //    rect(x, y, 12 * 4, 12 * 4);

  //    if (i % 2 == 0) {
  //      fill(0);
  //    } else {
  //      fill(255);
  //    }

  //    text(i % 10, x + 6 * 4, y + 6 * 4);

  //    i++;
  //  }
  //  i++;
  //}

  //text(frameCount, width/2, height/2);

  PImage b = get(0, 0, width, height);
  b.resize(120, 96);
  exporter.addFrame(b);

  if (frameCount >= 100) {
    exporter.finish();
    exit();
  }

  //if (recording) {
  //  exporter.addFrame(get());
  //}
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    if (!recording) {
      exporter = new VideoExporter("VIDEO.BIN");
      recording = true;
    }
  }

  if (key == 's' || key == 'S') {
    if (recording) {
      exporter.finish();
      exporter = null;
      recording = false;
    }
  }
}

class VideoExporter {
  BufferedOutputStream bos;

  VideoExporter(String fileName) {
    try {
      bos = new BufferedOutputStream(
        new FileOutputStream(sketchPath(fileName))
        );
      println("Recording: " + fileName);
    }
    catch (Exception e) {
      println(e);
    }
  }

  void addFrame(PImage img) {
    if (bos == null) return;

    PImage frame = img.get();
    frame.resize(120, 96);
    frame.loadPixels();

    try {
      for (int y = 0; y < 96; y++) {
        for (int x = 0; x < 120; x += 8) {
          int b = 0;

          for (int i = 0; i < 8; i++) {
            int c = frame.pixels[y * 120 + x + i];
            if (brightness(c) > 127) {
              b |= 1 << (7 - i);
            }
          }

          bos.write(b);
        }
      }
    }
    catch (Exception e) {
      println(e);
    }
  }

  void finish() {
    if (bos == null) return;

    try {
      bos.flush();
      bos.close();
      bos = null;
      println("Recording saved.");
    }
    catch (Exception e) {
      println(e);
    }
  }
}
