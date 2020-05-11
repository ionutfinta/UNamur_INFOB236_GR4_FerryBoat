//Mostly necessary to retrieve cars touching the lift

class LiftPlatform extends U3DObject{

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
    //get all current vehicles from here
  }
  
}
