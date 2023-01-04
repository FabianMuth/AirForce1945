/**
 * A game like 1945 Air Force but worse.
 * @author Fabian Muth
 * @version 04-01-2023
 */

static String version = "1.4";

boolean gamePaused = false;
boolean roundOngoing = false;

Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> enemyBullets;
ArrayList<ParticleExplosion> explosions;

EnemyManager enemyManager;
CollisionManager collisionManager;
ExplosionManager explosionManager;

MenuScreen menuScreen;

void setup() {
  size(600, 800);
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);

  player = new Player(150, 550);
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  enemyBullets = new ArrayList<Bullet>();
  explosions = new ArrayList<ParticleExplosion>();

  enemyManager = new EnemyManager();
  collisionManager = new CollisionManager();
  explosionManager = new ExplosionManager();

  menuScreen = new MenuScreen();
}

void draw() {
  if (!gamePaused) {
    background(200);

    //update bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      if (bullets.get(i).isOffScreen()) {
        bullets.remove(i);
      } else {
        bullets.get(i).move();
        bullets.get(i).draw();
      }
    }

    //update enemyBullets
    for (int i = enemyBullets.size()-1; i >= 0; i--) {
      if (enemyBullets.get(i).isOffScreen()) {
        enemyBullets.remove(i);
      } else {
        enemyBullets.get(i).move();
        enemyBullets.get(i).draw();
      }
    }

    //println("main e: " + enemies);
    enemyManager.manageEnemies();
    collisionManager.manageCollisions();
    explosionManager.manageExplosions();

    player.draw();

    if (player.getHealth() <= 0) {
      player.die();
      endGame();
    }

    //for (int i = 0; i < bullets.size(); i++) {
    //  Bullet b = bullets.get(i);
    //  b.move();
    //  b.draw();
    //}

    //for (int i = 0; i < enemies.size(); i++) {
    //  Enemy e = enemies.get(i);
    //  e.move();
    //  e.draw();
    //}

    //for (int i = 0; i < bullets.size(); i++) {
    //  for (int j = 0; j < enemies.size(); j++) {
    //    if (bullets.size() > 0 && enemies.size() > 0) {
    //      Bullet b = bullets.get(i);
    //      Enemy e = enemies.get(j);
    //      if (b.collidesWith(e)) {
    //        bullets.remove(i);
    //        enemies.remove(j);
    //      }
    //    }
    //  }
    //}

    //println("main: " + bullets.size());

    //if (random(1) < 0.01) {
    //  enemies.add(new Enemy());
    //}
  } else {
    menuScreen.draw();
  }
}

void endGame() {
  roundOngoing = false;
  println("GAME OVER");
}

public static void resetGame() {
  println("RESETTING GAME");
}

void keyPressed() {
  if (key == 'p') {
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
  if(gamePaused) menuScreen.mousePressed();
}

void mouseReleased() {
  player.mouseReleased();
}
