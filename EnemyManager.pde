class EnemyManager {
  public EnemyManager() {
  }

  void manageEnemies() {
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      if (e.isOffScreen()) {
        enemies.remove(e);
      } else {
        e.move();
        e.draw();
      }
    }

    if (random(1) < 0.01) {
      enemies.add(new Enemy());
      enemies.add(new EnemyMeteorite());
      enemies.add(new EnemyShooterStraight());
    }
  }
}
