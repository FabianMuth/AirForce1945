class EnemyMeteorite extends Enemy {
  public EnemyMeteorite(ScoreCounter scoreCounter) {
    super(scoreCounter);
    this.health = 10;
    this.speed = 100;
    this.size = 70;
    this.score = 500;
    this.sprite = loadImage("data\\sprites\\meteorite_01.png", "png");
  }
  
  void draw() {
    indicateWhenHit();
    imageMode(CENTER);
    image(sprite, x, y, size, size);
    if(displayHitbox) drawHitbox();
  }
}
