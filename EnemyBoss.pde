class EnemyBoss extends Enemy {
  boolean disabled = true;

  GunEnemy[] bossGuns = new GunEnemy[4];
  float attackDelay = 4;
  float lastAttackTime = 0;

  boolean shootingAtPlayer = false;
  int activeShootAtPlayerGun = 0;
  float lastShotAtPlayer = 0;

  boolean shootingMissiles = false;
  int activeMissileLaunching = 0;
  float lastMissileAtPlayer = 0;

  Gif laserCharge, laserShoot;
  boolean shootingLaser = false;
  int numFramesLaser = 4;
  int currentFrame = 0;
  int animationSpeed = 5;
  int animationCounter = 0;
  int laserDuration = 3;
  float laserStartTime = 0;
  PImage laserAmbientLight;

  boolean laserCharged = false;
  boolean laserStarted = false;
  float chargeDuration = 0.5;
  float chargeStartTime = 0;

  public EnemyBoss(ScoreCounter sc) {
    super(sc);
    this.health = 200;
    this.size = 200; //only hitbox, no correlation with image size
    this.x = width/2;
    this.y = - 200;
    this.speed = 100;
    this.score = 2000;
    this.sprite = loadImage("data\\sprites\\enemyBossShip.png");
    this.laserAmbientLight = loadImage("data\\sprites\\laserAmbientLight.png");
    this.laserCharge = new Gif(thisMain, "data\\sprites\\noemi-coute-laser-chargeup.gif");
    this.laserShoot = new Gif(thisMain, "data\\sprites\\noemi-coute-laser_downscaled_centered.gif");
    initBossGuns();
  }

  boolean movingRight = true;
  boolean movingUp = false;

  void move() {
    if (y <= 200 && disabled) {
      deltaTime = 1.0 / frameRate;
      y += speed * deltaTime;
    } else {
      disabled = false;
    }

    if (movingRight) {
      x += 4 * deltaTime;
      if (x > width/2+30) movingRight = false;
    } else {
      x -= 4 * deltaTime;
      if (x < width/2-30) movingRight = true;
    }

    if (movingUp) {
      y -= 2 * deltaTime;
      if (y < 180) movingUp = false;
    } else {
      y += 2 * deltaTime;
      if (y > 220) movingUp = true;
    }
  }

  void draw() {
    pushMatrix();
    indicateWhenHit();
    attack();
    if (shootingAtPlayer) shootAtPlayer();
    if (shootingMissiles) shootHomingMissiles();
    imageMode(CENTER);
    image(sprite, x, y, 500, 500);
    if (shootingLaser) shootLaser();
    if (displayHitbox) drawHitbox();
    popMatrix();
  }

  void attack() {
    if (millis() - lastAttackTime > attackDelay*1000 && !disabled) {
      int random = int(random(4));
      switch(random) {
      case 0:
        shoot();
        break;
      case 1:
        shootingAtPlayer = true;
        break;
      case 2:
        shootingMissiles = true;
        break;
      case 3:
        shootingAtPlayer = true;

        shootingLaser = true;
        laserCharged = false;
        laserStarted = false;
        chargeStartTime = millis();
        break;
      }
      lastAttackTime = millis();
    }
  }

  void shoot() {
    bossGuns[0].draw(x-165, y+145);
    bossGuns[1].draw(x+165, y+145);
    bossGuns[2].draw(x-110, y+200);
    bossGuns[3].draw(x+110, y+200);
  }

  void shootAtPlayer() {
    if (millis() - lastShotAtPlayer > 200) {
      switch(activeShootAtPlayerGun) {
      case 0:
        bossGuns[0].draw(x-165, y+145, new PVector(player.x - (x-165), player.y - (y+145)).normalize());
        lastShotAtPlayer = millis();
        activeShootAtPlayerGun++;
        break;
      case 1:
        bossGuns[1].draw(x+165, y+145, new PVector(player.x - (x+165), player.y - (y+145)).normalize());
        lastShotAtPlayer = millis();
        activeShootAtPlayerGun++;
        break;
      case 2:
        bossGuns[2].draw(x-110, y+200, new PVector(player.x - (x-110), player.y - (y+200)).normalize());
        lastShotAtPlayer = millis();
        activeShootAtPlayerGun++;
        break;
      case 3:
        bossGuns[3].draw(x+110, y+200, new PVector(player.x - (x+110), player.y - (y+200)).normalize());
        shootingAtPlayer = false;
        activeShootAtPlayerGun = 0;
        break;
      }
    }
  }

  void shootHomingMissiles() {
    if (millis() - lastMissileAtPlayer > 200) {
      switch(activeMissileLaunching) {
      case 0:
        enemyBullets.add(new HomingMissile(x+60, y, new PVector(6, -5)));
        lastMissileAtPlayer = millis();
        activeMissileLaunching++;
        break;
      case 1:
        enemyBullets.add(new HomingMissile(x-60, y, new PVector(-6, -5)));
        lastMissileAtPlayer = millis();
        activeMissileLaunching++;
        break;
      case 2:
        enemyBullets.add(new HomingMissile(x+60, y, new PVector(6, -5)));
        lastMissileAtPlayer = millis();
        activeMissileLaunching++;
        break;
      case 3:
        enemyBullets.add(new HomingMissile(x-60, y, new PVector(-6, -5)));
        shootingMissiles = false;
        activeMissileLaunching = 0;
        break;
      }
      soundFilesSFX.get("SFX_boss_missile").play();
    }
  }

  void shootLaser() {
    if (millis() - chargeStartTime < chargeDuration * 1000) {
      laserCharge.play();
      pushMatrix();
      blendMode(BLEND);
      imageMode(CENTER);
      translate(x-5, y+40);
      scale(0.2);
      image(laserCharge, 0, 0);
      popMatrix();
    } else {
      laserCharge.stop();
      laserCharge.jump(0);
      laserCharged = true;
      if (!laserStarted) laserStartTime = millis();
    }

    if ((millis() - laserStartTime < laserDuration * 1000) && laserCharged) {
      laserStarted = true;
      if (!soundFilesSFX.get("SFX_boss_laser1").isPlaying()) soundFilesSFX.get("SFX_boss_laser1").play();
      //if (!soundFilesSFX.get("SFX_boss_laser2").isPlaying()) soundFilesSFX.get("SFX_boss_laser2").play();
      if (isPlayerInLaser()) player.takeDamage(1);

      animationCounter++;
      if (animationCounter % animationSpeed == 0) {
        currentFrame = (currentFrame + 1) % numFramesLaser;
        laserShoot.jump(currentFrame);
      }

      pushMatrix();
      blendMode(ADD);
      imageMode(CENTER);
      tint(255, 255, 255, 200);
      image(laserAmbientLight, x, y+40);

      blendMode(BLEND);
      tint(255);
      translate(x, y+405);
      rotate(radians(-90));
      image(laserShoot, 0, 0);
      popMatrix();
    }
  }

  boolean isPlayerInLaser() {
    if (displayHitbox) {
      strokeWeight(2);
      stroke(#00FFFD);
      noFill();
      rect(x-60, 0, 120, height);
    }
    if (player.x > x - 60 && player.x < x + 60) return true;
    else return false;
  }

  void initBossGuns() {
    for (int i = 0; i < bossGuns.length; i++) {
      bossGuns[i] = new GunEnemy(0, 0);
    }
  }
  
  void die() {
    this.scoreCounter.addScore(score);
    explosions.add(new ParticleExplosion((int)x, (int)y, 200, 50));
    soundFilesSFX.get("SFX_enemyDeath").play();
    enemyManager.bossAlive = false;
  }
}
