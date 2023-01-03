class Particle {
  float x;
  float y;
  float vx;
  float vy;
  float size;
  int life;
  int maxLife;
  color c;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    vx = random(-10, 10);
    vy = random(-10, 10);
    size = random(5, 20);
    maxLife = (int)random(30, 60);
    life = 0;
    c = color(random(100, 255), 0, 0);
  }

  void update() {
    x += vx;
    y += vy;
    vx *= 0.9;
    vy *= 0.9;
    size *= 0.9;
    life++;
  }

  void draw() {
    fill(c);
    noStroke();
    ellipse(x, y, size, size);
  }
}
