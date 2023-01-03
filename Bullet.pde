class Bullet extends GameObject {
  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    this.health = 1;
    this.size = 5;
    this.speed = 7;
  }

  void move() {
    y -= speed;
  }

  void draw() {
    ellipse(x, y, size, 10);
  }
}
