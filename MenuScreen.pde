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
    //pushMatrix();
    rectMode(CENTER);
    translate(width/2, height/2);
    fill(0, 0, 0, 200);
    strokeWeight(5);
    stroke(255, 0, 0);
    rect(0, 0, width, height);

    drawInfo();
    //popMatrix();
  }

  void drawInfo() {
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
  }

  void mousePressed() {
    if (playButton.isMouseOver()) {
      gamePaused = false;
      noCursor();
      soundFilesSFX.get("SFX_menuClick").play();
      soundFilesMusic.get("SFX_backgroundTrack_1").rate(1);
    } else if (restartButton.isMouseOver()) {
      resetGame();
      gamePaused = false;
      noCursor();
      soundFilesSFX.get("SFX_menuClick").play();
      soundFilesMusic.get("SFX_backgroundTrack_1").rate(1);
    } else if (exitButton.isMouseOver()) {
      exit();
    } else if (volDecButton.isMouseOver()) {
      changeVolume(-0.001);
      soundFilesSFX.get("SFX_menuClick").play();
    } else if (volIncButton.isMouseOver()) {
      changeVolume(0.001);
      soundFilesSFX.get("SFX_menuClick").play();
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
    strokeWeight(1);
    stroke(100);
    rectMode(CENTER);
    fill(#BCE5E5);
    if (isMouseOver()) {
      fill(#00F9FF);
      if (!soundAlreadyPlayed) {
        soundFilesSFX.get("SFX_menuHover").play();
        soundAlreadyPlayed = true;
      }
    } else {
      soundAlreadyPlayed = false;
    }
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, x, y);
  }


  boolean isMouseOver() {
    return mouseX > x+width/2 - w/2 && mouseX < x+width/2 + w/2 && mouseY > y+height/2 - h/2 && mouseY < y+height/2 + h/2;
  }
}
