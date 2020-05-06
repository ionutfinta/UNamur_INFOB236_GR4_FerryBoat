class Barriere extends U3DObject {
  PShape tige;
  private float mAngleBarriere;
  
  private boolean isSelected;
  private ArrayList<U3DObject> collidingEntities;
  
  Barriere(PVector pos, PVector angles){
    mPosition = pos;
    mAngles = angles;
    
    mShape = loadShape("./assets/mainBarrier.obj");
    tige = loadShape("./assets/barrier.obj");
    mAngleBarriere = 0;
    
    setSelectionState(false);
  }
  
  void display(){
    pushMatrix();
    //barriers test
      translate(mPosition.x, mPosition.y, mPosition.z);
      shape(mShape);
      translate(0, +.55, 0.260741);
      rotateX(mAngles.x);
      rotateY(mAngles.y);
      rotateZ(mAngles.z);
      //rotate(mAngleBarriere);
      shape(tige);
    popMatrix();
  }
  
  void setFerme(){
    //TODO: A lier avec les guardes Event-B !
    //TODO: Animer le passage d'un état à un autre
    mAngles.z = 0;
  }
  
  void setOuvert(){
    //TODO: A lier avec les guardes Event-B !
    //TODO: Animer le passage d'un état à un autre
    mAngles.z = -HALF_PI;
  }
    
  
  @Override
  boolean isSelectable(){
    return true;
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
