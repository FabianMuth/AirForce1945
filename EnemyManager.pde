import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

class EnemyManager {
  boolean bossAlive = false;
  boolean bossSpawned = false;
  Timer timer;
  int countdownTime;

  public EnemyManager() {
    timer = new Timer();
    countdownTime = bossSpawnTime;
    timer.schedule(new TimerTask() {
      public void run() {
        if (!gamePaused) {
          if (countdownTime > 0) {
            countdownTime--;
            println("Countdown: " + countdownTime);
          } else {
            println("Countdown finished!");
            spawnBoss();
            timer.cancel();
          }
        }
      }
    }
    , 0, 1000);
  }

  void manageEnemies() {
    //remove dead or offscreen enemies, update others
    Iterator<Enemy> it = enemies.iterator();
    while (it.hasNext()) {
      Enemy e = it.next();
      if (e.getHealth() <= 0) e.die();
      if (e.isOffScreen() || e.getHealth() <= 0) {
        it.remove();
      } else {
        e.move();
        e.draw();
      }
    }

    spawnEnemies();
  }

  void spawnEnemies() {
    if (random(1) < 0.01 && !bossAlive) {
      enemies.add(new Enemy(scoreCounter));
      enemies.add(new EnemyMeteorite(scoreCounter));
      enemies.add(new EnemyShooterStraight(scoreCounter));
    }
  }

  void spawnBoss() {
    bossAlive = true;
    if (!bossSpawned) enemies.add(new EnemyBoss(scoreCounter));
    bossSpawned = true;
  }

  void stopTimer() {
    timer.cancel();
    timer.purge();
  }
}
