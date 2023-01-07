class Enemy extends GameObject {
  int score;
  ScoreCounter scoreCounter;
  ArrayList<String> alreadyHitBy;

  Enemy(ScoreCounter scoreCounter) {
    this.x = random(width);
    this.y = -50;
    this.health = 2;
    this.size = 60;
    this.speed = 3;
    this.score = 100;
    this.scoreCounter = scoreCounter;
    this.alreadyHitBy = new ArrayList<String>();
    this.sprite = loadImage("data\\sprites\\Ship_5.png", "png");
  }

  void move() {
    y += speed;
  }

  void draw() {   
    indicateWhenHit();
    imageMode(CENTER);
    rotateZ(TWO_PI);
    image(sprite, x, y, size, size);
    if(displayHitbox) drawHitbox();
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
