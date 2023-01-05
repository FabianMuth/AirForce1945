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
    this.speed = 7;
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

  void move() {
    x += shootingDirection.x * speed;
    y += shootingDirection.y * speed;
  }

  void draw() {
    noStroke();
    fill(255);
    ellipse(x, y, size, 10);
  }

  boolean isOffScreen() {
    return isEnemyBullet ? y > height : y < 0;
  }

  String getUUID() {
    return _UUID;
  }
}
