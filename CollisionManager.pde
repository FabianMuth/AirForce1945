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
    println("\nb: " + bullets.size());
    println("b: " + enemyBullets.size());
    println("e: " + enemies.size());
    checkBulletEnemyCollision();
    checkEnemybulletPlayerCollision();
  }

  void checkBulletEnemyCollision() {
    try {
      for (int i = 0; i < bullets.size(); i++) {
        for (int j = 0; j < enemies.size(); j++) {
          //if (bullets.size() > 0 && enemies.size() > 0) {
          Bullet b = bullets.get(i);
          Enemy e = enemies.get(j);
          if (b.collidesWith(e)) {
            bullets.remove(i);
            e.die();
            enemies.remove(j);
          }
          //}
        }
      }
    }
    catch(IndexOutOfBoundsException e) {
      println("IndexOutOfBoundsException in bullets");
      e.printStackTrace();
    }
  }

  void checkEnemybulletPlayerCollision() {
    try {
      for (int i = 0; i < enemyBullets.size(); i++) {
        Bullet b = enemyBullets.get(i);
        if (b.collidesWith(player)) {
          enemyBullets.remove(i);
          player.receiveDamage(1);
        }
      }
    }
    catch(IndexOutOfBoundsException e) {
      println("IndexOutOfBoundsException in enemyBullets");
      e.printStackTrace();
    }
  }
}
