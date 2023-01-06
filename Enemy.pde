class Enemy extends GameObject {
  int score;
  ScoreCounter scoreCounter;
  ArrayList<String> alreadyHitBy;

  Enemy(ScoreCounter scoreCounter) {
    this.x = random(width);
    this.y = -50;
    this.health = 1;
    this.size = 60;
    this.speed = 3;
    this.score = 100;
    this.scoreCounter = scoreCounter;
    this.alreadyHitBy = new ArrayList<String>();
  }

  void move() {
    y += speed;
  }

  void draw() {
    
    noStroke();
    fill(255, 0, 0);
    circle(x, y, size);
    fill(0);
    circle(x,y,5);
  }

  boolean isOffScreen() {
    return y > height;
  }

  void die() {
    this.scoreCounter.addScore(score);
    explosions.add(new ParticleExplosion((int)x, (int)y, 30));
  }

  ArrayList<String> getAlreadyHitBy() {
    return alreadyHitBy;
  }

  void addBulletAlreadyHitBy(String id) {
    this.alreadyHitBy.add(id);
  }
}
