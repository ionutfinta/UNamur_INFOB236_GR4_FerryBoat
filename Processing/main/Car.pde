class Car extends Vehicle {
  
  private boolean isSelected;
  
  Car(PVector pos){
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
  
  void animate(){
    super.animate();
    
    //TODO: Séparer les commandes des objets... un objet doit pouvoir être contrôlé que s'il est séléctionné
    if(keyPressed == true){
      if(key == 'z'){
        mInertia.z += .05f;
      }
      if(key == 'a'){
        mInertia.z += .05f;
        mInertia.x += .01f;
      }
      if(key == 'e'){
        mInertia.z += .05f;
        mInertia.x -= .01f;
      }
      if(key == 'q'){
        mInertia.x += .01f;
        mInertia.z -= .03f;
      }
      if(key == 'd'){
        mInertia.x -= .01f;
        mInertia.z -= .03f;
      }
      if(key == 's')
        mInertia.z -= .03f;
    }
  }
  
  @Override
  boolean isSelectable(){
    return true;
  }
  
  @Override
  void setSelectionState(boolean state){
    isSelected = state;    
  }
  
}
