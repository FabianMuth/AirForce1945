import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

class HomingMissile extends Bullet {
  PVector pos;
  PVector vel;
  PVector acc;
  float maxSpeed;
  PVector initialVelocity;
  float timeToLive = 5;
  float launchTime = 0;

  HomingMissile(float x, float y) {
    super(x, y);
    this.size = 30;
    pos = new PVector(x, y);
    vel = new PVector(0, 1);
    acc = new PVector();
    maxSpeed = 10;
    this.sprite = loadImage("data\\sprites\\laserAmbientLight.png");
    this.launchTime = millis();
  }

  HomingMissile(float x, float y, PVector initialVelocity) {
    this(x, y);
    this.vel = initialVelocity;
  }

  void move() {
    if(millis() - launchTime > timeToLive * 1000) this.health = 0;
    
    acc = PVector.sub(player.getPosition(), pos);
    acc.normalize();
    acc.mult(0.6);

    vel.add(acc);
    vel.limit(maxSpeed);
    deltaTime += 1;
    vel.mult(deltaTime);
    pos.add(vel);

    x = pos.x;
    y = pos.y;
  }

  void draw() {
    noStroke();
    blendMode(DIFFERENCE);
    image(sprite, x, y, size, size);
    fill(#FCA6B0);
    circle(x, y, 7);
    fill(#FFFFFF);
    circle(x, y, 5);
    blendMode(BLEND);
    if (displayHitbox) drawHitbox();
  }

  boolean isOffScreen() {
    if (x < -50 || x > width+50 || y < 0 || y > height) return true;
    else return false;
  }
}
