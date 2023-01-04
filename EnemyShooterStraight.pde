class EnemyShooterStraight extends Enemy {
  GunEnemy gunEnemy;
  public EnemyShooterStraight() {
    this.gunEnemy = new GunEnemy(x, y);
    this.health = 1;
    this.speed = 2;
    this.size = 50;
  }
  
  void draw() {
    fill(#CE0FFA);
    circle(x, y, size);
    gunEnemy.draw(x,y);
  }
}
