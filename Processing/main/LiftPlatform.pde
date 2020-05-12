//Mostly necessary to retrieve cars touching the lift
// allows for implementation of board_lift;

class LiftPlatform extends U3DObject{

  
  private U3DObjects vehicles; //vehicles on the platform, is updated with new vehicles then vehicles not confirmed on that tick are removed
  private U3DObjects confirmed; //vehicles confirmed on the platform on that tick
  private int[] positions;
  private final int DEPTH = 3;
  
  private Lift parentLift;
  boolean tmp = false;
  public LiftPlatform(Universe uni, Lift lift){
    super(uni);
    parentLift = lift;
    mShape = loadShape("./assets/lift.obj");
    mPosition = lift.getPosition().copy();
    mPosition.y = 2-mShape.getHeight();
    
     positions = new int[2];
     positions[0] = 0;
     positions[1] = 0;
     vehicles = new U3DObjects();
     confirmed = new U3DObjects();
  }
  
  @Override
  void handle_collision(U3DObject o){
    
    confirmed = new U3DObjects(); //reset the vehicles confirmed onBoard
    boolean guardHeld;
    int queue;
    Vehicle v;
    int vID;
    int positionToBe;
    
    //add new ones
    if(o instanceof Vehicle){
      PVector oPos = o.getPosition();
      PVector oSize = o.getSize();
      
      
      if(oPos.x<-15.5)
        queue = 0;
      else
        queue = 1;
        
      positionToBe=DEPTH-positions[queue];
      
      //if no chance of spot
      if(positionToBe<=0){
        println("Illegal lift boarding, contact authorities");
        return;
      }
      //if vehicle already in
      if(inArray(vehicles, o)){
        confirmed.add(o);
        return;
      }
      
      v = vehicleFromObject(o);
      vID = v.getId();
      
      if(v instanceof Car){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.voiture, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.voiture, queue, positionToBe);
          positions[queue]+=1;
          confirmed.add(o);
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
        
      
      else if(v instanceof CyberTruck){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_1, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.camion_1, queue, positionToBe);
          positions[queue]+=1;
          confirmed.add(o);
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
      else if(v instanceof Truck){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_2, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.camion_2, queue, positionToBe);
          positions[queue]+=2;
          confirmed.add(o);
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
      else if(v instanceof Limousine){
        println(positionToBe, queue, vID, myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_3, queue, positionToBe));
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_3, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.camion_3, queue, positionToBe);
          positions[queue]+=3;
          confirmed.add(o);
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
      
        println("Illegal lift boarding, contact authorities");
    }
    
  }
  void checkLeavers(){
    U3DObjects removal = new U3DObjects();
    for(U3DObject o1: vehicles){
      if(!inArray(confirmed, o1)){
        removal.add(o1);
      }
    }
    
    for(U3DObject o2: removal){
      vehicles.remove(o2);
      //if()
    }
  }
  
  @Override
  void animate(){
    super.animate();
    checkLeavers();
  }
  
}
