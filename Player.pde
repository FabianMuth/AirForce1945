class Player extends GameObject {
  boolean wKeyPressed = false;
  boolean aKeyPressed = false;
  boolean sKeyPressed = false;
  boolean dKeyPressed = false;
  boolean disabled = false;

  PVector movement;
  Gun gun;

  float xDeathPos = 0;
  boolean dieToRight = true;
  float deathExplosionSpacing = 0.4;
  float lastDeathExplosion = 0;

  Player() {
    this.health = 20;
    this.size = 50;
    this.x = width/2-size/2;
    this.y = height*0.8;
    this.speed = 350;
    gun = new Gun(x, y);
    this.sprite = loadImage("data\\sprites\\mainship_upscaled.png", "png");
  }
  
  void takeDamage(int dmg){
    println(health);
    super.takeDamage(dmg);
  }

  Player(float x, float y) {
    this();
    this.x = x;
    this.y = y;
  }

  void draw() {
    move();

    indicateWhenHit();
    imageMode(CENTER);
    image(sprite, x, y, size, size);

    gun.draw(x, y);

    if (displayHitbox) drawHitbox();
  }

  void move() {
    //deltaTime = 1.0 / frameRate;
    println(deltaTime);
    if (!disabled) {
      movement = new PVector();

      if (wKeyPressed) {
        movement.y -= 1;
      }
      if (aKeyPressed) {
        movement.x -= 1;
      }
      if (sKeyPressed) {
        movement.y += 1;
      }
      if (dKeyPressed) {
        movement.x += 1;
      }

      if (movement.mag() > 0) {
        movement.normalize();
      }

      x += movement.x * speed * deltaTime;
      y += movement.y * speed * deltaTime;

      x = constrain(x, 0 + size/2, width - size/2);
      y = constrain(y, 0 + size/2, height - size/2);
    } else {
      y += speed/2*deltaTime;
      //x = noise(y * 0.0025) * height;
      x = dieToRight ? lerp(x, xDeathPos+200, speed/4*0.01*deltaTime) : lerp(x, xDeathPos-200, speed/4*0.01*deltaTime);
      if (millis() - lastDeathExplosion > deathExplosionSpacing * 1000) {
        explosions.add(new ParticleExplosion((int)x, (int)y, 100));
        lastDeathExplosion = millis();
      }
    }
  }

  void die() {
    println("player died");
    AudioPlayersSFX.get("SFX_playerDeath").play(0);
    explosions.add(new ParticleExplosion((int)x, (int)y, 100));
    lastDeathExplosion = millis();
    xDeathPos = x;
    dieToRight = round(random(1)) == 0 ? true : false;
    gun.setDisabled(true);
    disabled = true;
  }

  void keyPressed() {
    if (key == 'w') wKeyPressed = true;
    if (key == 'a') aKeyPressed = true;
    if (key == 's') sKeyPressed = true;
    if (key == 'd') dKeyPressed = true;
  }

  void keyReleased() {
    if (key == 'w') wKeyPressed = false;
    if (key == 'a') aKeyPressed = false;
    if (key == 's') sKeyPressed = false;
    if (key == 'd') dKeyPressed = false;
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

  PVector getPosition() {
    return new PVector(x, y);
  }
}
