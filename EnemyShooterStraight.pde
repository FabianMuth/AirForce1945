class EnemyShooterStraight extends Enemy {
  GunEnemy gunEnemy;
  
  public EnemyShooterStraight(ScoreCounter scoreCounter) {
    super(scoreCounter);
    this.gunEnemy = new GunEnemy(x, y);
    this.health = 1;
    this.speed = 2;
    this.size = 50;
    this.score = 250;
    this.sprite = loadImage("data\\sprites\\Ship_4.png", "png");
  }
  
  void draw() {
    image(sprite, x, y, size, size);
    gunEnemy.draw(x,y);
    if(displayHitbox) drawHitbox();
  }
}
