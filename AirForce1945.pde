/**
 * A game like 1945 Air Force but worse.
 * @author Fabian Muth
 * @version 07-01-2023
 *
 * TODO: add background (3d terrain & galaxy), add more sprites, add background music & SFX, add abilities, improve enemy spawner, change ScoreCounter from local to github
 * BUGS: EnemyMeteorite randomly flashing. Menu Screen not working correctly at game start.
 */

static String version = "1.9";

public static boolean displayHitbox = false;
public static boolean gamePaused = false;
boolean roundOngoing = true;
float gameOverTime = 0;
float afterDeathTime = 5;

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

void settings() {
  //size(600, 800, P3D);
  fullScreen(P3D);
}

void setup() {
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  PFont font = createFont("Arial", 48);
  textFont(font);
  
  frameRate(100);
  resetGame();
}

void draw() {
  if (!gamePaused) {
    background(200);

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
  fpsTracker = new FPSTracker(600, 10, 10, 80, 40, 10);

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
