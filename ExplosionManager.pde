class ExplosionManager{
 public ExplosionManager(){
   
 }
 
 void manageExplosions(){
   for(int i = 0; i < explosions.size(); i++){
     explosions.get(i).update();
     explosions.get(i).draw();
   }
 }
}
