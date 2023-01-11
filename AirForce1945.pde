/**
 * A game like 1945 Air Force but worse.
 * @author Fabian Muth
 * @version 11-01-2023
 *
 * TODO: move public variables to Settings class, add more enemies, add health bar, add bullet sprite, add background music & SFX, add 3dterrain speed incerase over time, add abilities, improve enemy spawner, change ScoreCounter from local to github
 * BUGS: Menu Screen not working correctly at game start in fullscreen. Game speed way too fast in the first seconds of the first round. Terrain3D size does not update on screen size change.
 *
 * CHANGELIST: Added Background music & player shooting SFX. Changed players diagonal movement speed.
 */

import processing.sound.*;

static String version = "2.3";

public static boolean displayHitbox = false;
public static boolean gamePaused = false;
boolean roundOngoing = true;
float gameOverTime = 0;
float afterDeathTime = 5;

Terrain3D terrain;
Galaxy galaxy;

Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> enemyBullets;
ArrayList<ParticleExplosion> explosions;

EnemyManager enemyManager;
CollisionManager collisionManager;
ExplosionManager explosionManager;

MenuScreen menuScreen;
ScoreCounter scoreCounter;
FPSTracker fpsTracker;
boolean showFpsTracker = true;

SoundFile SFX_backgroundTrack_1;
SoundFile SFX_playerShooting;

void settings() {
  size(700, 900, P3D);
  //fullScreen(P3D);
}

void setup() {
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  PFont font = createFont("Arial", 48);
  textFont(font);
  frameRate(60);

  terrain = new Terrain3D(20, 0.001);
  galaxy = new Galaxy(1, 10);
  loadSounds();
  resetGame();
}

void draw() {
  if (!gamePaused) {
    background(0);
    terrain.drawTerrain();
    galaxy.drawGalaxy();

    //update bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      if (b.isOffScreen() || b.getHealth() <= 0) {
        bullets.remove(b);
      } else {
        b.move();
        b.draw();
      }
    }

    //update enemyBullets
    for (int i = enemyBullets.size()-1; i >= 0; i--) {
      Bullet eb = enemyBullets.get(i);
      if (eb.isOffScreen() || eb.getHealth() <= 0) {
        enemyBullets.remove(eb);
      } else {
        eb.move();
        eb.draw();
      }
    }

    enemyManager.manageEnemies();
    collisionManager.manageCollisions();
    explosionManager.manageExplosions();

    player.draw();
    scoreCounter.drawScore();
    if (showFpsTracker) {
      fpsTracker.update();
      fpsTracker.draw();
    }

    if (player.getHealth() <= 0 && roundOngoing) {
      player.die();
      endGame();
    }

    if (!roundOngoing && millis() - gameOverTime > afterDeathTime * 1000) {
      resetGame();
    }
  } else {
    cursor(CROSS);
    menuScreen.draw();
  }
}

void endGame() {
  println("GAME OVER");
  roundOngoing = false;
  gameOverTime = millis();
  scoreCounter.saveScore();
}

void resetGame() {
  println("RESETTING GAME");
  player = new Player();
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  enemyBullets = new ArrayList<Bullet>();
  explosions = new ArrayList<ParticleExplosion>();

  enemyManager = new EnemyManager();
  collisionManager = new CollisionManager();
  explosionManager = new ExplosionManager();

  menuScreen = new MenuScreen();
  menuScreen.drawBackground();
  scoreCounter = new ScoreCounter(width-60, 10);
  fpsTracker = new FPSTracker(600, 10, 10, 80, 40, 15);
  
  SFX_backgroundTrack_1.play();

  gamePaused = true;
  roundOngoing = true;
}

void keyPressed() {
  if ((key == 'p' || key == 27) && roundOngoing) {
    key = 0; //overwrite escape -> exit();
    gamePaused = !gamePaused;
    if (gamePaused) cursor(CROSS);
    else noCursor();
    menuScreen.drawBackground();
  }
  if (key == 'f') showFpsTracker = !showFpsTracker;
  if (key == 'h') displayHitbox = !displayHitbox;
  player.keyPressed();
}

void loadSounds() {
  SFX_backgroundTrack_1 = new SoundFile(this, "C:\\Users\\HP\\Documents\\Processing\\AirForce1945\\data\\SFX\\music\\MegaMan2_Wily1_2Remix_MMC8-bit_converted.wav");
  SFX_backgroundTrack_1.amp(0.1);
  
  SFX_playerShooting = new SoundFile(this, "data\\SFX\\pew-laser-fx_G_major.wav");
  SFX_playerShooting.amp(0.1);
}

void keyReleased() {
  player.keyReleased();
}

void mousePressed() {
  player.mousePressed();
  if (gamePaused) menuScreen.mousePressed();
}

void mouseReleased() {
  player.mouseReleased();
}
