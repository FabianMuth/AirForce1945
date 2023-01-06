class MenuScreen {
  Button playButton;
  Button restartButton;
  Button exitButton;

  public MenuScreen() {
    playButton = new Button(0, -50, 100, 50, "Play");
    restartButton = new Button(0, 0, 100, 50, "Restart");
    exitButton = new Button(0, 50, 100, 50, "Exit");
  }

  void draw() {
    pushMatrix();
    translate(width/2, height/2);
    playButton.display();
    restartButton.display();
    exitButton.display();
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
   //popMatrix();
  }

  void mousePressed() {
    if (playButton.isMouseOver()) {
      gamePaused = false;
    } else if (restartButton.isMouseOver()) {
      resetGame();
      gamePaused = false;
    } else if (exitButton.isMouseOver()) {
      exit();
    }
  }
}

class Button {
  float x, y;
  float w, h;
  String text;

  Button(float x, float y, float w, float h, String text) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }

  void display() {
    strokeWeight(1);
    stroke(0);
    rectMode(CENTER);
    fill(200);
    if (isMouseOver()) fill(0, 255, 100);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, x, y);
  }

  boolean isMouseOver() {
    return mouseX > x+width/2 - w/2 && mouseX < x+width/2 + w/2 && mouseY > y+height/2 - h/2 && mouseY < y+height/2 + h/2;
  }
}
