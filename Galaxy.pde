class Galaxy {
  ArrayList<PShape> rings = new ArrayList<PShape>();
  int speed = 10;
  float step = 0;

  public Galaxy(int incr, int speed) {
    this.speed = speed;

    float innerRad = 1f, outerRad = 9f, increment = 1f;
    for (int ringIndex = 0; ringIndex < 50; ringIndex++) {
      PShape ring = createShape();
      ring.setStrokeWeight(1.5f);
      ring.beginShape(POINTS);
      //ring.stroke(lerpColor(color(73, 115, 161), color(157, 47, 77), ringIndex/50f), 100f);
      ring.stroke(lerpColor(#00F9FF, #FF00B7, ringIndex/50f), 100f);
      for (int starIndex = 0; starIndex < 3000; starIndex++) {
        float a = random(0f, 1f) * TWO_PI;
        float r = sqrt(random(sq(innerRad), sq(outerRad)));
        //println(r*cos(a) + ",  " + r*sin(a));
        ring.vertex(r * cos(a), r * sin(a), random(-increment, increment));
      }
      ring.endShape();
      rings.add(ring);
      innerRad += increment;
      outerRad += increment*1.5f;
      increment += incr;
    }
  }

  void drawGalaxy() {
    blendMode(ADD);
    step++;
    for (int index = 0; index < 50; index++) {
      pushMatrix();
      //------------------------------------
      translate(width/2.0, height/6, -2300);
      rotateY((TWO_PI/(index*index)*step)/speed);
      //----rotateX(1.45f);
      rotateX(2f);
      shape(rings.get(index));
      popMatrix();
    }
    blendMode(BLEND);
  }
}
