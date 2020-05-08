class Car extends Vehicle {
  
  
  Car(PVector pos){
    mShape = loadShape("./assets/car_chassis.obj");
    mPosition = pos;
    
    float frontPos = 0.86,
           wh_height = 0.44,
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
        setAngleZ(-QUARTER_PI);
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
