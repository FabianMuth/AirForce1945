class ParticleExplosion {
  int x, y, numParticles;
  Particle[] particles;

  ParticleExplosion(int x, int y, int numParticles) {
    this.x = x;
    this.y = y;
    this.numParticles = numParticles;
    particles = new Particle[numParticles];
    for (int i = 0; i < numParticles; i++) {
      particles[i] = new Particle(x, y);
    }
  }

  ParticleExplosion(int x, int y, int numParticles, int force) {
    this.x = x;
    this.y = y;
    this.numParticles = numParticles;
    particles = new Particle[numParticles];
    for (int i = 0; i < numParticles; i++) {
      particles[i] = new Particle(x, y, force);
    }
  }

  void update() {
    for (int i = 0; i < numParticles; i++) {
      particles[i].update();
    }
  }

  void draw() {
    for (int i = 0; i < numParticles; i++) {
      particles[i].draw();
    }
  }

  boolean isDone() {
    for (int i = 0; i < numParticles; i++) {
      if (particles[i].life <= particles[i].maxLife) {
        return false;
      }
    }
    return true;
  }
}
