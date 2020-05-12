/** Gestionnaire du Ferry
  * La longueur du ferry s'exprime en nombre de compartiments. Un compartiment équivaut à une plateforme de lift (2x3 slots)
  * Le système est modulaire et les différents composants n'empêchent le chargement des véhicules (à cause des collisions)
**/
class Ferry extends U3DObject{
  private U3DObject facadeArriere, porteRDC, portePont2, portePont3;
  private U3DObjects coques, coqueBabord, coqueTribord, planchers1, planchers2;
  
  Boolean lvl3Access;
  
  BRelation<Integer, Integer> mCapacities;

  // --- Constructeur
  Ferry(Universe uni, int lg){
    //modifying Y of constructor doesn't move the bow
    super(uni, new PVector(-14.88295,0.695,125 + 20.2 + lg*18.1416), "./assets/ferry_proue.obj");
    mCapacities = new BRelation<Integer, Integer>().insert(1, lg*6).insert(2,lg*6).insert(3,lg*6);
    setMovable(uni);
    
    
    if(!myEventBMachine.evt_Boat_ready.guard_Boat_ready(mCapacities)){
      println("Fatal Error ! Guard for Boat Ready Unsatisfaied, Could not create a new Ferry !");
      return;
    }
    
    myEventBMachine.evt_Boat_ready.run_Boat_ready(mCapacities);
    
    coques = new U3DObjects();
    coqueBabord = new U3DObjects();
    coqueTribord = new U3DObjects();
    planchers1 = new U3DObjects();
    planchers2 = new U3DObjects();
    
    // Facade arrière
    facadeArriere = new U3DObject(uni, new PVector(-0.11, -1.6294+2.3, -24.9-(lg-1)*16.1113).add(mPosition), "./assets/ferry_coqueArriere.obj");
    facadeArriere.disableCollisions();
    
    // Porte RDC
    porteRDC = new U3DObject(uni, new PVector(0.0, 3.35, -24.8-(lg-1)*16.1113).add(mPosition), "./assets/ferry_porteRDC.obj");
    porteRDC.setRotationXCenter(new PVector(0, -2.6, 0.67).add(porteRDC.getPosition()));

    // Porte Pont2
    portePont2 = new U3DObject(uni, new PVector(-0.17, 4.1551237+2.3, -24.222954-(lg-1)*16.1113).add(mPosition), "./assets/ferry_porte2.obj");
    portePont2.setRotationXCenter(new PVector(-0.5, -0.5, 0).add(portePont2.getPosition()));
    
    // Porte Pont3
    portePont3 = new U3DObject(uni, new PVector(-0.06, 7.53+2.3, -24.182954-(lg-1)*16.1113).add(mPosition), "./assets/ferry_porte3.obj");
    portePont3.setRotationXCenter(new PVector(-0.5, -0.5, 0).add(portePont3.getPosition()));
    lvl3Access = false;
    
    while(lg > 0){
      // Coque rez-de-chaussée
      coques.add(new U3DObject(uni ,new PVector(-0.2, -2.8000002+2.3, lg*-16.1113).add(mPosition), "./assets/ferry_coque.obj"));
      
      // Coques latérales
      coqueBabord.add(new U3DObject(uni, new PVector(-8.559996, 5.199997+2.3, lg*-16.1416).add(mPosition), "./assets/ferry_coqueLaterale.obj"));
      
      U3DObject tmpObj = new U3DObject(uni, new PVector(8.2984, 5.199997+2.3, lg*-16.1416).add(mPosition), "./assets/ferry_coqueLaterale.obj");
      tmpObj.setAngles(new PVector(0,PI,0));
      coqueTribord.add(tmpObj);
      
      // Plancher niveau 1
      planchers1.add(new U3DObject(uni, new PVector(-0.2, 3.5999982+2.3, lg*-16.1113).add(mPosition), "./assets/ferry_plancher.obj"));
      
      // Plancher niveau 2
      planchers2.add(new U3DObject(uni, new PVector(-0.2, 7.0019982+2.3, lg*-16.1113).add(mPosition), "./assets/ferry_plancher.obj"));
      
      lg--;
    }
  }
  
  // --- Animations (Event-B checked)
  void switchRDC(){
    if(porteRDC.getAnimations().size() > 0){
      println("Door not ready");
      return;
    }
    
    boolean state = myEventBMachine.get_lvl_1_access();
    
    if(! myEventBMachine.evt_Switch_lvl_1_access.guard_Switch_lvl_1_access(!state)){
      println("Event-B Guard not satisfaied to switch the door's state");
      return;
    }
    
    myEventBMachine.evt_Switch_lvl_1_access.run_Switch_lvl_1_access(!state);
    porteRDC.addAnimation("rotateX", state?0:-PI/2, 10000);
  }
  
  void switchP2(){
    if(portePont2.getAnimations().size() > 0){
      println("Door not ready");
      return;
    }
    
    boolean state = myEventBMachine.get_lvl_2_access();
    
    if(! myEventBMachine.evt_Switch_lvl_2_access.guard_Switch_lvl_2_access(!state)){
      println("Event-B Guard not satisfaied to switch the door's state");
      return;
    }
    
    myEventBMachine.evt_Switch_lvl_2_access.run_Switch_lvl_2_access(!state);
    portePont2.addAnimation("rotateX", state?0:-PI/2, 10000);
  }
  
  void switchP3(){
    if(portePont3.getAnimations().size() > 0){
      println("Door not ready");
      return;
    }
    
    boolean state = myEventBMachine.get_lvl_3_access();
    
    if(! myEventBMachine.evt_Switch_lvl_3_access.guard_Switch_lvl_3_access(!state)){
      println("Event-B Guard not satisfaied to switch the door's state");
      return;
    }
    
    myEventBMachine.evt_Switch_lvl_3_access.run_Switch_lvl_3_access(!state);
    portePont3.addAnimation("rotateX", state?0:-PI/2, 10000);
  }
}
