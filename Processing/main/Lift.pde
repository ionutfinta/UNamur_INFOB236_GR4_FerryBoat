/** Gestionnaire du monte-charges
  * Le monte-charge est doué d'une structure, de barrières, d'une plateforme mobile ainsi que de capteurs.
  * Type mutable dans le respect des gardes Event-B
**/

class Lift extends U3DObject {
  private fifthRef mEventB;
  //GF = Garde-Fou
  private U3DObject mPlateforme, mGF1, mGF2;
  
  private boolean nOuvert, isOuvert;
  
  // --- Constructeurs
  Lift(Universe uni, fifthRef mac, PVector pos){
    super(uni, pos, "./assets/liftStructure.obj");
    mEventB = mac;
    mCollide = false;
    mShape.setName("noStroke");

    mPlateforme = new U3DObject(uni, new PVector(0,11.7321,0).add(mPosition), "./assets/lift.obj");
    mGF1 = new U3DObject(uni, new PVector(6.14,12.7321,0).add(mPosition), "./assets/lift_gardeFou.obj");
    mGF2 = new U3DObject(uni, new PVector(-6.14,12.7321,0).add(mPosition), "./assets/lift_gardeFou.obj");
    mGF2.setAngles(new PVector(0,PI,0));
    /*isOuvert = false;
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
