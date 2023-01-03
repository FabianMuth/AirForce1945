class Bullet extends GameObject {
  boolean isEnemyBullet = false;
  
  Bullet(float x, float y) {
    this.x = x;
    this.y = y;
    this.health = 1;
    this.size = 5;
    this.speed = 7;
    this.damage = 1;
  }

  Bullet(float x, float y, boolean isEnemyBullet) {
    this(x, y);
    this.isEnemyBullet = isEnemyBullet;
  }
  
  Bullet(float x, float y, float speed) {
    this(x, y);
    this.speed = speed;
  }

  void move() {
    y -= speed;
  }

  void draw() {
    fill(255);
    ellipse(x, y, size, 10);
  }
  
  boolean isOffScreen() {
    return y < 0;
  }
}
