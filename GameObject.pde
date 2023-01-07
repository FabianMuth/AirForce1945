class GameObject {
  float x, y;
  int health;
  int damage;
  int size;
  float speed;
  PImage sprite;
  boolean hit = false;
  int flashTimer = 0;
  boolean drawHitbox = true;

  boolean collidesWith(GameObject other) {
    //float distance = sqrt((other.x - x) * (other.x - x) + (other.y - y) * (other.y - y));
    float distance = dist(x, y, other.x, other.y);
    //println("dist: " + distance + ", sizes: " + (size/2+other.size/2));
    return distance <= (size/2 + other.size/2);
  }

  void takeDamage(int damage) {
    this.health -= damage;
    this.hit = true;
  }

  void indicateWhenHit() {
    if (hit) {
      if (flashTimer < 2) {
        tint(255, 0, 0);
      } else {
        tint(255);
      }
      flashTimer++;
      if (flashTimer > 2) {
        flashTimer = 0;
        hit = false;
      }
    } else {
      tint(255);
    }
  }

  int getHealth() {
    return this.health;
  }

  int getSize() {
    return this.size;
  }

  void drawHitbox() {
    strokeWeight(2);
    stroke(#00FFFD);
    noFill();
    circle(x, y, size);
  }

  void toggleHitbox() {
    drawHitbox = !drawHitbox;
  }
}
