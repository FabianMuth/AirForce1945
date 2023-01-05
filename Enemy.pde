class Enemy extends GameObject {
  int score;
  ArrayList<String> alreadyHitBy;

  Enemy() {
    this.x = random(width);
    this.y = -50;
    this.health = 1;
    this.size = 60;
    this.speed = 3;
    this.score = 100;
    this.alreadyHitBy = new ArrayList<String>();
  }

  void move() {
    y += speed;
  }

  void draw() {
    noStroke();
    fill(255, 0, 0);
    circle(x, y, size);
  }

  boolean isOffScreen() {
    return y > height;
  }

  void die() {
    explosions.add(new ParticleExplosion((int)x, (int)y, 30));
  }

  ArrayList<String> getAlreadyHitBy() {
    return alreadyHitBy;
  }

  void addBulletAlreadyHitBy(String id) {
    this.alreadyHitBy.add(id);
  }
}
