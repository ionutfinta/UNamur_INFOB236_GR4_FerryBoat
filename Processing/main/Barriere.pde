class Barriere extends U3DObject {
  PShape base, tige;
  
  Barriere(PVector pos){
    mPosition = pos;
    mSize = new PVector(2,3,1);
    
    base = loadShape("./assets/mainBarrier.obj");
    tige = loadShape("./assets/barrier.obj");
  }
  
  void display(){
    pushMatrix();
    //barriers test
      scale(uniScale*.2);
      translate(mPosition.x*5, mPosition.y, mPosition.z*5);
      shape(base);
      translate(0, -5, 1);
      rotate(HALF_PI);
      shape(tige);
    popMatrix();
  }
  
}
