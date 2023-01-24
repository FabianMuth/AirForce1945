class MenuScreen {
  Button playButton, restartButton, exitButton, volDecButton, volIncButton;

  public MenuScreen() {
    playButton = new Button(0, -50, 100, 50, "Play");
    restartButton = new Button(0, 0, 100, 50, "Restart");
    exitButton = new Button(0, 50, 100, 50, "Exit");
    volDecButton = new Button(-20, 110, 40, 40, "-");
    volIncButton = new Button(20, 110, 40, 40, "+");
  }

  void draw() {
    pushMatrix();
    translate(width/2, height/2);
    playButton.display();
    restartButton.display();
    exitButton.display();
    volDecButton.display();
    volIncButton.display();
    popMatrix();
  }

  void drawBackground() {
    pushMatrix();
    rectMode(CENTER);
    translate(width/2, height/2);
    fill(0, 0, 0, 200);
    strokeWeight(5);
    stroke(255, 0, 0);
    rect(0, 0, width, height);

    drawInfo();
    popMatrix();
  }

  void drawInfo() {
    pushMatrix();
    translate(0, height/4);
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(255);
    smooth();
    text("ESC or P  ...  toggle Menu / Pause Game", 0, 0);
    text("W,A,S,D  ...  move Player", 0, 25);
    text("Left Click  ...  Shoot", 0, 50);
    text("F  ...  toggle FPS Tracker", 0, 75);
    text("H  ...  toggle Hitboxes", 0, 100);
    popMatrix();
  }

  void mousePressed() {
    if (playButton.isMouseOver()) {
      gamePaused = false;
      noCursor();
      AudioPlayersSFX.get("SFX_menuClick").play(0);
      //AudioPlayersMusic.get("SFX_backgroundTrack_1").rate(1);
    } else if (restartButton.isMouseOver()) {
      resetGame();
      gamePaused = false;
      noCursor();
      AudioPlayersSFX.get("SFX_menuClick").play(0);
      //AudioPlayersMusic.get("SFX_backgroundTrack_1").rate(1);
    } else if (exitButton.isMouseOver()) {
      exit();
    } else if (volDecButton.isMouseOver()) {
      changeVolume(-2);
      AudioPlayersSFX.get("SFX_menuClick").play(0);
    } else if (volIncButton.isMouseOver()) {
      changeVolume(2);
      AudioPlayersSFX.get("SFX_menuClick").play(0);
    }
  }
}

class Button {
  float x, y;
  float w, h;
  String text;
  boolean soundAlreadyPlayed = false;

  Button(float x, float y, float w, float h, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }

  void display() {
    pushMatrix();
    strokeWeight(1);
    stroke(0);
    rectMode(CENTER);
    fill(#00FDFF);
    if (isMouseOver()) {
      fill(#00CCCE);
      if (!soundAlreadyPlayed) {
        AudioPlayersSFX.get("SFX_menuHover").play(0);
        soundAlreadyPlayed = true;
      }
    } else {
      soundAlreadyPlayed = false;
    }
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(text, x, y);
    popMatrix();
  }


  boolean isMouseOver() {
    return mouseX > x+width/2 - w/2 && mouseX < x+width/2 + w/2 && mouseY > y+height/2 - h/2 && mouseY < y+height/2 + h/2;
  }
}
