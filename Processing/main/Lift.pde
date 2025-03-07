/** Gestionnaire du monte-charges
  * Le monte-charge est doué d'une structure, de barrières, d'une plateforme mobile ainsi que de capteurs.
  * Type mutable dans le respect des gardes Event-B
**/

class Lift extends U3DObject {
  //GF = Garde-Fou
  private U3DObject mGF1, mGF2;
  
  private int currentFloor;
  private LiftPlatform mPlatform;
  
  // Barrières
  Barriere[] mBarriereIN, mBarriereOUT;
  
  // Senseurs
  boolean[] sensors = {true,false,false};
  
  // --- Constructeurs
  Lift(Universe uni, PVector pos){
    super(uni, pos, "liftStructure.obj");
    mCollide = false;
    mShape.setName("noStroke");

    currentFloor = 1;
    mPlatform = new LiftPlatform(uni, this);
    
    PVector tmp_position = pos.copy();
    tmp_position.x+= 6.14;
    tmp_position.y=2.5;
    mGF1 = new U3DObject(uni, tmp_position.copy(), "lift_gardeFou.obj");
    mGF1.attachObject(mPlatform);
    tmp_position.x-= 6.14*2;
    mGF2 = new U3DObject(uni, tmp_position.copy(), "lift_gardeFou.obj");
    mGF2.attachObject(mPlatform);
    mGF2.setAngles(new PVector(0,PI,0));
    
    mBarriereIN = new Barriere[2];
    mBarriereIN[0] = new Barriere(myUniverse, new PVector(4.58, 1.15, -6.12).add(mPlatform.getPosition()), true);
    mBarriereIN[0].attachObject(mPlatform);
    mBarriereIN[1] = new Barriere(myUniverse, new PVector(-5, 1.15, -6.12).add(mPlatform.getPosition()), new PVector(0,PI,0), true);
    mBarriereIN[1].attachObject(mPlatform);
    
    mBarriereOUT = new Barriere[2];
    mBarriereOUT[0] = new Barriere(myUniverse, new PVector(4.58, 1.15, 6).add(mPlatform.getPosition()), true);
    mBarriereOUT[0].attachObject(mPlatform);
    mBarriereOUT[1] = new Barriere(myUniverse, new PVector(-5, 1.15, 6).add(mPlatform.getPosition()), new PVector(0,PI,0), true);
    mBarriereOUT[1].attachObject(mPlatform);
  }
  
  // --- Sensor Event-B Management
   void check_detectors(){
     if(sensors[0]==true && 2-mPlatform.getSize().y != mPlatform.getPosition().y){
       myEventBMachine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(1);
       sensors[0] = false;
       println("stops detecting platform 1");
     }
     else if(sensors[1] == true && 5.4!=mPlatform.getPosition().y){
       myEventBMachine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(2);
       sensors[1] = false;
       println("stops detecting platform 2");
     }
     else if(sensors[2] == true && 9.2 != mPlatform.getPosition().y){
       myEventBMachine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(3);
       sensors[2] = false;
       println("stops detecting platform 3");
     }
     
     if(sensors[0] == false && 2-mPlatform.getSize().y ==mPlatform.getPosition().y){
       myEventBMachine.evt_Sensor_detects.run_Sensor_detects(1);
       sensors[0] = true;
       println("detecting platform 1");
     }
     if(sensors[1] == false && 5.4==mPlatform.getPosition().y){
       myEventBMachine.evt_Sensor_detects.run_Sensor_detects(2);
       sensors[1] = true;
       println("detecting platform 2");
     }
     if(sensors[2] == false && 9.2==mPlatform.getPosition().y){
       myEventBMachine.evt_Sensor_detects.run_Sensor_detects(3);
       sensors[2] = true;
       println("detecting platform 3");
     }
   }
   
  @Override
  void animate(){
    super.animate();
    check_detectors();
  }

  void switchLiftIn(){
    if(!mBarriereIN[0].isBusy() && myEventBMachine.evt_Switch_lift_in.guard_Switch_lift_in(!myEventBMachine.get_lift_in())){
      myEventBMachine.evt_Switch_lift_in.run_Switch_lift_in(!myEventBMachine.get_lift_in());
      mBarriereIN[0].switchState();
      mBarriereIN[1].switchState();
    }else{
      println("Action refused by guards or barriers actually in movement...");
    }
  }
  
  void switchLiftOut(){
    if(!mBarriereOUT[0].isBusy() && myEventBMachine.evt_Switch_lift_out.guard_Switch_lift_out(!myEventBMachine.get_lift_out())){
      myEventBMachine.evt_Switch_lift_out.run_Switch_lift_out(!myEventBMachine.get_lift_out());
      mBarriereOUT[0].switchState();
      mBarriereOUT[1].switchState();
    }else{
      println("Action refused by guards or barriers actually in movement...");
    }
  }
  
  // --- Mutateurs publics
    //@requires floor>0 && floor<=3
  //moves lift 
  void move_lift(int floor){
    float elevation = 0;
    float zOffset = 0;
    
    if(floor==currentFloor)
      return;
    if(floor<=0 || floor>3){
      println("not a valid floor");
      return;
    }
    if(!myEventBMachine.evt_MoveLift.guard_MoveLift(floor)){
      println("Lift cannot be moved");
      return;
    }
    
    myEventBMachine.evt_MoveLift.run_MoveLift(floor);
    
    switch(floor){
      case 1: elevation = 2-mPlatform.getSize().y; zOffset = 131.2; break;
      case 2: elevation = 5.4; zOffset = 136; break; //3.8 offset
      case 3: elevation = 9.2; zOffset = 136.2; break;
      default: println("floor ", floor, " doesn't exist.."); return;
    }
    
    PVector destination = mPlatform.getPosition().copy();
    destination.y = elevation;
    destination.z = zOffset;
    
    mPlatform.addAnimation(mPlatform.getPosition(), destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
    currentFloor = floor;
  }
  
  // --- Actualisation du statut en fonction de l'animation
  
  // --- Getters
  
  int getFloor(){
    return currentFloor;
  }
  
}
