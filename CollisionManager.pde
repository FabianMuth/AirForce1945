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
    //println("\nb: " + bullets.size());
    //println("eb: " + enemyBullets.size());
    //println("e: " + enemies.size());

    checkBulletEnemyCollision();
    checkEnemybulletPlayerCollision();
    checkEnemyPlayerCollision();
  }

  void checkBulletEnemyCollision() {
    try {
      for (int i = 0; i < bullets.size(); i++) {
        for (int j = 0; j < enemies.size(); j++) {
          //if (bullets.size() > 0 && enemies.size() > 0) {
          Bullet b = bullets.get(i);
          Enemy e = enemies.get(j);
          if (b.collidesWith(e) && e.getAlreadyHitBy().contains(b.getUUID())) {
            b.takeDamage(1);
            e.takeDamage(1);
            e.addBulletAlreadyHitBy(b.getUUID());
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
        Bullet eb = enemyBullets.get(i);
        if (eb.collidesWith(player)) {
          eb.takeDamage(1);
          player.takeDamage(1);
        }
      }
    }
    catch(IndexOutOfBoundsException e) {
      println("IndexOutOfBoundsException in enemyBullets");
      e.printStackTrace();
    }
  }

  void checkEnemyPlayerCollision() {
    try {
      for (int i = 0; i < enemies.size(); i++) {
        Enemy e = enemies.get(i);
        if (e.collidesWith(player)) {
          println("enemy-player collision!");
          e.takeDamage(1);
          player.takeDamage(1);
        }
      }
    }
    catch(IndexOutOfBoundsException e) {
      println("IndexOutOfBoundsException in enemyBullets");
      e.printStackTrace();
    }
  }
}
