class EnemyManager {
  public EnemyManager() {
  }

  void manageEnemies() {
    //remove dead or offscreen enemies, update others
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      if (e.isOffScreen() || e.getHealth() <= 0) {
        enemies.remove(e);
      } else {
        e.move();
        e.draw();
      }
    }

    spawnEnemies();
  }
  
  void spawnEnemies(){
    if (random(1) < 0.01) {
      enemies.add(new Enemy());
      enemies.add(new EnemyMeteorite());
      enemies.add(new EnemyShooterStraight());
    }
  }
}
