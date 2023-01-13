// DEPRECATED
public static class Settings extends PApplet {
  public static boolean displayHitbox = false;
  public boolean gamePaused = false;
  public boolean roundOngoing = true;
  public float gameOverTime = 0;
  public float afterDeathTime = 5;
  public boolean showFpsTracker = true;

  public String soundFXPath = "data\\SFX\\";
  public String soundMusicPath = "data\\SFX\\music\\";
  public HashMap<String, SoundFile> soundFiles = new HashMap<String, SoundFile>();
  //SoundFile SFX_backgroundTrack_1;
  //SoundFile SFX_playerShooting;

  public void loadSounds() {
    soundFiles.put("SFX_backgroundTrack_1", new SoundFile(this, soundMusicPath + "MegaMan2_Wily1_2Remix_MMC8-bit_converted.wav"));
    soundFiles.put("SFX_playerShooting", new SoundFile(this, soundMusicPath + "pew-laser-fx_G_major.wav"));
  }
}
