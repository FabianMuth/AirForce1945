class Player extends GameObject {
  boolean wKeyPressed = false;
  boolean aKeyPressed = false;
  boolean sKeyPressed = false;
  boolean dKeyPressed = false;
  Gun gun;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    this.health = 3;
    this.size = 50;
    this.speed = 5;
    gun = new Gun(x, y);
  }

  void draw() {
    move();
    noStroke();
    fill(0, 200, 2000);
    circle(x, y, size);

    gun.draw(x, y);
  }

  void move() {
    if (wKeyPressed) {
      y -= speed;
    }
    if (aKeyPressed) {
      x -= speed;
    }
    if (sKeyPressed) {
      y += speed;
    }
    if (dKeyPressed) {
      x += speed;
    }

    x = constrain(x, 0 + size/2, width - size/2);
    y = constrain(y, 0 + size/2, height - size/2);
  }

  void receiveDamage(int damage) {
    health -= damage;
  }

  void die() {
    explosions.add(new ParticleExplosion((int)x, (int)y, 100));
  }

  void keyPressed() {
    if (key == 'w') {
      wKeyPressed = true;
    }
    if (key == 'a') {
      aKeyPressed = true;
    }
    if (key == 's') {
      sKeyPressed = true;
    }
    if (key == 'd') {
      dKeyPressed = true;
    }
  }

  void keyReleased() {
    if (key == 'w') {
      wKeyPressed = false;
    }
    if (key == 'a') {
      aKeyPressed = false;
    }
    if (key == 's') {
      sKeyPressed = false;
    }
    if (key == 'd') {
      dKeyPressed = false;
    }
  }

  void mousePressed() {
    gun.mousePressed();
  }

  void mouseReleased() {
    gun.mouseReleased();
  }

  int getHealth() {
    return this.health;
  }
}
