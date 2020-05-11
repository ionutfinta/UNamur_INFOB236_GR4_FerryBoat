import java.util.Iterator;

class Earth extends U3DObject{
  private float gravity;
  private Wave mWave, mEauEcluse;
  private int lastGravity;
  
  // --- Constructor
  Earth(){
    mShape = loadShape("./assets/berge.obj");
    mPosition = new PVector(0, 2, 0);
    
    lastGravity = 0;
    gravity = 9.81/7;
    
    mWave = new Wave();
    mEauEcluse = new Wave(4, 25, 0.3, 32, 400);
  }
  
  // --- Loading
  void load(Universe uni){
    // Spawn des Gardes-fous et insertion dans l'univers des objets
    U3DObject tmpObj = new U3DObject();
    tmpObj.setShapeSRC("./assets/poteau.obj");
    tmpObj.setShapeName("noStroke");
      
    for(int i = 100; i >= 0; i-=2){
      tmpObj = new U3DObject(tmpObj);
      tmpObj.setPos(new PVector(-21.3-i, 0.785087, 123.41).add(mPosition));
      uni.addObject(tmpObj);
    }
    for(int i = 134; i > 0; i-=2){
      tmpObj = new U3DObject(tmpObj);
      tmpObj.setPos(new PVector(-11.8+i, 0.785087, 123.41).add(mPosition));
      uni.addObject(tmpObj);
    }
    
    // Spawn du panneau de signalisation berge
    tmpObj = new U3DObject(uni, new PVector(-21.5, 1.5, 123.51).add(mPosition), "./assets/signalisation_berge.obj");
    
    // Spawn des Murs de soutènement gardes-fous
    tmpObj = new U3DObject(uni, new PVector(123.5, 8, 0).add(mPosition), "./assets/concreteWall.obj");
    tmpObj.setAngles(new PVector(0,HALF_PI, 0));
    
    tmpObj = new U3DObject(uni, new PVector(-123.5, 8, 0).add(mPosition), "./assets/concreteWall.obj");
    tmpObj.setAngles(new PVector(0,3*HALF_PI, 0));
    
    tmpObj = new U3DObject(uni, new PVector(0, 8, -123.5).add(mPosition), "./assets/concreteWall.obj");
    
    // Ecluse
    tmpObj = new U3DObject(uni, new PVector(0, -8.009, 121).add(mPosition), "./assets/concreteWall2.obj");
    
    tmpObj = new U3DObject(uni, new PVector(0, -23.009, 121).add(mPosition));
    
    tmpObj = new U3DObject(uni, new PVector(-2.8, -8, 250).add(mPosition), "./assets/concreteWall2.obj");
    tmpObj.setAngles(new PVector(0,HALF_PI, 0));
    
    tmpObj = new U3DObject(uni, new PVector(-26.5, -8, 250).add(mPosition), "./assets/concreteWall2.obj");
    tmpObj.setAngles(new PVector(0,3*HALF_PI, 0));
  }
  
  @Override
  void animate(){}
  
  void applyGravity(U3DObject o){
    if(second()-lastGravity == 0)
      return;
    PVector pos = o.getPosition();
    if(inBetween(-125, pos.x, 125) && inBetween(-125, pos.z, 125)){
      PVector a = o.getInertia();
      if(pos.y > 2+o.getSize().y){
        a.y -= getGravity();
      }else if(pos.y < 2){
        o.getPosition().y = 2+o.getSize().y;
      }
    }else if(pos.y > 0) {
      PVector a = o.getInertia();
      a.y -= getGravity();
    }
  }
  
  void finishedFrame(){
    lastGravity = second();
  }
  
  // --- Display Planet
  void display(){
    super.display();
    pushMatrix();
      /* Water */
      translate(-14.35, -12, -90);
      rotateX(HALF_PI);
      
      pushMatrix();
        fill(#002045);
        translate(0,0,15);
        rect(400,0,2100,2100);
      popMatrix();
      
      mWave.updateNoise();
      translate(-475, 0, 0);
      
      mWave.renderWave();
      
    popMatrix();
    pushMatrix();
      translate(-25.5,1.80,125);
      scale(1,1,1.33);
      rotateX(HALF_PI);
      mEauEcluse.updateNoise();
      mEauEcluse.renderWave();
    popMatrix();
      
  }
  float getGravity(){
    return gravity;
  }
}
