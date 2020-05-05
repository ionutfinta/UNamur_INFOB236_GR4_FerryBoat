class Earth extends U3DObject{

  private PShape sol;
  private int gravity;
  
  private PShape poteau;
  private ArrayList<PVector> poteauxPos;
  
  //TODO: Créer des objets U3DObject pour les murs et barrières, le système de collision devra pouvoir empêcher un fou de sauter à l'eau 
  private PShape concreteWall;
  private PShape concreteWall2;
  
  private Wave mWave;
  
  Earth(){
    sol = loadShape("./assets/berge.obj");
    mSize = new PVector(125,1,125);
    mPosition = new PVector(0, 2, 0);
    poteau = loadShape("./assets/poteau.obj");
    
    concreteWall = loadShape("./assets/concreteWall.obj");
    concreteWall2 = loadShape("./assets/concreteWall2.obj");
    
    poteauxPos = new ArrayList<PVector>();
    
    // Puisque le y sera toujours 0, on l'utilise pour l'angle de rotation !
    poteauxPos.add(new PVector(-20.5, 0, 123.41));
    for(int i = 102; i > 0; i-=2){
      poteauxPos.add(new PVector(-20.5-i, 0, 123.41));
    }
    for(int i = 136; i > 0; i-=2){
      poteauxPos.add(new PVector(-12.135065+i, i==138?HALF_PI:PI, 123.41));
    }
    
    gravity = 10;
    
    mWave = new Wave();
  }
  
  void animate(){
    pushMatrix();
      translate(mPosition.x, mPosition.y, mPosition.z);
      shape(sol, 0, 0);
      for(PVector p: poteauxPos){
        pushMatrix();
          translate(p.x, 0, p.z);
          rotateY(p.y);
          shape(poteau);
        popMatrix();
      }
    
    //concrete walls
      translate(123.5, 0, 0);
      rotateY(radians(90));
      shape(concreteWall);
      
      rotateY(PI);
      translate(0, 0, 123.5*2);
      shape(concreteWall);
      
      rotateY(HALF_PI);
      translate(123.5, 0, -123.5);
      shape(concreteWall);
      
      translate(0, -.009, 123.5*2-2.5);
      shape(concreteWall2);
      translate(0, -15, 0);
      shape(concreteWall2);
    popMatrix();
    
    pushMatrix();
      /* Water */
      translate(-250-125, 0, -50);
      mWave.renderWave();
    popMatrix();
  }
  
  int getGravity(){
    return gravity;
  }
}
