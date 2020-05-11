/** Gestionnaire du monte-charges
  * Le monte-charge est doué d'une structure, de barrières, d'une plateforme mobile ainsi que de capteurs.
  * Type mutable dans le respect des gardes Event-B
**/

class Lift extends U3DObject {
  private fifthRef mEventB;
  //GF = Garde-Fou
  private U3DObject mPlateforme, mGF1, mGF2;
  
  private boolean nOuvert, isOuvert;
  
  boolean[] sensors = {false,false,false};
  
  // --- Constructeurs
  Lift(Universe uni, fifthRef mac, PVector pos){
    super(uni, pos, "./assets/liftStructure.obj");
    mEventB = mac;
    mCollide = false;
    mShape.setName("noStroke");

    mPlateforme = new U3DObject(uni, new PVector(0,11.5321,0).add(mPosition), "./assets/lift.obj");
    
    mGF1 = new U3DObject(uni, new PVector(6.14,12.7321,0).add(mPosition), "./assets/lift_gardeFou.obj");
    mGF2 = new U3DObject(uni, new PVector(-6.14,12.7321,0).add(mPosition), "./assets/lift_gardeFou.obj");
    mGF2.setAngles(new PVector(0,PI,0));
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
