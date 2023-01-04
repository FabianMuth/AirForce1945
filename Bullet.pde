class Bullet extends GameObject {
  boolean isEnemyBullet;
  PVector shootingDirection;

  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    this.health = 1;
    this.size = 5;
    this.speed = 7;
    this.damage = 1;
    this.isEnemyBullet = false;
    this.shootingDirection = new PVector(0, -1);
  }

  Bullet(float x, float y, boolean isEnemyBullet) {
    this(x, y);
    this.isEnemyBullet = isEnemyBullet;
  }

  Bullet(float x, float y, float speed, PVector shootingDirection) {
    this(x, y);
    this.speed = speed;
    this.shootingDirection = shootingDirection;
  }

  void move() {
    x += shootingDirection.x * speed;
    y += shootingDirection.y * speed;
  }

  void draw() {
    fill(255);
    ellipse(x, y, size, 10);
  }

  boolean isOffScreen() {
    return y < 0;
  }
}
