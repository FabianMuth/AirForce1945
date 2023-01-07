class ExplosionManager {
  public ExplosionManager() {
  }

  void manageExplosions() {
    //println("expl: " + explosions.size());
    
    Iterator<ParticleExplosion> it = explosions.iterator();
    while (it.hasNext()) {
      ParticleExplosion pex = it.next();
      if (pex.isDone()) {
        it.remove();
      } else {
        pex.update();
        pex.draw();
      }
    }
  }
}
