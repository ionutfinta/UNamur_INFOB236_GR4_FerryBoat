class Barriere extends U3DObject {
  private boolean isSelected;
  private ArrayList<U3DObject> collidingEntities;
  
  private U3DObject myTige;
  
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
  }
  
  void setFerme(){
    //TODO: A lier avec les guardes Event-B !
    //TODO: Animer le passage d'un état à un autre
    myTige.setAngleZ(0);
  }
  
  void setOuvert(){
    //TODO: A lier avec les guardes Event-B !
    //TODO: Animer le passage d'un état à un autre
    myTige.setAngleZ(-HALF_PI);
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
