class GameObject {
  float x, y;
  int health;
  int damage;
  int size;
  float speed;

  boolean collidesWith(GameObject other) {
    float distance = sqrt((other.x - x) * (other.x - x) + (other.y - y) * (other.y - y));
    return distance < (size + other.size);
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
