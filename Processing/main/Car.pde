class Car extends Vehicle {
  
  Car(){
    chassis = loadShape("./assets/car_chassis.obj");
    mPosition = new PVector(14.515, 0.0, 100);
    
    float frontPos = 0.86,
           wh_height = -0.44,
           backPos = 1.27;
    
    wheels.add(new Wheel(this, frontPos, wh_height, backPos, 180, true));
    wheels.add(new Wheel(this, frontPos, wh_height,-backPos, 180, false));
    wheels.add(new Wheel(this, -frontPos,wh_height, backPos, 000, true));
    wheels.add(new Wheel(this, -frontPos,wh_height,-backPos, 000, false));
    
    mInertia = new PVector(8,0,0);
  }
  
  void animate(int gravity){
    super.animate(gravity);
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
  
}
