class Enemy extends GameObject {
  Enemy() {
    this.x = random(width);
    this.y = -50;
    this.health = 1;
    this.size = 60;
    this.speed = 3;
  }

  void move() {
    y += speed;
  }

  void draw() {
    circle(x, y, size);
  }
}
