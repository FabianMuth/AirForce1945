/**
* A game like 1945 Air Force but worse.
* @author Fabian Muth
* @version 03-01-2023
*/

static String version = "1.1";
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
Player player;

void setup() {
  size(400, 600);
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  player = new Player(150, 550);
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
}

void draw() {
  background(200);

  player.draw();

  for (int i = 0; i < bullets.size(); i++) {
    Bullet b = bullets.get(i);
    b.move();
    b.draw();
  }

  for (int i = 0; i < enemies.size(); i++) {
    Enemy e = enemies.get(i);
    e.move();
    e.draw();
  }

  for (int i = 0; i < bullets.size(); i++) {
    for (int j = 0; j < enemies.size(); j++) {
      Bullet b = bullets.get(i);
      Enemy e = enemies.get(j);
      if (b.collidesWith(e)) {
        bullets.remove(i);
        enemies.remove(j);
      }
    }
  }

  if (random(1) < 0.01) {
    enemies.add(new Enemy());
  }
}

void keyPressed() {
  player.keyPressed();
}
void keyReleased() {
  player.keyReleased();
}

void mousePressed() {
  player.mousePressed();
}

void mouseReleased() {
  player.mouseReleased();
}
