class EnemyMeteorite extends Enemy {
  public EnemyMeteorite() {
    this.health = 10;
    this.speed = 1;
    this.size = 70;
  }
  
  void draw() {
    noStroke();
    fill(155, 100, 100);
    circle(x, y, size);
  }
}
