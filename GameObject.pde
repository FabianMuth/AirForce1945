class GameObject {
  float x, y;
  int health;
  int damage;
  int size;
  float speed;

  boolean collidesWith(GameObject other) {
    //float distance = sqrt((other.x - x) * (other.x - x) + (other.y - y) * (other.y - y));
    float distance = dist(x, y, other.x, other.y);
    //println("dist: " + distance + ", sizes: " + (size/2+other.size/2));
    return distance <= (size/2 + other.size/2);
  }

  void takeDamage(int damage) {
    health -= damage;
  }

  int getHealth() {
    return this.health;
  }

  int getSize() {
    return this.size;
  }
}
