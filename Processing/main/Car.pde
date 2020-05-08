class Car extends Vehicle {
  
  
  Car(PVector pos, Universe u){
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
        mInertia.z += .5f;
      }
      if(key == 'a'){
        mInertia.z += .5f;
        mInertia.x += .1f;
      }
      if(key == 'e'){
        mInertia.z += .5f;
        mInertia.x -= .1f;
      }
      if(key == 'q'){
        mInertia.x += .1f;
        mInertia.z -= .3f;
      }
      if(key == 'd'){
        mInertia.x -= .1f;
        mInertia.z -= .3f;
      }
      if(key == 's')
        mInertia.z -= .3f;
    }
  }
}
