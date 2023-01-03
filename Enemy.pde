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
    fill(255, 0, 0);
    circle(x, y, size);
  }

  boolean isOffScreen() {
    return y > height;
  }

  void die() {
    explosions.add(new ParticleExplosion((int)x, (int)y, 30));
  }
}
