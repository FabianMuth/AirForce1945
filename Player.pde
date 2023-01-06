class Player extends GameObject {
  boolean wKeyPressed = false;
  boolean aKeyPressed = false;
  boolean sKeyPressed = false;
  boolean dKeyPressed = false;
  boolean disabled = false;

  Gun gun;

  float xDeathPos = 0;
  boolean dieToRight = true;
  float deathExplosionSpacing = 0.4;
  float lastDeathExplosion = 0;

  Player() {
    this.health = 3;
    this.size = 50;
    this.x = width/2-size/2;
    this.y = height*0.8;
    this.speed = 5;
    gun = new Gun(x, y);
  }

  Player(float x, float y) {
    this();
    this.x = x;
    this.y = y;
  }

  void draw() {
    move();
    noStroke();
    fill(0, 200, 2000);
    circle(x, y, size);

    gun.draw(x, y);
  }

  void move() {
    if (!disabled) {
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
    } else {
      y += speed/2;
      //x = noise(y * 0.0025) * height;
      x = dieToRight ? lerp(x, xDeathPos+200, speed/4*0.01) : lerp(x, xDeathPos-200, speed/4*0.01);
      if (millis() - lastDeathExplosion > deathExplosionSpacing * 1000) {
        explosions.add(new ParticleExplosion((int)x, (int)y, 100));
        lastDeathExplosion = millis();
      }
    }
  }

  void die() {
    println("player died");
    explosions.add(new ParticleExplosion((int)x, (int)y, 100));
    lastDeathExplosion = millis();
    xDeathPos = x;
    dieToRight = round(random(1)) == 0 ? true : false;
    disabled = true;
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
    if (!disabled) gun.mousePressed();
  }

  void mouseReleased() {
    if (!disabled) gun.mouseReleased();
  }

  int getHealth() {
    return this.health;
  }
}
