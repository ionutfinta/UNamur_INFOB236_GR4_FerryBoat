class Vehicle extends U3DObject{
  ArrayList<Wheel> wheels;
  PShape chassis;
  
  private boolean isSelected;
  private boolean entityColliding;
  
  Vehicle() {
    wheels = new ArrayList<Wheel>();
  }
  
  void display(){
    pushMatrix();
    scale(uniScale);
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
  void setEntityColliding(boolean state){
    entityColliding = state;
  }
  
  @Override 
  boolean entityColliding(){
    return entityColliding;
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
