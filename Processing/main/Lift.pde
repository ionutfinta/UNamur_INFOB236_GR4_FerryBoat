/** Gestionnaire du monte-charges
  * Le monte-charge est doué d'une structure, de barrières, d'une plateforme mobile ainsi que de capteurs.
  * Type mutable dans le respect des gardes Event-B
**/

class Lift extends U3DObject {
  private fifthRef mEventB;
  //GF = Garde-Fou
  private U3DObject mGF1, mGF2;
  
  private int currentFloor;
  private LiftPlatform mPlatform;
  
  private boolean nOuvert, isOuvert;
  
  boolean[] sensors = {false,false,false};
  
  // --- Constructeurs
  Lift(Universe uni, fifthRef mac, PVector pos){
    super(uni, pos, "./assets/liftStructure.obj");
    mEventB = mac;
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
    /*isOuvert = false;
    nOuvert = true;*/
  }
  
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
    if(!mEventB.evt_MoveLift.guard_MoveLift(floor)){
      println("Lift cannot be moved");
      return;
    }
    
    mEventB.evt_MoveLift.run_MoveLift(floor);
    
    switch(floor){
      case 1: elevation = 2; break;
      case 2: elevation = 7.12; break;
      case 3: elevation = 10.5; break;
      default: println("floor ", floor, " doesn't exist..");
    }
    
    PVector destination = mPlatform.getPosition().copy();
    destination.y = elevation - mPlatform.getPosition().y;
    PVector gf1_destination = mGF1.getPosition().copy();
    gf1_destination.y = elevation+3 - mGF1.getPosition().y;
    PVector gf2_destination = mGF2.getPosition().copy();
    gf2_destination.y = elevation+3 - mGF2.getPosition().y;
    
    mPlatform.addAnimation(mPlatform.getPosition(), destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
    mGF1.addAnimation(mGF1.getPosition(), gf1_destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
    mGF2.addAnimation(mGF2.getPosition(), gf2_destination, 10000*(max(floor, currentFloor)-min(floor, currentFloor)));
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
     if(sensors[0]==true && !inBetween(11.5,mPosition.y,11.7)){
       mEventB.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(1);
       sensors[0] = false;
       println("stops detecting platform 1");
     }
     else if(inBetween(16.3,mPosition.y,16.4) && sensors[1] == false){
       mEventB.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(2);
       sensors[1] = false;
       println("stops detecting platform 2");
     }
     else if(inBetween(19.5,mPosition.y,19.7) && sensors[2] == false){
       mEventB.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(3);
       sensors[2] = false;
       println("stops detecting platform 3");
     }
     
     if(inBetween(11.5,mPosition.y,11.7) && sensors[0] == false){
       mEventB.evt_Sensor_detects.run_Sensor_detects(1);
       sensors[0] = true;
       println("detecting platform 1");
     }
     else if(inBetween(16.3,mPosition.y,16.4) && sensors[1] == false){
       mEventB.evt_Sensor_detects.run_Sensor_detects(2);
       sensors[1] = true;
       println("detecting platform 2");
     }
     else if(inBetween(19.5,mPosition.y,19.7) && sensors[2] == false){
       mEventB.evt_Sensor_detects.run_Sensor_detects(3);
       sensors[2] = true;
       println("detecting platform 3");
     }
   }
   
  @Override
  void animate(){
    super.animate();
    check_detectors();
  }
  // --- Mutateurs publics
  
  // --- Actualisation du statut en fonction de l'animation
  
  // --- Getters
}
