class Vehicle extends U3DObject{
  ArrayList<Wheel> wheels;
  
  private boolean isSelected;
  
  Vehicle() {
    wheels = new ArrayList<Wheel>();
  }
  
  void display(){
    super.display();
    pushMatrix();
    translate(mPosition.x, mPosition.y, mPosition.z);
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
    print(state);
  }
  
  
}
