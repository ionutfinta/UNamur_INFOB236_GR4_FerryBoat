class SelectionDetectorObject extends U3DObject{
  ArrayList<Wheel> wheels;
  PShape chassis;
  
  private boolean isSelected;
  private ArrayList<U3DObject> collidingEntities;
  
  SelectionDetectorObject() {
    
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
  void removeCollidingEntities(){
    collidingEntities = new ArrayList<U3DObject>();
  }
  
  @Override 
  ArrayList<U3DObject> collidingEntities(){
    return collidingEntities;
  }
  
  
}
