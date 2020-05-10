/** Gestionnaire du Ferry **/

//NOTE: idée: Le bateau devrait pouvoir intéragir avec les vagues pour bouger et on ferait ainsi marcher nos sensors !

class Ferry extends U3DObject{
  //Le système est modulaire et les différents composants ne devraient pas empêcher le chargement des véhicules (à cause des collisions)
  private U3DObject facadeArriere, porteRDC, portePont2, portePont3;
  private U3DObjects coques, coqueBabord, coqueTribord, planchers1, planchers2;
  
  // Longueur du Ferry en nombres de "compartiments", un compartiment équivaut à une plateforme de lift (2x3 slots)
  private int mLongueur;
  
  private float x,y,z;
  
  // Event-B link
  private fifthRef mEventB;
  
  Boolean lvl1Access;
  Boolean lvl2Access;
  Boolean lvl3Access;
  
  BRelation<Integer, Integer> mCapacities;

  // --- Constructeur
  Ferry(Universe uni, int lg, fifthRef machine){
    super(uni, new PVector(-14.88295,1.5,125 + 17 + lg*18.1416), "./assets/ferry_proue.obj");
    mCapacities = new BRelation<Integer, Integer>().insert(1, lg*6).insert(2,lg*6).insert(3,lg*6);
    setMovable(uni);
    
    
    if(!machine.evt_Boat_ready.guard_Boat_ready(mCapacities)){
      println("Fatal Error ! Guard for Boat Ready Unsatisfaied, Could not create a new Ferry !");
      return;
    }
    machine.evt_Boat_ready.run_Boat_ready(mCapacities);
    mEventB = machine;
  
    mLongueur = lg;
    
    coques = new U3DObjects();
    coqueBabord = new U3DObjects();
    coqueTribord = new U3DObjects();
    planchers1 = new U3DObjects();
    planchers2 = new U3DObjects();
    
    
    
    // Facade arrière
    facadeArriere = new U3DObject();
    facadeArriere.setShapeSRC("./assets/ferry_coqueArriere.obj");
    facadeArriere.setPos(new PVector(-0.11, -1.6294, -24.9-(lg-1)*16.1113).add(mPosition));
    facadeArriere.disableCollisions();
    uni.addObject(facadeArriere);
    
    //RDC
    porteRDC = new U3DObject();
    porteRDC.setShapeSRC("./assets/ferry_porteRDC.obj");
    porteRDC.setPos(new PVector(0.0, -0.700064, -24.563-(lg-1)*16.1113).add(mPosition));
    porteRDC.setRotationZCenter(porteRDC.getPosition());
    uni.addObject(porteRDC);
    lvl1Access = false;

    

    
    // Porte Pont2
    portePont2 = new U3DObject();
    portePont2.setShapeSRC("./assets/ferry_porte2.obj");
    portePont2.setPos(new PVector(-0.17, 4.1551237, -24.222954-(lg-1)*16.1113).add(mPosition));
    portePont2.setRotationZCenter(portePont2.getPosition());
    uni.addObject(portePont2);
    lvl2Access = false;
    
    
    x=-0.17; y=7.4952;z= -26.223;
    
    // Porte Pont3
    portePont3 = new U3DObject();
    portePont3.setShapeSRC("./assets/ferry_porte3.obj");
    portePont3.setPos(new PVector(-0.06, 7.7241237, -24.182954-(lg-1)*16.1113).add(mPosition));
    portePont3.setRotationZCenter(new PVector(-0.06, 7, -23.182954-(lg-1)*16.1113).add(mPosition));
    uni.addObject(portePont3);
    lvl3Access = false;
    
    while(lg > 0){
      // Coque rez-de-chaussée
      U3DObject tmpObj = new U3DObject();
      tmpObj.setShapeSRC("./assets/ferry_coque.obj");
      tmpObj.setPos(new PVector(-0.2, -2.8000002, lg*-16.1113).add(mPosition));
      coques.add(tmpObj);
      uni.addObject(tmpObj);
      
      // Coques latérales
      tmpObj = new U3DObject();
      tmpObj.setShapeSRC("./assets/ferry_coqueLaterale.obj");
      tmpObj.setPos(new PVector(-8.559996, 5.199997, lg*-16.1416).add(mPosition));
      coqueBabord.add(tmpObj);
      uni.addObject(tmpObj);
      
      // Coques latérales
      tmpObj = new U3DObject();
      tmpObj.setShapeSRC("./assets/ferry_coqueLaterale.obj");
      tmpObj.setPos(new PVector(8.2984, 5.199997, lg*-16.1416).add(mPosition));
      tmpObj.setAngles(new PVector(0,PI,0));
      coqueTribord.add(tmpObj);
      uni.addObject(tmpObj);
      
      // Plancher niveau 1
      tmpObj = new U3DObject();
      tmpObj.setShapeSRC("./assets/ferry_plancher.obj");
      tmpObj.setPos(new PVector(-0.2, 3.5999982, lg*-16.1113).add(mPosition));
      planchers1.add(tmpObj);
      uni.addObject(tmpObj);
      
      // Plancher niveau 2
      tmpObj = new U3DObject();
      tmpObj.setShapeSRC("./assets/ferry_plancher.obj");
      tmpObj.setPos(new PVector(-0.2, 7.0019982, lg*-16.1113).add(mPosition));
      planchers2.add(tmpObj);
      uni.addObject(tmpObj);
      
      lg--;
    }
  }
  
   //check and animate
    void check_RDC(){
      if(mEventB.get_lvl_1_access() == true && lvl1Access==false){
        porteRDC.addAnimation("rotateX", -1.4, 10000);
        lvl1Access = true;
        print("go");
      }
      else if(mEventB.get_lvl_1_access() == false && lvl1Access==true){
        porteRDC.addAnimation("rotateX", -1.4, 10000, true);
        lvl1Access = false;
      }
    }
    void check_lvl2(){
      if(mEventB.get_lvl_2_access() == true && lvl2Access==false){
        portePont2.addAnimation("rotateX", -PI/2, 10000);
        lvl2Access = true;
        print("go");
      }
      else if(mEventB.get_lvl_2_access() == false && lvl2Access==true){
        portePont2.addAnimation("rotateX", -PI/2, 10000, true);
        lvl2Access = false;
      }
    }
    
    void check_lvl3(){
      if(mEventB.get_lvl_3_access() == true && lvl3Access==false){
        portePont3.addAnimation("rotateX", -PI/2, 10000);
        lvl3Access = true;
      }
      else if(mEventB.get_lvl_3_access() == false && lvl3Access==true){
        portePont3.addAnimation("rotateX", -PI/2, 10000, true);
        lvl3Access = false;
      }
    }
  void animate(){
    
    check_RDC();
    check_lvl2();
    check_lvl3();
    super.animate();/*
    if(keyPressed){
      switch(key){
        case 't':
          x+=.01;
          break;
        case 'g':
          y+=.01;
          break;
        case 'b':
          z+=.01;
          break;
         case 'y':
           x-=.01;
           break;
         case 'h':
           y -= .01;
           break;
         case 'n':
           z-=.01;
           break;
         case 'p':
           println(x+ ", "+ y+ ", "+ z);
           break;
      }
    }*/
    //if(facadeArriere.size() > 0)
      //portePont2.setPos(new PVector(x,y, z-(mLongueur-1)*16.1113).add(mPosition));
      
  } 
}
