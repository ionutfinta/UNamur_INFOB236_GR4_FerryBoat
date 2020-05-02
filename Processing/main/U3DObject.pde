class U3DObject {
  protected int uniScale;
  protected float limitBelow;
  
  protected PVector mPosition;
  protected PVector mInertia;
  
  protected float mAirResistFactor;
  
  U3DObject(){
    uniScale = 18;
    
     //TODO: Améliorer via un système de collisions
    limitBelow = uniScale*0.250;
    mPosition = new PVector(0,0,0);
    mInertia = new PVector(0,0,0);
    mAirResistFactor = 0.58f;
  }
  
  // --- Must be overwritten
  void apply_gravity(int gravity){
    
   //TODO: Améliorer via un système de collisions
   
    if(mPosition.y < limitBelow){
      mInertia.y += (float)gravity /uniScale;
    }else{
      mPosition.y = limitBelow;
      mInertia.y = 0;
    }
  }
  
  void animate(int gravity){
    apply_gravity(gravity);
    applyInertia();
  }
  void display(){
  }
  
  // --- 3D Moving
  void applyInertia(){
    mPosition.add(mInertia);
    mInertia.mult(mAirResistFactor);
  }
}
