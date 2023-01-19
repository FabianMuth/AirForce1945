class FPSTracker {
  int numValues;
  float[] values;
  float x, y, w, h;
  float fontSize;
  float avgFPS = 1;
  float highestFrameRateRecorded = 60;

  FPSTracker(int num, float xpos, float ypos, float width, float height, float fontSize) {
    numValues = num;
    values = new float[numValues];
    x = xpos;
    y = ypos;
    w = width;
    h = height;
    this.fontSize = fontSize;
  }

  void update() {
    for (int i = 0; i < numValues-1; i++) {
      values[i] = values[i+1];
      if (values[i] > highestFrameRateRecorded) highestFrameRateRecorded = values[i];
    }

    values[numValues-1] = frameRate;
  }

  void draw() {
    pushMatrix();
    //frame
    fill(255, 128);
    stroke(255);
    rect(x, y, w, h);
    
    //diagram
    stroke(0);
    strokeWeight(1);
    fill(0, 0, 255, 128);
    rectMode(CORNER);

    beginShape();
    for (int i = 0; i < numValues; i++) {
      float xpos = map(i, 0, numValues, 0, w);
      float ypos = map(values[i], 0, highestFrameRateRecorded, h, 0);
      vertex(x+xpos, y+ypos);
    }
    vertex(x+w, y+h);
    vertex(x, y+h);
    endShape(CLOSE);

    

    //display average fps
    for (int i = numValues-61; i < numValues; i++) {
      avgFPS += values[i];
    }
    avgFPS /= 60;
    fill(255, 255, 255, 200);
    textAlign(CENTER, CENTER);
    textSize(fontSize);
    text(round(avgFPS), x+w+10, y+h/2);
    popMatrix();
  }
}
