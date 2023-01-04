class Enemy extends GameObject {
  int score;
  Enemy() {
    this.x = random(width);
    this.y = -50;
    this.health = 1;
    this.size = 60;
    this.speed = 3;
    this.score = 100;
    this.gun = new Gun(x,y);
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
