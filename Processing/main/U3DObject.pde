class U3DObject {
  protected Earth mPlanet;
  
  protected PVector mPosition;
  // This size represents the half of the size of the object.
  protected PVector mSize;
  protected PVector mInertia;
  
  protected float mAirResistFactor;
  
  U3DObject(){
    mPosition = mSize = 
    mInertia = new PVector(0,0,0);
    
    mAirResistFactor = 0.58f;
  }
  
  // --- Must be overwritten
  void apply_gravity(){
    if(mPlanet == null)
      return;
   
    if(! collision(mPlanet)){
      mInertia.y -= (float)mPlanet.getGravity()/18.0f;
    }
    
  }
  
  void handle_entity_collision(){
    if(collidingEntities()==null || collidingEntities().isEmpty()){return;}
    
     PVector oPos,
            oSize,
            mPos,
            oInert;
            
      float max_y_offset = Float.MAX_VALUE;
      
     for(U3DObject o : collidingEntities()){
       oPos = o.getPosition();
       oSize = o.getSize();
       mPos = mPosition;
       oInert = o.getInertia();
       
       //if object INSIDE another one, teleport up
      if(((mPos.x)-mSize.x < (oPos.x)+oSize.x && (mPos.x) + mSize.x > (oPos.x)-oSize.x) && 
        ((mPos.y)-mSize.y < (oPos.y)+oSize.y && (mPos.y) + mSize.y > (oPos.y)-oSize.y) && 
        ((mPos.z)-mSize.z < (oPos.z)+oSize.z && (mPos.z) + mSize.z > (oPos.z)-oSize.z)){
          if(oPos.y+oSize.y > max_y_offset)
            max_y_offset = oPos.copy().y+oSize.copy().y+mSize.y;
          mPos.y = max_y_offset;
      }
     
    
    if(collidingEntities()!=null && !collidingEntities().isEmpty()){
      mInertia.mult(0);
      removeCollidingEntities();
    }
    }
 }
  
  
  void animate(){
    apply_gravity();
    handle_entity_collision();
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
    if(mPosition.y <= 0)
      return true;
    
    PVector oPos = o.getPosition(),
            oSize = o.getSize(),
            mPos = mPosition,
            oInert = o.getInertia();
    
    return ((mPos.x+mInertia.x)-mSize.x <= (oPos.x+oInert.x)+oSize.x && (mPos.x+mInertia.x) + mSize.x >= (oPos.x+oInert.x)-oSize.x) &&
           ((mPos.y+mInertia.y)-mSize.y <= (oPos.y+oInert.y)+oSize.y && (mPos.y+mInertia.y) + mSize.y >= (oPos.y+oInert.y)-oSize.y) &&
           ((mPos.z+mInertia.z)-mSize.z <= (oPos.z+oInert.z)+oSize.z && (mPos.x+mInertia.z) + mSize.z >= (oPos.z+oInert.z)-oSize.z);
  }
  
  float dist(U3DObject o){
    return mPosition.dist(o.getPosition());
  }
  
  // --- Observers
  PVector getInertia(){
    return mInertia;
  }
  
  PVector getPosition(){
    return mPosition;
  }
  
  PVector getSize(){
    return mSize;
  }
  
  boolean isSelectable(){
    return false;
  }
  
  ArrayList<U3DObject> collidingEntities(){
    return new ArrayList<U3DObject>();
  }
  
  boolean doCollisions(){
    return false;
  }
  
  // --- Mutators
  void setPlanet(Earth p){
    mPlanet = p;
  }
  
  void setPos(PVector p){
    //mPosition = p;
  }
  void setSize(PVector s){
    //mSize = s;
  }
  void setInertia(PVector i){
    //mInertia = i;
  }
  
  void setSelectionState(boolean state){
    
  }
  
  void addCollidingEntity(U3DObject o){
    
  }
  
  void removeCollidingEntities(){
    
  }
  


public ArrayList<U3DObject> sortByDistance(ArrayList<U3DObject> list, U3DObject o){
  ArrayList<U3DObject> temp_list = new ArrayList<U3DObject>();
  ArrayList<U3DObject> remaining_list = new ArrayList<U3DObject>(list);
  
  for(U3DObject e: list){
    temp_list.add(closestObject(remaining_list, o));
    remaining_list.remove(closestObject(remaining_list, o));
  }
  return temp_list;
}

public  U3DObject closestObject(ArrayList<U3DObject> list, U3DObject o){
  float min = Float.MAX_VALUE;
  U3DObject ans = null;
  for(U3DObject e: list){
    if(e.getPosition().dist(o.getPosition())<min){
      min = e.getPosition().dist(o.getPosition());
      ans = e;
    }
  }
  return ans;
}

}
