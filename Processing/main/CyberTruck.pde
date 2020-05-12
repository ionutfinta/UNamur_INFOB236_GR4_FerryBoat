class CyberTruck extends Vehicle {
  CyberTruck(Universe u, PVector pos){
    super(u, pos, "./assets/CyberTruck.obj");
    mWheelShape = "./assets/CyberTruck_wheels.obj";
    
    float frontPos = 0.66,
           wh_height = -0.504888,
           backPos = 1.44;
    
    mWheelsPos = new PVector[4];
    mWheelsPos[0] = new PVector(frontPos+.15, wh_height, backPos);
    mWheelsPos[1] = new PVector(-frontPos,wh_height, backPos);
    mWheelsPos[2] = new PVector(frontPos+.15, wh_height,-backPos+0.08);
    mWheelsPos[3] = new PVector(-frontPos,wh_height,-backPos+0.08);
    
    mWheelsAngles = new PVector[4];
    mWheelsAngles[0] = new PVector(0, 0, 0);
    mWheelsAngles[1] = new PVector(0, PI, 0);
    mWheelsAngles[2] = new PVector(0, 0, 0);
    mWheelsAngles[3] = new PVector(0, PI, 0);
    
    initWheels();
    
    everything = u.objs;
  
    setSelectionState(false);
  }
  
  
  @Override
  int getVehicleType(){
    return myEventBMachine.camion_1;
  }
}
