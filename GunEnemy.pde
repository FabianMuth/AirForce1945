class GunEnemy extends Gun {
  public GunEnemy(float x, float y) {
    super(x, y);
    this.delay = 2;
    this.shootingDirection = new PVector(0, 1);
  }

  void draw(float newX, float newY) {
    x = newX;
    y = newY;
    
    if (millis() - lastShotTime > delay*1000) {
      //println("enemy shooting");
      enemyBullets.add(new Bullet(x, y, 400, shootingDirection, true));
      lastShotTime = millis();
    }
  }
}
