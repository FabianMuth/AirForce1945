import java.util.HashSet;

class Enemy extends GameObject {
  int score;
  ScoreCounter scoreCounter;
  HashSet<String> alreadyHitBy;

  Enemy(ScoreCounter scoreCounter) {
    this.x = random(width);
    this.y = -50;
    this.health = 2;
    this.size = 60;
    this.speed = 300;
    this.score = 100;
    this.scoreCounter = scoreCounter;
    this.alreadyHitBy = new HashSet<String>();
    this.sprite = loadImage("data\\sprites\\Ship_5.png", "png");
  }

  void move() {
    deltaTime = 1.0 / frameRate;
    y += speed * deltaTime;
  }

  void draw() {   
    indicateWhenHit();
    imageMode(CENTER);
    image(sprite, x, y, size, size);
    if(displayHitbox) drawHitbox();
  }

  boolean isOffScreen() {
    return y > height+size;
  }

  void die() {
    this.scoreCounter.addScore(score);
    explosions.add(new ParticleExplosion((int)x, (int)y, 30));
  }

  HashSet<String> getAlreadyHitBy() {
    return alreadyHitBy;
  }

  void addBulletAlreadyHitBy(String id) {
    this.alreadyHitBy.add(id);
  }
}
