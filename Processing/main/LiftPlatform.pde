//Mostly necessary to retrieve cars touching the lift
// allows for implementation of board_lift;

class LiftPlatform extends U3DObject{

  
  private U3DObjects vehicles;
  
  private Lift parentLift;
  boolean tmp = false;
  public LiftPlatform(Universe uni, Lift lift){
    super(uni);
    parentLift = lift;
    mShape = loadShape("./assets/lift.obj");
    mPosition = lift.getPosition().copy();
    mPosition.y = 2-mShape.getHeight();
  }
  
  @Override
  void handle_collision(U3DObject o){
    //removes old ones
    
    
    /*
    //add new ones
    if(o instanceof Vehicle){
      if(inArray(vehicles, o))
        return;
      
      if()
      vehicles.add(o);
    }
    
    */
  }
  
}
