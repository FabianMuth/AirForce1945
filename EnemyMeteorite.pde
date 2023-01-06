class EnemyMeteorite extends Enemy {
  public EnemyMeteorite(ScoreCounter scoreCounter) {
    super(scoreCounter);
    this.health = 10;
    this.speed = 1;
    this.size = 70;
    this.score = 500;
  }
  
  void draw() {
    noStroke();
    fill(155, 100, 100);
    circle(x, y, size);
  }
}
