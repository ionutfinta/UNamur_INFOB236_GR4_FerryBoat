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
    /*U3DObject tmpObj = new U3DObject();
    tmpObj.setShapeSRC("./assets/poteau.obj");
    tmpObj.setPlanet(this);
    
    for(int i = 102; i >= 0; i-=2){
      tmpObj = new U3DObject(tmpObj);
      tmpObj.setPos(new PVector(-20.5-i, 0, 123.41).add(mPosition));
      uni.addObject(tmpObj);
    }
    for(int i = 136; i > 0; i-=2){
      tmpObj = new U3DObject(tmpObj);
      tmpObj.setPos(new PVector(-12.135065+i, 0, 123.41).add(mPosition));
      tmpObj.setAngles(new PVector(0,i==138?HALF_PI:PI,0));
      uni.addObject(tmpObj);
    }
    
    // Spawn du panneau de signalisation berge
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/signalisation_berge.obj");
    tmpObj.setPos(new PVector(-21.5, 1.5, 123.51).add(mPosition));
    tmpObj.setAngles(new PVector(0,0,0));
    uni.addObject(tmpObj);
    
    // Spawn des Murs de soutènement gardes-fous
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setShapeSRC("./assets/concreteWall.obj");
    tmpObj.setPos(new PVector(123.5, 0, 0).add(mPosition));
    tmpObj.setAngles(new PVector(0,HALF_PI, 0));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setPos(new PVector(-123.5, 0, 0).add(mPosition));
    tmpObj.setAngles(new PVector(0,3*HALF_PI, 0));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setPos(new PVector(0, 0, -123.5).add(mPosition));
    tmpObj.setAngles(new PVector(0,0,0));
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setPos(new PVector(0, -0.009, 121).add(mPosition));
    tmpObj.setShapeSRC("./assets/concreteWall2.obj");
    uni.addObject(tmpObj);
    
    tmpObj = new U3DObject(tmpObj);
    tmpObj.setPos(new PVector(0, -15.009, 121).add(mPosition));
    uni.addObject(tmpObj);*/
  }
  
  void display(){
    super.display();
    pushMatrix();
      /* Water */
      translate(-250-125, 0, -50);
      //mWave.renderWave();
    popMatrix();
  }
  
  int getGravity(){
    return gravity;
  }
}
