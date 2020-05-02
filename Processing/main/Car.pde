class Car extends Vehicle {
  
  Car(){
    chassis = loadShape("./assets/car_chassis.obj");
    mPosition = new PVector(14.515, -5.0, 122.696);
    
    float frontPos = 0.86,
           wh_height = -0.44,
           backPos = 1.27;
    
    wheels.add(new Wheel(this, frontPos, wh_height, backPos, 180, true));
    wheels.add(new Wheel(this, frontPos, wh_height,-backPos, 180, false));
    wheels.add(new Wheel(this, -frontPos,wh_height, backPos, 000, true));
    wheels.add(new Wheel(this, -frontPos,wh_height,-backPos, 000, false));
  }
  
}
