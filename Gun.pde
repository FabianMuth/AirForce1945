class Gun {
  float x;
  float y;
  PVector shootingDirection;
  float delay;
  float lastShotTime;
  //ArrayList<Bullet> bullets;
  boolean shooting;
  boolean disabled;

  public Gun(float x, float y) {
    this.x = x;
    this.y = y;
    this.shootingDirection = new PVector(0, -1);
    this.delay = 0.3;
    this.lastShotTime = 0;
    //bullets = new ArrayList<Bullet>();
    this.shooting = false;
    this.disabled = false;
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
    //rect(x-10, y-10, 20, 20);

    if (shooting && !disabled) {
      if (millis() - lastShotTime > delay * 1000) {
        bullets.add(new Bullet(x, y, 10, shootingDirection, false));
        lastShotTime = millis();
      }
    }
  }

  void setDisabled(boolean disabled) {
    this.disabled = disabled;
  }

  void mousePressed() {
    shooting = true;
  }

  void mouseReleased() {
    shooting = false;
  }
}
