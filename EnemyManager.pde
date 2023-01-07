class EnemyManager {
  public EnemyManager() {
  }

  void manageEnemies() {
    //remove dead or offscreen enemies, update others
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      if (e.getHealth() <= 0) e.die();
      if (e.isOffScreen() || e.getHealth() <= 0) {
        enemies.remove(e);
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
