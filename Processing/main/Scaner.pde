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
      mPosition = new PVector(-19.5, 2.7, 111);
    }
    else{
      mPosition = new PVector(-12, 2.7, 111);
      mShape.rotate(PI, 0,1,0);
    }
    mCollide = true;
  }
  
  @Override
  void handle_collision(U3DObject collided){
    if(!(collided instanceof SelectionDetectorObject))
      return;
    if(everything==null)
      return;
      
    
    for(U3DObject o: everything){
      if(o instanceof Vehicle){
        Vehicle v = vehicleFromObject(o);
        PVector vPos = o.getPosition();
        PVector vSize = o.getSize();
          if(isLeft){
            if(vPos.x >= mPosition.x && vPos.x<= mPosition.x+vSize.x*4 && vPos.z >= mPosition.z-vSize.z*2 && vPos.z <= mPosition.z+vSize.z){
              
              if(v instanceof Car){
                if(!machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.voiture, isLeft))
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.voiture, isLeft); 
                println("requesting authorization for id: ", v.getId());
              }
              else if(v instanceof CyberTruck){
                if( !machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.camion_1, isLeft) )
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_1, isLeft); 
                println("requesting authorization for id: ", v.getId());
                }
              else if(v instanceof Truck){
                if( !machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.camion_2, isLeft) )
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_2, isLeft); 
                println("requesting authorization for id: ", v.getId());
                }
              else if(v instanceof Limousine){
                if( !machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.camion_3, isLeft) )
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_3, isLeft); 
                println("requesting authorization for id: ", v.getId());}
            }
          }
          else{
            if(vPos.x <= mPosition.x && vPos.x >= mPosition.x-vSize.x*4 && vPos.z >= mPosition.z-vSize.z*2 && vPos.z <= mPosition.z+vSize.z){
              
              if(v instanceof Car){
                if(!machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.voiture, isLeft))
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.voiture, isLeft); 
                println("requesting authorization for id: ", v.getId());
              }
              else if(v instanceof CyberTruck){
                if( !machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.camion_1, isLeft) )
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_1, isLeft); 
                println("requesting authorization for id: ", v.getId());
                }
              else if(v instanceof Truck){
                if( !machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.camion_2, isLeft) )
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_2, isLeft); 
                println("requesting authorization for id: ", v.getId());
                }
              else if(v instanceof Limousine){
                if( !machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(v.getId(),machine.camion_3, isLeft) )
                  return;
                  
                machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(v.getId(),machine.camion_3, isLeft); 
                println("requesting authorization for id: ", v.getId());}
            }
          }
          print("Authorized ids are now: ", myEventBMachine.get_auth_on_ids());
      }
    }
    
  }
}
