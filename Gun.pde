class Gun {
  float x;
  float y;
  float delay;
  float lastShotTime;
  ArrayList<Bullet> bullets;
  boolean shooting;

  public Gun(float x, float y) {
    this.x = x;
    this.y = y;
    delay = 0.1;
    lastShotTime = 0;
    bullets = new ArrayList<Bullet>();
    shooting = false;
  }

  void draw(float newX, float newY) {
    x = newX;
    y = newY;
    
    fill(0);
    rect(x-10, y-10, 20, 20);
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).isOffScreen()) {
        bullets.remove(i);
      } else {
        bullets.get(i).move();
        bullets.get(i).draw();
      }
    }
    if (shooting) {
      if (millis() - lastShotTime > delay*1000) {
        bullets.add(new Bullet(x, y));
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
