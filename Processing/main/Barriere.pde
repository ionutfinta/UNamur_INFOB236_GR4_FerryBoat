/** Gestionnaire des barrières au sol
  * Toute barrière a un corps principal et une lisse rotative.
  * Type mutable dans le respect des gardes Event-B
**/

class Barriere extends U3DObject {
  private fifthRef mEventB;
  private U3DObject myLisse;
  
  private boolean nOuvert;
  
  // --- Constructeurs
  // `angle` représente l'angle de la lisse (utile pour mettre 2 barrières en mirroir) */
  Barriere(Universe uni, fifthRef mac, PVector pos, PVector angle){
    super(uni, pos, "./assets/mainBarrier.obj");
    mEventB = mac;
    
    myLisse = new U3DObject(uni, new PVector(angle.y==PI?1.6403:-1.6403, .2, 0.260741).add(mPosition), "./assets/barrier.obj");
    myLisse.setRotationZCenter(new PVector(angle.y==PI?-0.51325:0.51325, 0).add(mPosition));
    myLisse.setAngles(angle);
    
    setSelectionState(false);
    
    nOuvert = false;
  }
  
  Barriere(Universe uni, fifthRef mac, PVector pos){
    this(uni, mac, pos, new PVector(0,0,0));
  }
  
  // -- Mutateurs privés
  private void setFerme(){
    myLisse.addAnimation("rotateZ", 0, 1000);
    nOuvert = false;
  }
  
  private void setOuvert(){
    myLisse.addAnimation("rotateZ", (myLisse.getAngles().y==PI?HALF_PI:-HALF_PI), 1000);
    nOuvert = true;
  }
  
  // --- Mutateurs publics
  public void switchState(){
    if(!isBusy()){
      if(isOuvert() && mEventB.evt_Switch_lift_access.guard_Switch_lift_access(false)){
        setFerme();
      }else if(!isOuvert() && mEventB.evt_Switch_lift_access.guard_Switch_lift_access(true)){
        setOuvert();
      }else{
        println("Les gardes Event-B empêchent de switcher l'état des barrières");
      }
    }
  }
  
  // --- Actualisation du statut en fonction de l'animation
  void display(){
    super.display();
    if(isBusy() && myLisse.getAnimations().size() == 0){
      // No problem for concurrency, the second Barriere is ignored because of guards.
      mEventB.evt_Switch_lift_access.run_Switch_lift_access(nOuvert);
    }
  }
  
  // --- Getters
  public boolean isOuvert(){
    return mEventB.get_lift_access();
  }
  
  public boolean isBusy(){
    return nOuvert != isOuvert();
  }
}
