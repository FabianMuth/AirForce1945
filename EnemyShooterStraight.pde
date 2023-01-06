class EnemyShooterStraight extends Enemy {
  GunEnemy gunEnemy;
  
  public EnemyShooterStraight(ScoreCounter scoreCounter) {
    super(scoreCounter);
    this.gunEnemy = new GunEnemy(x, y);
    this.health = 1;
    this.speed = 2;
    this.size = 50;
    this.score = 250;
  }
  
  void draw() {
    noStroke();
    fill(#CE0FFA);
    circle(x, y, size);
    gunEnemy.draw(x,y);
  }
}
