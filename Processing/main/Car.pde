class Car extends Vehicle {
  
  final float SPEED_MULT = 1;
  
  
  Car(Universe u, PVector pos){
    super(u);
    mShape = loadShape("./assets/car_chassis.obj");
    mPosition = pos;
    
    float frontPos = 0.86,
           wh_height = 0.44,
           backPos = 1.27;
    
    wheels.add(new Wheel(this, frontPos, wh_height, backPos, 180, true));
    wheels.add(new Wheel(this, frontPos, wh_height,-backPos, 180, false));
    wheels.add(new Wheel(this, -frontPos,wh_height, backPos, 000, true));
    wheels.add(new Wheel(this, -frontPos,wh_height,-backPos, 000, false));
    
   
    everything = u.objs;
  
    setSelectionState(false);
  }
  
  void animate(){
    super.animate();
    
    if(keyPressed == true && isSelected()){
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
        
      mInertia.z*=SPEED_MULT;
      mInertia.x*=SPEED_MULT;
    }
  }
}
