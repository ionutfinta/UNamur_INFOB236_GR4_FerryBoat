/** Gestionnaire des barrières. **/

class Barriere extends U3DObject {
  private boolean isSelected;
  private ArrayList<U3DObject> collidingEntities;
  
  private U3DObject myTige;
  
  //TODO: Lier a la machine Rodin
  private boolean isOuvert, nOuvert;
  
  // --- Constructeur(s)
  /** `angles` représente l'angle de la tige */
  Barriere(PVector pos, PVector angles, Universe uni){
    mPosition = pos;
    
    mShape = loadShape("./assets/mainBarrier.obj");
    myTige = new U3DObject();
    myTige.setShapeSRC("./assets/barrier.obj");
    myTige.setPlanet(mPlanet);
    myTige.setPos(new PVector(angles.y==PI?1.6403:-1.6403, .2, 0.260741).add(mPosition));
    myTige.setRotationZCenter(new PVector(angles.y==PI?-2.51325:2.51325, 0).add(mPosition));
    myTige.setAngles(angles);
    uni.addObject(myTige);
    setSelectionState(false);
    
    isOuvert = nOuvert = false;
  }
  
  // -- Mutateurs privés
  private void setFerme(){
    //TODO: A lier avec les guardes Event-B !
    
    myTige.addAnimation("rotateZ", 0, 1000);
    nOuvert = false;
  }
  
  private void setOuvert(){
    //TODO: A lier avec les guardes Event-B !
    myTige.addAnimation("rotateZ", (myTige.getAngles().y==PI?HALF_PI:-HALF_PI), 1000);
    nOuvert = true;
  }
  
  // --- Mutateurs publics
  public void switchState(){
    if(!isBusy()){
      if(isOuvert)
        setFerme();
      else
        setOuvert();
    }
  }
  
  // --- Actualisation du statut en fonction de l'animation
  void display(){
    super.display();
    if(isBusy() && myTige.getAnimations().size() == 0)
      isOuvert = nOuvert;
  }
  
  // --- Getters
  public boolean isOuvert(){
    return isOuvert;
  }
  
  public boolean isBusy(){
    return nOuvert != isOuvert;
  }
  
  @Override
  boolean isSelectable(){
    return true;
  }
  
  @Override
  boolean isSelected(){
    return isSelected;
  }
  
  @Override
  void setSelectionState(boolean state){
    isSelected = state;
  }
  
  
}
