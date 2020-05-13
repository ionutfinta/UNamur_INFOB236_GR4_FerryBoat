class Scaner extends U3DObject{

  fifthRef machine;
  boolean isLeft;
  
  Scaner(Universe uni, boolean is_left, fifthRef m){
    super(uni);
    everything = uni.objs;
    machine = m;
    mShape = loadShape("Scaner.obj");
    isLeft = is_left;
    if(isLeft){
      mPosition = new PVector(-19.5, 2.7, 114);
    }
    else{
      mPosition = new PVector(-12, 2.7, 114);
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
      if(o instanceof Vehicle && ((Vehicle) o).getQueue() > 0){
        int vQueue = ((Vehicle) o).getQueue(), vID = ((Vehicle) o).getId();
        
        if((isLeft && vQueue == 1) || (!isLeft && vQueue == 2)){
          if(machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(vID,((Vehicle) o).getVehicleType(), isLeft)){
            machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(vID,((Vehicle) o).getVehicleType(), isLeft);
          }else{
            println("You're not allowed to board !");
          }
        }
      }
    }
  }
}
