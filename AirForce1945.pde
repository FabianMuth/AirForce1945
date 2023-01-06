/**
 * A game like 1945 Air Force but worse.
 * @author Fabian Muth
 * @version 06-01-2023
 *
 * TODO: add background (3d terrain & galaxy), add sprites, add hit visualizer, add end game screen, improve enemy spawner, change ScoreCounter from local to github
 */

static String version = "1.7";

boolean gamePaused = false;
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

void setup() {
  size(600, 800);
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  //frameRate(20);
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

    if (player.getHealth() <= 0 && roundOngoing) {
      player.die();
      endGame();
    }

    if (!roundOngoing && millis() - gameOverTime > afterDeathTime * 1000) {
      resetGame();
    }
  } else {
    menuScreen.draw();
  }
}

void endGame() {
  println("GAME OVER");
  roundOngoing = false;
  gameOverTime = millis();
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
  scoreCounter = new ScoreCounter(width-60, 10);

  gamePaused = false;
  roundOngoing = true;
}

void keyPressed() {
  if (key == 'p' && roundOngoing) {
    gamePaused = !gamePaused;
    menuScreen.drawBackground();
  }
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
