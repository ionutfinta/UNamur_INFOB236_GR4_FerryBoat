//Mostly necessary to retrieve cars touching the lift
// allows for implementation of board_lift;

class LiftPlatform extends U3DObject{

  
  private U3DObjects cars;
  
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
    if(o instanceof Vehicle){
      //if
    
    }
  }
  
}
