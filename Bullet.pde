import java.util.UUID;

class Bullet extends GameObject {
  boolean isEnemyBullet;
  PVector shootingDirection;
  String _UUID;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    this.health = 1;
    this.size = 5;
    this.speed = 700;
    this.damage = 1;
    this.isEnemyBullet = false;
    this.shootingDirection = new PVector(0, -1);
    this._UUID = UUID.randomUUID().toString();
  }

  Bullet(float x, float y, boolean isEnemyBullet) {
    this(x, y);
    this.isEnemyBullet = isEnemyBullet;
  }

  Bullet(float x, float y, float speed, PVector shootingDirection, boolean isEnemyBullet) {
    this(x, y);
    this.speed = speed;
    this.shootingDirection = shootingDirection;
    this.isEnemyBullet = isEnemyBullet;
  }

  Bullet(float x, float y, float speed, PVector shootingDirection, boolean isEnemyBullet, PImage sprite) {
    this(x, y, speed, shootingDirection, isEnemyBullet);
    this.sprite = sprite;
  }

  void move() {
    deltaTime = 1.0 / frameRate;
    x += shootingDirection.x * speed * deltaTime;
    y += shootingDirection.y * speed * deltaTime;
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    rotate(shootingDirection.heading() + HALF_PI);
    noStroke();
    fill(#00FFFD);
    if (isEnemyBullet) fill(#08FC05);
    ellipse(0, 0, size, 10);
    popMatrix();
  }


  boolean isOffScreen() {
    return isEnemyBullet ? y > height : y < 0;
  }

  String getUUID() {
    return _UUID;
  }
}
