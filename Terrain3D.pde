/**
 * 3D Terrain Generator
 * @author Fabian Muth
 * @version 26-11-2022
 * inspired by https://www.youtube.com/watch?v=IKB1hWWedMk
 */

class Terrain3D {
  private int rows, cols, scl;
  private int w = (int)(width + width*0.8);
  private float[][] terrain;
  float flying = 0;
  float speed = 0.03;

  public Terrain3D() {
    this.scl = 20;
    this.cols = width/scl;
    this.rows = height/scl;
    terrain = new float[cols][rows];
    init();
  }

  public Terrain3D(int scale) {
    this.scl = scale;
    this.cols = w/scl;
    this.rows = height/scl;
    terrain = new float[cols][rows];
    init();
  }

  public Terrain3D(int scale, float speed) {
    this.scl = scale;
    this.speed = speed;
    this.cols = w/scl;
    this.rows = height/scl;
    terrain = new float[cols][rows];
    init();
  }

  public Terrain3D(int rows, int cols, int scale) {
    this.scl = scale;
    this.cols = cols;
    this.rows = rows;
    terrain = new float[cols][rows];
    init();
  }

  void drawTerrain() {
    pushMatrix();
    noFill();
    blendMode(ADD);
    

    translate(width/2, height/2+200);
    rotateX(PI/3);
    translate(-w/2, -height/2);

    init();

    for (int y = 0; y < rows-1; y++) {
      stroke(lerpColor(#FF00B7, #00F9FF, y/40f), 100f);
      strokeWeight(map(y, 0, rows, 5, 1));
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        vertex(x*scl, y*scl, terrain[x][y]);
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      }
      endShape();
    }
    /*translate(-width/2, -(height/2+300));
    rotateX(-PI/2.3);
    translate(w/2, height/2);*/
    blendMode(BLEND);
    popMatrix();
  }

  void init() {
    flying -= speed;

    float yoff = flying;
    for (int y = 0; y < rows-1; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -400, -200);
        xoff += 0.1;
      }
      yoff += 0.1;
    }
  }

  void setSpeed(float speed) {
    this.speed = speed;
  }
}
