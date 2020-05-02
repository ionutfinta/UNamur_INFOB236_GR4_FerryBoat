class Earth extends U3DObject{

  private PShape sol;
  private int gravity;
  
  private PShape poteau;
  private PShape chaine;
  private ArrayList<PVector> poteauxPos;
  
  private PShape mainBarrier;
  private PShape carBarrier;
  
  Earth(){
    sol = loadShape("./assets/berge.obj");
    poteau = loadShape("./assets/poteau.obj");
    chaine = loadShape("./assets/chaine.obj");
    
    mainBarrier = loadShape("./assets/mainBarrier.obj");
    //carBarrier = loadShape("./assets/barrier.obj");
    
    poteauxPos = new ArrayList<PVector>();
    
    // Puisque le y sera toujours 0, on l'utilise pour l'angle de rotation !
    poteauxPos.add(new PVector(18.835058, 0, 123.41));
    for(int i = 102; i > 0; i-=2){
      poteauxPos.add(new PVector(18.935065+i, 0, 123.41));
    }
    for(int i = 138; i > 0; i-=2){
      poteauxPos.add(new PVector(14.135065-i, i==138?HALF_PI:PI, 123.41));
    }
    for(int i = 248; i > 0; i-=2){
      poteauxPos.add(new PVector(122.935065, i==248?-HALF_PI:HALF_PI, 125.41-i));
    }
    for(int i = 246; i > 0; i-=2){
      poteauxPos.add(new PVector(122.935065-i, 0, -122.59));
    }
    for(int i = 246; i > 0; i-=2){
      poteauxPos.add(new PVector(-123.064935, i==248?-HALF_PI:HALF_PI, 125.41-i));
    }
    
    gravity = 10;
  }
  
  void animate(int gravity){
      translate(0, limitBelow*uniScale);
      scale(uniScale);
      shape(sol, 0, 0);
      for(PVector p: poteauxPos){
        pushMatrix();
          translate(p.x, 0, p.z);
          rotateY(p.y);
          shape(poteau);
          shape(chaine);
        popMatrix();
      }
      //barriers
      pushMatrix();
        translate(241/18, -PI, 2219/18);
        shape(mainBarrier);
        //shape(carBarrier);
      popMatrix();
      
      pushMatrix();
        /* Water */
        translate(0, 1*uniScale, 0);
        rotateX(HALF_PI);
        fill(#004A7F);
        rect(-uniScale*20,-uniScale*20, uniScale*200, uniScale*200);
    popMatrix();
  }
  
  int getGravity(){
    return gravity;
  }
}
