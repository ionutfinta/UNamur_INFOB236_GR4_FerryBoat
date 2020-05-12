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
    mShape = loadShape("./assets/lift.obj");
    mPosition = lift.getPosition().copy();
    mPosition.y = 2-this.getSize().y;
    
     positions = new int[2];
     positions[0] = 1;
     positions[1] = 1;
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
      
      
      if(oPos.x<-15.5)
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
      
      v = vehicleFromObject(o);
      vID = v.getId();
      
      if(v instanceof Car){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.voiture, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.voiture, queue, positionToBe);
          positions[queue-1]+=1;
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
        
      
      else if(v instanceof CyberTruck){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_1, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.camion_1, queue, positionToBe);
          positions[queue-1]+=1;
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
      else if(v instanceof Truck){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_2, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.camion_2, queue, positionToBe);
          positions[queue-1]+=2;
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
      }
      else if(v instanceof Limousine){
        if(myEventBMachine.evt_BoardLift.guard_BoardLift(vID, myEventBMachine.camion_3, queue, positionToBe)){
          vehicles.add(o);
          myEventBMachine.evt_BoardLift.run_BoardLift(vID, myEventBMachine.camion_3, queue, positionToBe);
          positions[queue-1]+=3;
          vehicles.add(o);
          println("Vehicle ", vID, "has boarded the lift");
          return;
        }
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
      
      v = vehicleFromObject(o2);
      
      
      //out boarding
     if(oPos.z>140){
       //v = vehicleFromObject(o2);
       if(o2 instanceof Car){
        if(myEventBMachine.evt_Board.guard_Board(v.getId(), myEventBMachine.voiture)){
          myEventBMachine.evt_Board.run_Board(v.getId(), myEventBMachine.voiture);
          removal.add(o2);
          print("Car, id ", v.getId(), " has boarded the ship");
      }
        else
          println("A car has entered the wrong floor");
      }
      else if(o2 instanceof CyberTruck){/*
     println(myEventBMachine.VEHICLE_TYPES.has(myEventBMachine.camion_1)); //grd2_2
        println( (new Integer(myEventBMachine.get_busy_slots() + myEventBMachine.vehicle_slot.apply(myEventBMachine.camion_1))).compareTo(myEventBMachine.get_max_busy_slots()) <= 0); //grd3_2
        println( (myEventBMachine.vehicle_slot.apply(myEventBMachine.camion_1)).compareTo(myEventBMachine.get_bs_m()) <= 0 );*/
        println ((new Integer(myEventBMachine.vehicle_slot.apply(myEventBMachine.camion_1))));
        println(myEventBMachine.get_bs_p().apply(myEventBMachine.get_lift_level())); //.compareTo(
        println(myEventBMachine.get_max_bs_p());//.apply(myEventBMachine.get_lift_level())) <= 0 );
        /*println(myEventBMachine.get_reservations().domain().has(v.getId()));
        println(myEventBMachine.get_reservations().apply(v.getId()).equals(new Pair<Integer,Integer>(myEventBMachine.get_lift_level(),myEventBMachine.camion_1)));
        println(myEventBMachine.get_lift_vehicles().range().has(v.getId()));
        println(myEventBMachine.get_lift_out().equals(true));
        println( BOOL.implication(myEventBMachine.get_lift_level().equals(new Integer(1)),myEventBMachine.get_lvl_1_access().equals(true)));
        println(BOOL.implication(myEventBMachine.get_lift_level().equals(new Integer(2)),myEventBMachine.get_lvl_2_access().equals(true)));
        println(BOOL.implication(myEventBMachine.get_lift_level().equals(new Integer(3)),myEventBMachine.get_lvl_3_access().equals(true)));
        println(myEventBMachine.get_Sensor_state().apply(myEventBMachine.get_lift_level()).equals(myEventBMachine.Detecting));*/
        if(myEventBMachine.evt_Board.guard_Board(v.getId(), myEventBMachine.camion_1)){
          myEventBMachine.evt_Board.run_Board(v.getId(), myEventBMachine.camion_1);
          removal.add(o2);
          print("Cybertruck, id ", v.getId(), " has boarded the ship");  
      }
        else
          println("A cybertruck has entered the wrong floor");
      }
      else if(o2 instanceof Truck)
        if(myEventBMachine.evt_Board.guard_Board(v.getId(), myEventBMachine.camion_2)){
          myEventBMachine.evt_Board.run_Board(v.getId(), myEventBMachine.camion_2);
          removal.add(o2);
          print("Truck, id ", v.getId(), " has boarded the ship");
     }
        else
          println("A truck has entered the wrong floor");
      else if(o2 instanceof Limousine)
        if(myEventBMachine.evt_Board.guard_Board(v.getId(), myEventBMachine.camion_3)){
          myEventBMachine.evt_Board.run_Board(v.getId(), myEventBMachine.camion_3);
          removal.add(o2);
          print("Limousine, id ", v.getId(), " boarded the ship");
      }
        else
          println("A limousine has entered the wrong floor");
     
     }
      //out front
     else if(oPos.z+oSize.z<125){
       
       v = vehicleFromObject(o2);
      
      removal.add(o2);
      
      if(o2 instanceof Car){
        myEventBMachine.evt_LeaveLift.run_LeaveLift(v.getId(), myEventBMachine.voiture);
      }
      else if(o2 instanceof CyberTruck)
        myEventBMachine.evt_LeaveLift.run_LeaveLift(v.getId(), myEventBMachine.camion_1);
      else if(o2 instanceof Truck)
        myEventBMachine.evt_LeaveLift.run_LeaveLift(v.getId(), myEventBMachine.camion_2);
      else if(o2 instanceof Limousine)
        myEventBMachine.evt_LeaveLift.run_LeaveLift(v.getId(), myEventBMachine.camion_3);
        
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
