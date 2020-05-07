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
    myTige.setPos(new PVector(0, .55, 0.260741).add(mPosition));
    myTige.setAngles(angles);
    uni.addObject(myTige);
    setSelectionState(false);
    
    isOuvert = nOuvert = false;
  }
  
  // -- Mutateurs privés
  private void setFerme(){
    //TODO: A lier avec les guardes Event-B !
    myTige.addAnimation("rotateZrev", 0, 1000);
    nOuvert = false;
  }
  
  private void setOuvert(){
    //TODO: A lier avec les guardes Event-B !
    myTige.addAnimation("rotateZrev", -HALF_PI, 1000);
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
  
  
  @Override
  boolean doCollisions(){
    return true;
  }
  @Override
  void addCollidingEntity(U3DObject o){
    if(collidingEntities == null){
      collidingEntities = new ArrayList<U3DObject>();
    }
    collidingEntities.add(o);
  }
  
  @Override 
  ArrayList<U3DObject> collidingEntities(){
    return collidingEntities;
  }
  
  @Override
  void removeCollidingEntities(){
    collidingEntities = new ArrayList<U3DObject>();
  }
  
}
