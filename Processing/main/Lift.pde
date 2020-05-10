/** Gestionnaire du monte-charges
  * Le monte-charge est doué d'une structure, de barrières, d'une plateforme mobile ainsi que de capteurs.
  * Type mutable dans le respect des gardes Event-B
**/

class Lift extends U3DObject {
  private fifthRef mEventB;
  private U3DObject myLisse;
  
  private boolean nOuvert, isOuvert;
  
  // --- Constructeurs
  Lift(Universe uni, fifthRef mac, PVector pos){
    super(uni, pos, "./assets/liftStructure.obj");
    mEventB = mac;
    mCollide = false;
    mShape.setName("noStroke");
    /*myLisse = new U3DObject(uni, new PVector(angle.y==PI?1.6403:-1.6403, .2, 0.260741).add(mPosition), "./assets/barrier.obj");
    myLisse.setRotationZCenter(new PVector(angle.y==PI?-0.51325:0.51325, 0).add(mPosition));
    myLisse.setAngles(angle);
    
    isOuvert = false;
    nOuvert = true;*/
  }
  
  // -- Mutateurs privés
  /*private void setFerme(){
    myLisse.addAnimation("rotateZ", 0, 1000);
    isOuvert = false;
  }
  
  private void setOuvert(){
    myLisse.addAnimation("rotateZ", (myLisse.getAngles().y==PI?HALF_PI:-HALF_PI), 1000);
    isOuvert = true;
  }*/
  
  // --- Mutateurs publics
  
  // --- Actualisation du statut en fonction de l'animation
  
  // --- Getters
}
