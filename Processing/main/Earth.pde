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
    mSize = new PVector(125,.1,125);
    mPosition = new PVector(0, limitBelow, 0);
    poteau = loadShape("./assets/poteau.obj");
    
    concreteWall = loadShape("./assets/concreteWall.obj");
    concreteWall2 = loadShape("./assets/concreteWall2.obj");
    
    poteauxPos = new ArrayList<PVector>();
    
    // Puisque le y sera toujours 0, on l'utilise pour l'angle de rotation !
    poteauxPos.add(new PVector(18.835058, 0, 123.41));
    for(int i = 102; i > 0; i-=2){
      poteauxPos.add(new PVector(18.935065+i, 0, 123.41));
    }
    for(int i = 136; i > 0; i-=2){
      poteauxPos.add(new PVector(12.135065-i, i==138?HALF_PI:PI, 123.41));
    }
    
    gravity = 10;
    
    mWave = new Wave(uniScale);
  }
  
  void animate(){
    scale(uniScale);
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
    popMatrix();
    
    //concrete walls
    pushMatrix();
      translate(122.935065, limitBelow, 0);
      rotateY(radians(90));
      shape(concreteWall);
    popMatrix();
    pushMatrix();
      translate(0, limitBelow, -122.9);
      shape(concreteWall);
    popMatrix();
    pushMatrix();
      translate(-123, limitBelow, 0);
      rotateY(radians(90));
      shape(concreteWall);
    popMatrix();
    pushMatrix();
      translate(0, uniScale*.89 + limitBelow, 123.41);
      shape(concreteWall2);
      translate(0, uniScale*0.65, 0);
      shape(concreteWall2);
    popMatrix();
    
    pushMatrix();
      /* Water */
      translate(-15*uniScale, limitBelow + uniScale*0.45, 4*uniScale);
      mWave.renderWave();
    popMatrix();
  }
  
  int getGravity(){
    return gravity;
  }
}
