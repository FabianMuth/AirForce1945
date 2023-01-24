/**
 * A game like 1945 Air Force / 1943 The Battle of Midway but in space.
 * @author Fabian Muth
 * @version 24-01-2023
 *
 * TODO: add more enemies, add glow shader, add health bar, add bullet sprite, add 3dterrain speed incerase over time, add abilities, improve enemy spawner, change ScoreCounter from local to github
         Endboss: add boss music.
 * BUGS: Menu Screen not working correctly at game start in fullscreen. Terrain3D size does not update on screen size change. Pressing ESC after the after the player died exits the program.
 *
 * CHANGELIST: Changed library SoundFile -> Minim. Changed deltaTime: is now global and calculated more accurate (now works with varying fps). Bugfix: No more Sound distortion after ~2min playtime. Game speed no longer way too fast in the first seconds of the first round.
 */

import ddf.minim.*;
import gifAnimation.*;

static String version = "2.9";

PApplet thisMain = this;

public static boolean displayHitbox = false;
public static boolean gamePaused = false;
boolean roundOngoing = true;
int bossSpawnTime = 30;
float gameOverTime = 0;
float afterDeathTime = 5;
float deltaTime, previousTime, currentTime;

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

PImage coverImage;
MenuScreen menuScreen;
ScoreCounter scoreCounter;
FPSTracker fpsTracker;
boolean showFpsTracker = true;

Minim minim;
public float defaultVolumeGain = -30; //decibels
public String soundFXPath = "data\\SFX\\";
public String soundMusicPath = "data\\SFX\\music\\";
public HashMap<String, AudioPlayer> AudioPlayersSFX = new HashMap<String, AudioPlayer>();
public HashMap<String, AudioPlayer> AudioPlayersMusic = new HashMap<String, AudioPlayer>();

void settings() {
  size(720, 900, P3D);
  //fullScreen(P3D);
}

void setup() {
  surface.setTitle("1945 Air Force - Fabian Muth [mt221092] - V" + version);
  surface.setResizable(true);
  PFont font = createFont("Arial", 48); //big font so no blur/pixelating appears.
  textFont(font);
  frameRate(60);

  coverImage = loadImage("data\\coverImage_04.png");
  coverImage.resize(width, height);
  image(coverImage, 0, 0);

  previousTime = millis();
  terrain = new Terrain3D(20, 0.01);
  galaxy = new Galaxy(1, 10);
  minim = new Minim(this);
  loadSounds();
  resetGame();
}

void draw() {
  calculateDeltaTime();
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
  //long totalMemory = Runtime.getRuntime().totalMemory();
  //long freeMemory = Runtime.getRuntime().freeMemory();
  //long cacheSize = totalMemory - freeMemory;
  //println("Cache size: " + freeMemory/1000 + " bytes");
}

void endGame() {
  println("GAME OVER");
  roundOngoing = false;
  gameOverTime = millis();
  scoreCounter.saveScore();
}

void resetGame() {
  println("\nRESETTING GAME");
  player = new Player();
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  enemyBullets = new ArrayList<Bullet>();
  explosions = new ArrayList<ParticleExplosion>();

  if (enemyManager != null) enemyManager.stopTimer();
  enemyManager = new EnemyManager();
  collisionManager = new CollisionManager();
  explosionManager = new ExplosionManager();

  menuScreen = new MenuScreen();
  if (!roundOngoing) menuScreen.drawBackground();
  scoreCounter = new ScoreCounter(width-60, 10);
  fpsTracker = new FPSTracker(600, 10, 10, 80, 40, 15);

  AudioPlayersMusic.get("SFX_backgroundTrack_1").play(500);
  //AudioPlayersMusic.get("SFX_backgroundTrack_1").speed();

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
  AudioPlayersSFX.put("SFX_playerShooting", minim.loadFile(soundFXPath + "pew-laser-fx_G_major.wav")); //<>//
  AudioPlayersSFX.put("SFX_enemyShooting", minim.loadFile(soundFXPath + "laser-like-percussion-synthetic-transients-short-laser-faller.wav"));
  AudioPlayersSFX.put("SFX_playerDeath", minim.loadFile(soundFXPath + "stab-snail-house-style-2.wav"));
  AudioPlayersSFX.put("SFX_enemyDeath", minim.loadFile(soundFXPath + "chiptune-click-fx_A_minor.wav"));
  AudioPlayersSFX.put("SFX_enemyHit", minim.loadFile(soundFXPath + "8-bit-jump_130bpm_C_minor.wav"));
  AudioPlayersSFX.put("SFX_boss_laser1", minim.loadFile(soundFXPath + "analog-bass-rock-ring-808_C_major.wav"));
  AudioPlayersSFX.put("SFX_boss_laser2", minim.loadFile(soundFXPath + "808-bass-hard-overdrive_D.wav"));
  AudioPlayersSFX.put("SFX_boss_missile", minim.loadFile(soundFXPath + "edm-kit-synth-fx-beep-2_C_minor.wav"));
  AudioPlayersSFX.put("SFX_menuHover", minim.loadFile(soundFXPath + "wood-tap-click.wav"));
  AudioPlayersSFX.put("SFX_menuClick", minim.loadFile(soundFXPath + "ping-bing_E_major.wav"));

  //Music
  AudioPlayersMusic.put("SFX_backgroundTrack_1", minim.loadFile(soundMusicPath + "MegaMan2_Wily1_2Remix_MMC8-bit_converted.wav"));
  AudioPlayersMusic.put("SFX_menuTrack", minim.loadFile(soundMusicPath + "MegaMan2_Wily1_2Remix_MMC8-bit_converted.wav"));

  //set Volumes
  setVolume(AudioPlayersSFX, defaultVolumeGain);
  setVolume(AudioPlayersMusic, defaultVolumeGain);
}

public void setVolume(HashMap<String, AudioPlayer> AudioPlayers, float volume) {
  for (AudioPlayer audio : AudioPlayers.values()) {
    audio.setGain(volume);
  }
}

public void changeVolume(float deltaVolumeGain) {
  defaultVolumeGain += deltaVolumeGain;
  //volume = constrain(volume, 0, 1);
  println(defaultVolumeGain);
  println(deltaVolumeGain);
  setVolume(AudioPlayersSFX, defaultVolumeGain);
  setVolume(AudioPlayersMusic, defaultVolumeGain);
}

void calculateDeltaTime(){
  currentTime = millis();
  deltaTime = (currentTime - previousTime) / 1000.0;
  //println("deltaTime: " + deltaTime);
  previousTime = currentTime;
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
