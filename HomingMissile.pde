class HomingMissile extends Bullet {
  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed;

  HomingMissile(float x, float y) {
    super(x, y);
    this.size = 20;
    pos = new PVector(x, y);
    vel = new PVector(1,1);
    acc = new PVector();
    maxSpeed = 20;
  }

  void move() {
    deltaTime = 1.0 / frameRate;
    acc = PVector.sub(player.getPosition(), pos);
    acc.normalize();
    acc.mult(0.5);

    vel.add(acc);
    vel.limit(maxSpeed);
    deltaTime += 1;
    vel.mult(deltaTime);
    pos.add(vel);
    
    x = pos.x;
    y = pos.y;
  }

  void draw() {
    fill(255);
    ellipse(x, y, 20, 20);
    if (displayHitbox) drawHitbox();
  }
}
