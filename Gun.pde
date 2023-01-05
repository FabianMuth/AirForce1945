class Gun {
  float x;
  float y;
  PVector shootingDirection;
  float delay;
  float lastShotTime;
  //ArrayList<Bullet> bullets;
  boolean shooting;

  public Gun(float x, float y) {
    this.x = x;
    this.y = y;
    shootingDirection = new PVector(0, -1);
    delay = 0.5;
    lastShotTime = 0;
    //bullets = new ArrayList<Bullet>();
    shooting = false;
  }

  public Gun(float x, float y, PVector shootingDirection, float delay) {
    this(x, y);
    this.shootingDirection = shootingDirection;
    this.delay = delay;
  }

  void draw(float newX, float newY) {
    x = newX;
    y = newY;

    //println("gun: " + bullets.size());

    fill(0);
    rect(x-10, y-10, 20, 20);
    
    if (shooting) {
      if (millis() - lastShotTime > delay * 1000) {
        bullets.add(new Bullet(x, y, 5, shootingDirection, false));
        lastShotTime = millis();
      }
    }
  }

  void mousePressed() {
    shooting = true;
  }

  void mouseReleased() {
    shooting = false;
  }
}
