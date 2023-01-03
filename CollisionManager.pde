class CollisionManager {
  //Player player;
  //ArrayList<Enemy> enemies;
  //ArrayList<Bullet> bullets;

  public CollisionManager() {
  }

  public CollisionManager(Player player) {
    //this.player = player;
    //enemies = new ArrayList<Enemy>();
    //bullets = new ArrayList<Bullet>();
  }

  void manageCollisions() {
    checkBulletEnemyCollision();
    checkEnemybulletPlayerCollision();
  }

  void checkBulletEnemyCollision() {
    println("b: " + bullets.size());
    println("e: " + enemies.size());

    for (int i = 0; i < bullets.size(); i++) {
      for (int j = 0; j < enemies.size(); j++) {
        if (bullets.size() > 0 && enemies.size() > 0) {
          Bullet b = bullets.get(i);
          Enemy e = enemies.get(j);
          if (b.collidesWith(e)) {
            bullets.remove(i);
            e.die();
            enemies.remove(j);
          }
        }
      }
    }
  }

  void checkEnemybulletPlayerCollision() {
  }
}
