class Van extends Vehicle {
  
  private boolean isSelected;
  //TODO: Ceci n'est oas un van, mais presque !
  
  Van(PVector pos){
    chassis = loadShape("./assets/car_chassis.obj");
    mPosition = pos;
    mSize = new PVector(2,0.7,4);
    
    float frontPos = 0.86,
           wh_height = -0.44,
           backPos = 1.27;
    
    wheels.add(new Wheel(this, frontPos, wh_height, backPos, 180, true));
    wheels.add(new Wheel(this, frontPos, wh_height,-backPos, 180, false));
    wheels.add(new Wheel(this, -frontPos,wh_height, backPos, 000, true));
    wheels.add(new Wheel(this, -frontPos,wh_height,-backPos, 000, false));
    
    setSelectionState(false);
  }
  
  @Override
  boolean isSelectable(){
    return true;
  }
  
  void setSelectionState(boolean state){
    isSelected = state;
  }
}
