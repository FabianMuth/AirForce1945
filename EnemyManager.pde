import java.util.Iterator;

class EnemyManager {
  public EnemyManager() {
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
    if (random(1) < 0.01) {
      enemies.add(new Enemy(scoreCounter));
      enemies.add(new EnemyMeteorite(scoreCounter));
      enemies.add(new EnemyShooterStraight(scoreCounter));
    }
  }
}
