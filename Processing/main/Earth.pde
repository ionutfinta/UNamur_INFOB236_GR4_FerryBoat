class Earth extends U3DObject{
  private int gravity;
  private Wave mWave;
  
  Earth(){
    mShape = loadShape("./assets/berge.obj");
    mPosition = new PVector(0, 2, 0);
    
    
    gravity = 10;
    
    mWave = new Wave();
  }
  
  void load(Universe uni){
    // Spawn des Gardes-fous et insertion dans l'univers des objets
    U3DObject tmpObj = new U3DObject();
    tmpObj.setShapeSRC("./assets/poteau.obj");
    tmpObj.setShapeName("noStroke");
    tmpObj.setPlanet(this);
    
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
    tmpObj = new U3DObject();
    tmpObj.setShapeSRC("./assets/signalisation_berge.obj");
    tmpObj.setPos(new PVector(-21.5, 1.5, 123.51).add(mPosition));
    uni.addObject(tmpObj);
    
    // Spawn des Murs de soutènement gardes-fous
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/concreteWall.obj");
    tmpObj.setPos(new PVector(123.5, 8, 0).add(mPosition));
    tmpObj.setAngles(new PVector(0,HALF_PI, 0));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/concreteWall.obj");
    tmpObj.setPos(new PVector(-123.5, 8, 0).add(mPosition));
    tmpObj.setAngles(new PVector(0,3*HALF_PI, 0));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/concreteWall.obj");
    tmpObj.setPos(new PVector(0, 8, -123.5).add(mPosition));
    tmpObj.setAngles(new PVector(0,0,0));
    uni.addObject(tmpObj);
    
    // Ecluse
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setPos(new PVector(0, -8.009, 121).add(mPosition));
    tmpObj.setShapeSRC("./assets/concreteWall2.obj");
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setPos(new PVector(0, -23.009, 121).add(mPosition));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/concreteWall2.obj");
    tmpObj.setPos(new PVector(-2.8, -8, 250).add(mPosition));
    tmpObj.setAngles(new PVector(0,HALF_PI, 0));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/concreteWall2.obj");
    tmpObj.setPos(new PVector(-26.5, -8, 250).add(mPosition));
    tmpObj.setAngles(new PVector(0,3*HALF_PI, 0));
    uni.addObject(tmpObj);
  }
  
  void display(){
    super.display();
    pushMatrix();
      /* Water */
      rotateX(HALF_PI);
      translate(-350-125, -1.2, 50);
      mWave.renderWave();
    popMatrix();
  }
  
  int getGravity(){
    return gravity;
  }
}
