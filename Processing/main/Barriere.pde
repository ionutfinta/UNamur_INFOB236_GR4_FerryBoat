/** Gestionnaire des barrières au sol
  * Toute barrière a un corps principal et une lisse rotative.
  * Type mutable dans le respect des gardes Event-B
**/

class Barriere extends U3DObject {
  private U3DObject myLisse;
  
  private boolean nOuvert, isOuvert, ignoreEventB;
  
  // --- Constructeurs
  // `angle` représente l'angle de la lisse (utile pour mettre 2 barrières en mirroir) */
  Barriere(Universe uni, PVector pos, PVector angle){
    super(uni, pos, "./assets/mainBarrier.obj");
    
    myLisse = new U3DObject(uni, new PVector(angle.y==PI?1.6403:-1.6403, .2, 0.260741).add(mPosition), "./assets/barrier.obj");
    myLisse.setRotationZCenter(new PVector(angle.y==PI?-0.51325:0.51325, 0).add(mPosition));
    myLisse.attachObject(this);
    myLisse.setAngles(angle);
    
    isOuvert = false;
    nOuvert = true;
    ignoreEventB = false;
  }
  
  Barriere(Universe uni, PVector pos){
    this(uni, pos, new PVector(0,0,0));
  }
  
  Barriere(Universe uni, PVector pos, boolean ignoreB){
    this(uni, pos, new PVector(0,0,0));
    ignoreEventB = ignoreB;
  }
  
  Barriere(Universe uni, PVector pos, PVector angle, boolean ignoreB){
    this(uni, pos, angle);
    ignoreEventB = ignoreB;
  }
  
  // -- Mutateurs privés
  private void setFerme(){
    myLisse.addAnimation("rotateZ", 0, 1000);
    isOuvert = false;
  }
  
  private void setOuvert(){
    myLisse.addAnimation("rotateZ", (myLisse.getAngles().y==PI?HALF_PI:-HALF_PI), 1000);
    isOuvert = true;
  }
  
  // --- Mutateurs publics
  public boolean switchState(){
    if(isBusy()){ return false; }
    
    if(!ignoreEventB){
      if(isOuvert() && myEventBMachine.evt_Switch_lift_access.guard_Switch_lift_access(false)){
        setFerme();
        myEventBMachine.evt_Switch_lift_access.run_Switch_lift_access(false);
        return true;
      }else if(!isOuvert() && myEventBMachine.evt_Switch_lift_access.guard_Switch_lift_access(true)){
        setOuvert();
        myEventBMachine.evt_Switch_lift_access.run_Switch_lift_access(true);
        return true;
      }else{
        println("Les gardes Event-B empêchent de switcher l'état des barrières");
        return false;
      }
    }
    
    if(isOuvert())
      setFerme();
    else
      setOuvert();
    return true;
  }
  
  // --- Actualisation du statut en fonction de l'animation
  void display(){
    super.display();
    if(isBusy() && myLisse.getAnimations().size() == 0){
      nOuvert = isOuvert;
    }
  }
  
  // --- Getters
  public boolean isOuvert(){
    if(ignoreEventB){return isOuvert;}
    
    return myEventBMachine.get_lift_access();
  }
  
  public boolean isBusy(){
    return nOuvert != isOuvert();
  }
  
  U3DObject lisse(){
    return myLisse;
  }
}
