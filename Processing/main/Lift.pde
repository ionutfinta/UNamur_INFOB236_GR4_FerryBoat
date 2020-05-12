/** Gestionnaire du monte-charges
  * Le monte-charge est doué d'une structure, de barrières, d'une plateforme mobile ainsi que de capteurs.
  * Type mutable dans le respect des gardes Event-B
**/

class Lift extends U3DObject {
  //GF = Garde-Fou
  private U3DObject mGF1, mGF2;
  
  private PVector GF1pos0, GF2pos0, platformPos0;
  
  private int currentFloor;
  private LiftPlatform mPlatform;
  
  // Barrières
  Barriere[] mBarriereIN, mBarriereOUT;
  
  boolean[] sensors = {false,false,false};
  
  // --- Constructeurs
  Lift(Universe uni, PVector pos){
    super(uni, pos, "./assets/liftStructure.obj");
    mCollide = false;
    mShape.setName("noStroke");

    mPlatform = new LiftPlatform(uni, this);
    currentFloor = 1;
    
    PVector tmp_position = pos.copy();
    tmp_position.x+= 6.14;
    tmp_position.y=2.5;
    mGF1 = new U3DObject(uni, tmp_position.copy(), "./assets/lift_gardeFou.obj");
    tmp_position.x-= 6.14*2;
    mGF2 = new U3DObject(uni, tmp_position.copy(), "./assets/lift_gardeFou.obj");
    mGF2.setAngles(new PVector(0,PI,0));
    
    platformPos0 = mPlatform.getPosition().copy();
    GF1pos0 = mGF1.getPosition().copy();
    GF2pos0 = mGF2.getPosition().copy();
    
    mBarriereIN = new Barriere[2];
    mBarriereIN[0] = new Barriere(myUniverse, new PVector(4.58, 1.15, -6.12).add(mPlatform.getPosition()), true);
    mBarriereIN[1] = new Barriere(myUniverse, new PVector(-5, 1.15, -6.12).add(mPlatform.getPosition()), new PVector(0,PI,0), true);
    
    mBarriereOUT = new Barriere[2];
    mBarriereOUT[0] = new Barriere(myUniverse, new PVector(4.58, 1.15, 6).add(mPlatform.getPosition()), true);
    mBarriereOUT[1] = new Barriere(myUniverse, new PVector(-5, 1.15, 6).add(mPlatform.getPosition()), new PVector(0,PI,0), true);
    /*isOuvert = false;
    nOuvert = true;*/
  }
  

  
  
  // -- Mutateurs privés
  /*private void setFerme(){
    myLisse.addAnimation("rotateZ", 0, 1000);
    isOuvert = false;
  }
  
  private void setOuvert(){
    myLisse.addAnimation("rotateZ", (myLisse.getAngles().y==PI?HALF_PI:-HALF_PI), 1000);
    isOuvert = true;
  }*/
   void check_detectors(){
     if(sensors[0]==true && !inBetween(1.9-mPlatform.getSize().y,mPosition.y,2.2-mPlatform.getSize().y)){
       myEventBMachine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(1);
       sensors[0] = false;
       println("stops detecting platform 1");
     }
     else if(!inBetween(7,mPosition.y,7.3) && sensors[1] == true){
       myEventBMachine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(2);
       sensors[1] = false;
       println("stops detecting platform 2");
     }
     else if(!inBetween(10,mPosition.y,11) && sensors[2] == true){
       myEventBMachine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(3);
       sensors[2] = false;
       println("stops detecting platform 3");
     }
     
     if(inBetween(1.9-mPlatform.getSize().y,mPosition.y,2.2-mPlatform.getSize().y) && sensors[0] == false){
       myEventBMachine.evt_Sensor_detects.run_Sensor_detects(1);
       sensors[0] = true;
       println("detecting platform 1");
     }
     else if(inBetween(7,mPosition.y,7.3) && sensors[1] == false){
       myEventBMachine.evt_Sensor_detects.run_Sensor_detects(2);
       sensors[1] = true;
       println("detecting platform 2");
     }
     else if(inBetween(10,mPosition.y,11) && sensors[2] == false){
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
      case 1: elevation = 2-mPlatform.getSize().y; break;
      case 2: elevation = 7.12; break;
      case 3: elevation = 10.5; break;
      default: println("floor ", floor, " doesn't exist.."); return;
    }
        
    platformPos0 = mPlatform.getPosition().copy();
    GF1pos0 = mGF1.getPosition().copy();
    GF2pos0 = mGF2.getPosition().copy();
    
    PVector destination = mPlatform.getPosition().copy();
    destination.y = elevation;// - mPlatform.getPosition().y;
    PVector gf1_destination = mGF1.getPosition().copy();
    gf1_destination.y = elevation;// - mGF1.getPosition().y;
    PVector gf2_destination = mGF2.getPosition().copy();
    gf2_destination.y = elevation;// - mGF2.getPosition().y;
    
    mPlatform.addAnimation(mPlatform.getPosition(), destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
    mGF1.addAnimation(mGF1.getPosition(), gf1_destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
    mGF2.addAnimation(mGF2.getPosition(), gf2_destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
    currentFloor = floor;
  }
  
  // --- Actualisation du statut en fonction de l'animation
  
  // --- Getters
  
  int getFloor(){
    return currentFloor;
  }
  
}
