int[][] b = {
  {0, 128},
  {192, 64}
};

void bayer2x2(PImage i, int s) {
  i.loadPixels();
  noStroke();

  for (int x = 0; x < i.width; x += s) {
    for (int y = 0; y < i.height; y += s) {
      int loc = x + (y * i.width);
      float br = brightness(i.pixels[loc]);

      int bx = (x / s) % 2;
      int by = (y / s) % 2;

      if (br > b[bx][by]) {
        fill(255);
      } else {
        fill(0);
      }

      if (s > 2) {
        rect(x, y, s, s);
      } else {
        rect(x, y, 1, 1);
      }
    }
  }
}

void bayer2x2(PImage i, int s, PGraphics bu) {
  i.loadPixels();
  bu.noStroke();

  for (int x = 0; x < i.width; x += s) {
    for (int y = 0; y < i.height; y += s) {
      int loc = x + (y * i.width);
      float br = brightness(i.pixels[loc]);

      int bx = (x / s) % 2;
      int by = (y / s) % 2;

      if (br > b[bx][by]) {
        bu.fill(255);
      } else {
        bu.fill(0);
      }

      if (s > 2) {
        bu.rect(x, y, s, s);
      } else {
        bu.rect(x, y, 1, 1);
      }
    }
  }
}

int[][] b4 = {
  {  0, 128,  32, 160},
  {192,  64, 224,  96},
  { 48, 176,  16, 144},
  {240, 112, 208,  80}
};

void bayer4x4(PImage i, int s) {
  i.loadPixels();

  for (int x = 0; x < i.width; x += s) {
    for (int y = 0; y < i.height; y += s) {
      int loc = x + (y * i.width);
      float br = brightness(i.pixels[loc]);

      int bx = (x / s) % 4; 
      int by = (y / s) % 4;

      if (br > b4[bx][by]) {
        fill(255);
      } else {
        fill(0);
      }

      if (s > 2) {
        rect(x, y, s, s);
      } else {
        rect(x, y, 1, 1);
      }
    }
  }
}

void bayer4x4(PImage i, int s, PGraphics buff) {
  i.loadPixels();

  for (int x = 0; x < i.width; x += s) {
    for (int y = 0; y < i.height; y += s) {
      int loc = x + (y * i.width);
      float br = brightness(i.pixels[loc]);

      int bx = (x / s) % 4; 
      int by = (y / s) % 4;

      if (br > b4[bx][by]) {
        buff.fill(255);
      } else {
        buff.fill(0);
      }

      if (s > 2) {
        buff.rect(x, y, s, s);
      } else {
        buff.rect(x, y, 1, 1);
      }
    }
  }
}


int[][] b8 = {
  {  0, 128,  32, 160,   8, 136,  40, 168},
  {192,  64, 224,  96, 200,  72, 232, 104},
  { 48, 176,  16, 144,  56, 184,  24, 152},
  {240, 112, 208,  80, 248, 120, 216,  88},
  { 12, 140,  44, 172,   4, 132,  36, 164},
  {204,  76, 236, 108, 196,  68, 228, 100},
  { 60, 188,  28, 156,  52, 180,  20, 148},
  {252, 124, 220,  92, 244, 116, 212,  84}
};

void bayer8x8(PImage i, int s) {
  i.loadPixels();
  noStroke();

  for (int x = 0; x < i.width; x += s) {
    for (int y = 0; y < i.height; y += s) {
      int loc = x + (y * i.width);
      float br = brightness(i.pixels[loc]);

      int bx = (x / s) % 8; 
      int by = (y / s) % 8;

      if (br > b8[bx][by]) {
        fill(255);
      } else {
        fill(0);
      }

      if (s > 2) {
        rect(x, y, s, s);
      } else {
        rect(x, y, 1, 1);
      }
    }
  }
}

void bayer8x8(PImage i, int s, PGraphics bu) {
  i.loadPixels();
  bu.noStroke();

  for (int x = 0; x < i.width; x += s) {
    for (int y = 0; y < i.height; y += s) {
      int loc = x + (y * i.width);
      float br = brightness(i.pixels[loc]);

      int bx = (x / s) % 8; 
      int by = (y / s) % 8;

      if (br > b8[bx][by]) {
        bu.fill(255);
      } else {
        bu.fill(0);
      }

      if (s > 2) {
        bu.rect(x, y, s, s);
      } else {
        bu.rect(x, y, 1, 1);
      }
    }
  }
}
