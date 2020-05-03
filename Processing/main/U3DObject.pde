class U3DObject {
  protected Earth mPlanet;
  protected int uniScale;
  protected float limitBelow;
  
  protected PVector mPosition;
  // This size represents the half of the size of the object.
  protected PVector mSize;
  protected PVector mInertia;
  
  protected float mAirResistFactor;
  
  U3DObject(){
    uniScale = 18;
    
    limitBelow = 0;
    
    mPosition = mSize = 
    mInertia = new PVector(0,0,0);
    
    mAirResistFactor = 0.58f;
  }
  
  // --- Must be overwritten
  void apply_gravity(){
    if(mPlanet == null)
      return;
   
    if(! collision(mPlanet)){
      mInertia.y += (float)mPlanet.getGravity() /uniScale;
    }else{
      mInertia.y = 0;
    }
  }
  
  void animate(){
    apply_gravity();
    applyInertia();
  }
  void display(){}
  
  // --- 3D Moving
  void applyInertia(){
    mPosition.add(mInertia);
    mInertia.mult(mAirResistFactor);
  }
  
  // --- Collisions
  boolean collision(U3DObject o){
    if(mPosition.y >= limitBelow)
      return true;
    
    PVector oPos = o.getPosition(),
            oSize = o.getSize(),
            mPos = mPosition;
            
    if(keyPressed && this instanceof Me){
      mPos = mPosition.copy();
      mPos.div(uniScale);
    }
    return (mPos.x-mSize.x <= oPos.x+oSize.x && mPos.x + mSize.x >= oPos.x-oSize.x) &&
           (mPos.y-mSize.y <= oPos.y+oSize.y && mPos.y + mSize.y >= oPos.y-oSize.y) &&
           (mPos.z-mSize.z <= oPos.z+oSize.z && mPos.z + mSize.z >= oPos.z-oSize.z);
  }
  
  float dist(U3DObject o){
    return mPosition.dist(o.getPosition());
  }
  
  // --- Observers
  PVector getPosition(){
    return mPosition;
  }
  
  PVector getSize(){
    return mSize;
  }
  
  boolean isSelectable(){
    return false;
  }
  
  // --- Mutators
  void setPlanet(Earth p){
    mPlanet = p;
  }
}
