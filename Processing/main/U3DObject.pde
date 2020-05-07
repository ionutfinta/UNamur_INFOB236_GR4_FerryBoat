import java.util.Iterator;

class U3DObject {
  protected Earth mPlanet;
  
  protected PVector mPosition;
  protected PVector mInertia;
  protected PVector mAngles;
  
  protected PShape mShape;
  
  protected float mAirResistFactor;
  
  protected ArrayList<Animation> mAnimations;
  
  U3DObject(){
    mPosition = mAngles =
    mInertia = new PVector(0,0,0);
    
    mShape = loadShape("./assets/interrogationPoint.obj");
    
    mAirResistFactor = 0.58f;
    
    mAnimations = new ArrayList<Animation>();
  }
  
  // Constructeur par copie
  U3DObject(U3DObject original){
    mPosition = original.getPosition().copy();
    mInertia = original.getInertia().copy();
    mAngles = original.getAngles().copy();
    mShape = original.getShape();
    mAnimations = original.getAnimations();
  }
  
  // --- Must be overwritten
  void apply_gravity(){
    if(mPlanet == null)
      return;
   
    if(! mPlanet.collision(this) && mPosition.y > 0){
      mInertia.y -= (float)mPlanet.getGravity()/18.0f;
    }
    
  }
  
  void handle_entity_collision(){
    if(collidingEntities()==null || collidingEntities().isEmpty()){return;}
    
     PVector oPos,
            oSize,
            mPos,
            oInert,
            mSize;
      mSize = getSize();
      float max_y_offset = Float.MAX_VALUE;
      
     for(U3DObject o : collidingEntities()){
       oPos = o.getPosition();
       oSize = o.getSize();
       mPos = mPosition;
       oInert = o.getInertia();
       
       //if object INSIDE another one, teleport up
      if(((mPos.x)-getSize().x < (oPos.x)+oSize.x && (mPos.x) + mSize.x > (oPos.x)-oSize.x) && 
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
    
    Iterator<Animation> ait = mAnimations.iterator();
    while(ait.hasNext()){
      Animation a = ait.next();
      if(a.affectsAngles()){
        mAngles = a.getNewValue();
      }
      else{
        mPosition = a.getNewValue();
      }
      
      if(a.isElapsed()){
        ait.remove();
      }
    }
  }
  void display(){
    pushMatrix();
      translate(mPosition.x, mPosition.y, mPosition.z);
      rotateX(mAngles.x);
      rotateY(mAngles.y);
      rotateZ(mAngles.z);
      shape(mShape, 0, 0);
    popMatrix();
  }
  
  // --- 3D Moving
  void applyInertia(){
    mPosition.add(mInertia);
    mInertia.mult(mAirResistFactor);
  }
  
  // --- Animations
  /** Rotate around the Z axis in durations milliseconds */
  void addAnimation(String type, float a, int duration){
    if(type.equals("rotateZ"))
      mAnimations.add(new Animation(mAngles, new PVector(mAngles.x, mAngles.y, a), duration, true));
      
    // rev stands for reversed
    if(type.equals("rotateZrev"))
      mAnimations.add(new Animation(mAngles, new PVector(mAngles.x, mAngles.y, a), duration, true, true));
  }
  
  // --- Collisions
  boolean collision(U3DObject o){
    if(mPosition.y <= 0)
      return true;
    
    PVector oPos = o.getPosition(),
            oSize = o.getSize(),
            mPos = mPosition,
            oInert = o.getInertia();
    
    return ((mPos.x+mInertia.x)-getSize().x <= (oPos.x+oInert.x)+oSize.x && (mPos.x+mInertia.x) + getSize().x >= (oPos.x+oInert.x)-oSize.x) &&
           ((mPos.y+mInertia.y)-getSize().y <= (oPos.y+oInert.y)+oSize.y && (mPos.y+mInertia.y) + getSize().y >= (oPos.y+oInert.y)-oSize.y) &&
           ((mPos.z+mInertia.z)-getSize().z <= (oPos.z+oInert.z)+oSize.z && (mPos.x+mInertia.z) + getSize().z >= (oPos.z+oInert.z)-oSize.z);
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
    //TODO: Make this vary in function of mAngles !
    return new PVector(mShape.getWidth(), mShape.getHeight(), mShape.getDepth()).div(2);
  }
  
  PVector getAngles(){
    return mAngles;
  }
  
  PShape getShape(){
    return mShape;
  }
  
  ArrayList<Animation> getAnimations(){
    return mAnimations;
  }
  
  boolean isSelectable(){
    return false;
  }
  
  boolean isSelected(){
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
    mPosition = p;
  }
  
  void setInertia(PVector i){
    mInertia = i;
  }
  
  void setAngles(PVector angle){
    mAngles = angle;
  }
  
  void setShapeName(String str){
    mShape.setName(str);
  }
  
  void setAngleZ(float a){
    mAngles.z = a;
  }
  
  /** Sets the source of the main shape of the object. Don't call this at each frame, it is verry slow ! */
  void setShapeSRC(String src){
    mShape = loadShape(src);
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
