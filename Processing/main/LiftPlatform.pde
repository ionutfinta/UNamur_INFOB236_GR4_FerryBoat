//Mostly necessary to retrieve cars touching the lift
// allows for implementation of board_lift;

class LiftPlatform extends U3DObject{

  
  private U3DObjects vehicles; //vehicles on the platform, is updated with new vehicles then vehicles not confirmed on that tick are removed
  private int[] positions;
  private final int DEPTH = 3;
  
  private Lift parentLift;
  boolean tmp = false;
  public LiftPlatform(Universe uni, Lift lift){
    super(uni);
    parentLift = lift;
    mShape = loadShape("lift.obj");
    mPosition = lift.getPosition().copy();
    mPosition.y = 2-this.getSize().y;
    
     positions = new int[2];
     positions[0] = 0;
     positions[1] = 0;
     vehicles = new U3DObjects();
  }
  
  @Override
  void handle_collision(U3DObject o){
    boolean guardHeld;
    int queue;
    Vehicle v;
    int vID;
    int positionToBe;
    
    //add new ones
    if(o instanceof Vehicle){
      PVector oPos = o.getPosition();
      PVector oSize = o.getSize();
      
      
      if(oPos.x<-16)
        queue = 1;
      else
        queue = 2;
        
      positionToBe=DEPTH-positions[queue-1];
      
      //if no chance of spot
      
      if(positionToBe<=0){
        println("Illegal lift boarding, lift is full");
        return;
      }
      //if vehicle already in
      if(inArray(vehicles, o)){
        return;
      }
      
      v = (Vehicle) o;
      vID = v.getId();
      println(vID, queue, positionToBe);
      if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, v.getVehicleType(), queue, positionToBe)){
        //vehicles.add(o);
        myEventBMachine.evt_BoardLift.run_BoardLift(vID, v.getVehicleType(), queue, positionToBe);
        positions[queue-1]+=1;
        vehicles.add(o);
        o.attachObject(this);
        println("Vehicle ", vID, "has boarded the lift");
        return;
      }
      
        println("Illegal lift boarding, contact authorities");
    }
    
  }
  void checkLeavers(){
    PVector oPos;
    PVector oSize;
    Vehicle v;
    
    U3DObjects removal = new U3DObjects();
    
    for(U3DObject o2: vehicles){
      oPos = o2.getPosition();
      oSize = o2.getSize();
      
      v = (Vehicle) o2;
      
      
      //out boarding
     if(oPos.z>140){
      if(myEventBMachine.evt_Board.guard_Board(v.getId(), v.getVehicleType())){
        myEventBMachine.evt_Board.run_Board(v.getId(), v.getVehicleType());
        removal.add(o2);
        o2.detachObjects();
        print("Vehicle id ", v.getId(), " has boarded the ship");
      }
      else
        println("A vehicle has boarded the wrong floor");
      //out front
     }else if(oPos.z+oSize.z<125){
       
       v = (Vehicle) o2;
      
      removal.add(o2);
      o2.detachObjects();
      
      if(o2 instanceof Car){
        myEventBMachine.evt_LeaveLift.run_LeaveLift(v.getId(), v.getVehicleType());
      }
        
      print("A vehicle exited the lift through the entryway");
     }
     
    }
    
     
     vehicles.removeAll(removal);
  }
  
  @Override
  void animate(){
    super.animate();
    checkLeavers();
    
  }
  
  U3DObjects getVehicles(){
    return vehicles;
  }
  
}
