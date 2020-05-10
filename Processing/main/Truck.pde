class Truck extends Vehicle {
  Truck(Universe u, PVector pos){
    super(u, pos, "./assets/truck.obj");
    /*mWheelShape = "./assets/car_wheel.obj";
    
    float frontPos = 0.86,
           wh_height = -0.46,
           backPos = 1.27;
    
    mWheelsPos = new PVector[4];
    mWheelsPos[0] = new PVector(frontPos, wh_height, backPos);
    mWheelsPos[1] = new PVector(-frontPos,wh_height, backPos);
    mWheelsPos[2] = new PVector(frontPos, wh_height,-backPos);
    mWheelsPos[3] = new PVector(-frontPos,wh_height,-backPos);
    
    mWheelsAngles = new PVector[4];
    mWheelsAngles[0] = new PVector(0, 0, 0);
    mWheelsAngles[1] = new PVector(0, PI, 0);
    mWheelsAngles[2] = new PVector(0, 0, 0);
    mWheelsAngles[3] = new PVector(0, PI, 0);
    
    initWheels();
    
    everything = u.objs;
  
    setSelectionState(false);*/
  }
}
