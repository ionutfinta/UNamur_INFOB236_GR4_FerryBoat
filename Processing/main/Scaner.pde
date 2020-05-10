class Scaner extends U3DObject{

  fifthRef machine;
  boolean isLeft;
  
  Scaner(Universe uni, boolean is_left, fifthRef m){
    super(uni);
    everything = uni.objs;
    machine = m;
    mShape = loadShape("./assets/Scaner.obj");
    isLeft = is_left;
    if(isLeft){
      mPosition = new PVector(-19.5, 2.7, 115);
    }
    else{
      mPosition = new PVector(-12, 2.7, 115);
      mShape.rotate(PI, 0,1,0);
    }
    mCollide = true;
  }
  
  @Override
  void handle_collision(U3DObject collided){
    if(!collided instanceof SelectionDetectorObject)
      return;
    if(everything==null)
      return;
      
      print("ye");
    for(U3DObject o: everything){
      if(o instanceof Vehicle){
        Vehicle v = vehicleFromObject(o);
        PVector vPos = o.getPosition();
        PVector vSize = o.getSize();
          if(isLeft){
            if(vPos.x >= mPosition.x && vPos.x<= mPosition.x+vSize.x*4 && vPos.z >= mPosition.z-vSize.z*2 && vPos.z <= mPosition.z+vSize.z){
              
              if(v instanceof Car)
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.voiture, isLeft);
              if(v instanceof Truck)
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_2, isLeft);
              if(v instanceof Limousine)
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_3, isLeft);
            }
          }
          else{
            if(vPos.x <= mPosition.x && vPos.x >= mPosition.x-vSize.x*4 && vPos.z >= mPosition.z-vSize.z*2 && vPos.z <= mPosition.z+vSize.z){
              
              if(v instanceof Car)
                if(o instanceof Car)
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.voiture, isLeft);
              if(v instanceof Truck)
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_2, isLeft);
              if(v instanceof Limousine)
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_3, isLeft);
            }
          }
      }
    }
    
  }
}
