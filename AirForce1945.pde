/**
 * A game like 1945 Air Force but worse.
 * @author Fabian Muth
 * @version 13-01-2023
 *
 * TODO: add endboss, add more enemies, add glow shader, add health bar, add bullet sprite, add 3dterrain speed incerase over time, add abilities, improve enemy spawner, change ScoreCounter from local to github
 * BUGS: Menu Screen not working correctly at game start in fullscreen. Game speed way too fast in the first seconds of the first round. Terrain3D size does not update on screen size change.
 *
 * CHANGELIST: Added SFX: player hit/death, player death, menu hover/click. Added music speed change on play/restart.
 */

import processing.sound.*;

static String version = "2.5";

public static boolean displayHitbox = false;
public static boolean gamePaused = false;
boolean roundOngoing = true;
float gameOverTime = 0;
float afterDeathTime = 5;

Terrain3D terrain;
Galaxy galaxy;

Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Bullet> enemyBullets;
ArrayList<ParticleExplosion> explosions;

EnemyManager enemyManager;
CollisionManager collisionManager;
ExplosionManager explosionManager;

MenuScreen menuScreen;
ScoreCounter scoreCounter;
FPSTracker fpsTracker;
boolean showFpsTracker = true;

public float volume = 0.01;
public String soundFXPath = "data\\SFX\\";
public String soundMusicPath = "data\\SFX\\music\\";
public HashMap<String, SoundFile> soundFilesSFX = new HashMap<String, SoundFile>();
public HashMap<String, SoundFile> soundFilesMusic = new HashMap<String, SoundFile>();

void settings() {
  size(700, 900, P3D);
  //fullScreen(P3D);
}

void setup() {
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  PFont font = createFont("Arial", 48);
  textFont(font);
  frameRate(60);

  terrain = new Terrain3D(20, 0.001);
  galaxy = new Galaxy(1, 10);
  loadSounds();
  resetGame();
}

void draw() {
  if (!gamePaused) {
    background(0);
    terrain.drawTerrain();
    galaxy.drawGalaxy();

    //update bullets
    for (int i = bullets.size()-1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      if (b.isOffScreen() || b.getHealth() <= 0) {
        bullets.remove(b);
      } else {
        b.move();
        b.draw();
      }
    }

    //update enemyBullets
    for (int i = enemyBullets.size()-1; i >= 0; i--) {
      Bullet eb = enemyBullets.get(i);
      if (eb.isOffScreen() || eb.getHealth() <= 0) {
        enemyBullets.remove(eb);
      } else {
        eb.move();
        eb.draw();
      }
    }

    enemyManager.manageEnemies();
    collisionManager.manageCollisions();
    explosionManager.manageExplosions();

    player.draw();
    scoreCounter.drawScore();
    if (showFpsTracker) {
      fpsTracker.update();
      fpsTracker.draw();
    }

    if (player.getHealth() <= 0 && roundOngoing) {
      player.die();
      endGame();
    }

    if (!roundOngoing && millis() - gameOverTime > afterDeathTime * 1000) {
      resetGame();
    }
  } else {
    cursor(CROSS);
    menuScreen.draw();
  }
}

void endGame() {
  println("GAME OVER");
  roundOngoing = false;
  gameOverTime = millis();
  scoreCounter.saveScore();
}

void resetGame() {
  println("RESETTING GAME");
  player = new Player();
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  enemyBullets = new ArrayList<Bullet>();
  explosions = new ArrayList<ParticleExplosion>();

  enemyManager = new EnemyManager();
  collisionManager = new CollisionManager();
  explosionManager = new ExplosionManager();

  menuScreen = new MenuScreen();
  menuScreen.drawBackground();
  scoreCounter = new ScoreCounter(width-60, 10);
  fpsTracker = new FPSTracker(600, 10, 10, 80, 40, 15);

  soundFilesMusic.get("SFX_backgroundTrack_1").jump(0.5);
  soundFilesMusic.get("SFX_backgroundTrack_1").rate(0.8);

  gamePaused = true;
  roundOngoing = true;
}

void keyPressed() {
  if ((key == 'p' || key == 27) && roundOngoing) {
    key = 0; //overwrite escape -> exit();
    gamePaused = !gamePaused;
    if (gamePaused) cursor(CROSS);
    else noCursor();
    menuScreen.drawBackground();
  }
  if (key == 'f') showFpsTracker = !showFpsTracker;
  if (key == 'h') displayHitbox = !displayHitbox;
  player.keyPressed();
}

public void loadSounds() {
  //SFX
  soundFilesSFX.put("SFX_playerShooting", new SoundFile(this, soundFXPath + "pew-laser-fx_G_major.wav"));
  soundFilesSFX.put("SFX_enemyShooting", new SoundFile(this, soundFXPath + "laser-like-percussion-synthetic-transients-short-laser-faller.wav"));
  soundFilesSFX.put("SFX_playerDeath", new SoundFile(this, soundFXPath + "stab-snail-house-style-2.wav"));
  soundFilesSFX.put("SFX_enemyDeath", new SoundFile(this, soundFXPath + "chiptune-click-fx_A_minor.wav"));
  soundFilesSFX.put("SFX_enemyHit", new SoundFile(this, soundFXPath + "8-bit-jump_130bpm_C_minor.wav"));
  soundFilesSFX.put("SFX_menuHover", new SoundFile(this, soundFXPath + "wood-tap-click.wav"));
  soundFilesSFX.put("SFX_menuClick", new SoundFile(this, soundFXPath + "ping-bing_E_major.wav"));

  //Music
  soundFilesMusic.put("SFX_backgroundTrack_1", new SoundFile(this, soundMusicPath + "MegaMan2_Wily1_2Remix_MMC8-bit_converted.wav"));
  soundFilesMusic.put("SFX_menuTrack", new SoundFile(this, soundMusicPath + "MegaMan2_Wily1_2Remix_MMC8-bit_converted.wav"));

  //set Volumes
  setVolume(soundFilesSFX, volume);
  setVolume(soundFilesMusic, volume);
}

public void setVolume(HashMap<String, SoundFile> soundFiles, float volume) {
  for (SoundFile sound : soundFiles.values()) {
    sound.amp(volume);
  }
}

public void changeVolume(float deltaVolume) {
  volume += deltaVolume;
  volume = constrain(volume, 0, 1);
  println(volume);
  setVolume(soundFilesSFX, volume);
  setVolume(soundFilesMusic, volume);
}

void keyReleased() {
  player.keyReleased();
}

void mousePressed() {
  player.mousePressed();
  if (gamePaused) menuScreen.mousePressed();
}

void mouseReleased() {
  player.mouseReleased();
}
