class Limousine extends Vehicle {
  Limousine(Universe u, PVector pos){
    super(u, pos, "./assets/limousine_chassis.obj");
    mWheelShape = "./assets/car_wheel.obj";
    
    float frontPos = 0.80754,
           wh_height = -0.43194,
           backPos = 5.07;
    
    mWheelsPos = new PVector[4];
    mWheelsPos[0] = new PVector(frontPos, wh_height, backPos);
    mWheelsPos[1] = new PVector(-frontPos+.1,wh_height, backPos);
    mWheelsPos[2] = new PVector(frontPos, wh_height,-backPos);
    mWheelsPos[3] = new PVector(-frontPos+.1,wh_height,-backPos);
    
    mWheelsAngles = new PVector[4];
    mWheelsAngles[0] = new PVector(0, 0, 0);
    mWheelsAngles[1] = new PVector(0, PI, 0);
    mWheelsAngles[2] = new PVector(0, 0, 0);
    mWheelsAngles[3] = new PVector(0, PI, 0);
    
    initWheels();
    
    everything = u.objs;
  
    setSelectionState(false);
  }
}
