class Barriere extends U3DObject {
  PShape base, tige;
  
  private boolean isSelected;
  private ArrayList<U3DObject> collidingEntities;
  
  Barriere(PVector pos){
    mPosition = pos;
    mSize = new PVector(2,3,1);
    
    base = loadShape("./assets/mainBarrier.obj");
    tige = loadShape("./assets/barrier.obj");
    
    setSelectionState(false);
  }
  
  void display(){
    pushMatrix();
    //barriers test
      scale(.2);
      translate(mPosition.x*5, mPosition.y, mPosition.z*5);
      shape(base);
      translate(0, -5, 1);
      rotate(HALF_PI);
      shape(tige);
    popMatrix();
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
