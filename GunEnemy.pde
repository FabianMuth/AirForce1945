class GunEnemy extends Gun {
  public GunEnemy(float x, float y) {
    super(x, y);
    this.delay = 2;
    this.shootingDirection = new PVector(0, 1);
  }

  void draw(float newX, float newY) {
    x = newX;
    y = newY;

    //println("gun: " + bullets.size());

    fill(0);
    rectMode(CORNER);
    rect(x-10, y-10, 20, 20);
    
    
    if (millis() - lastShotTime > delay*1000) {
      println("enemy shooting");
      enemyBullets.add(new Bullet(x, y, 5, shootingDirection, true));
      lastShotTime = millis();
    }
  }
}
