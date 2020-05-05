class Vehicle extends U3DObject{
  ArrayList<Wheel> wheels;
  PShape chassis;
  
  private boolean isSelected;
  private ArrayList<U3DObject> collidingEntities;
  
  Vehicle() {
    wheels = new ArrayList<Wheel>();
  }
  
  void display(){
    pushMatrix();
    translate(mPosition.x, mPosition.y, mPosition.z);
    
    shape(chassis, 0, 0);
    for(Wheel w: wheels){
        //TODO: Separate controls from animation 
       if(keyPressed == true && key == 'q'){
         w.setDir(45);
       } else if(keyPressed == true && key == 'd'){
         w.setDir(-45);
       } else {
         w.setDir(0);
       }
      w.move();
      w.display();
    }
    
    popMatrix();
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
  
  @Override
  boolean isSelectable(){
    return true;
  }
  
  @Override
  void setSelectionState(boolean state){
    isSelected = state;
    print(state);
  }
  
  
}
