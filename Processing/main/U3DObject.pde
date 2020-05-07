import java.util.Iterator;

class U3DObject {
  protected Earth mPlanet;
  
  protected PVector mPosition;
  protected PVector mInertia;
  protected PVector mAngles;
  
  protected PShape mShape;
  
  protected float mAirResistFactor;
  
  protected boolean touchingEarth;
  protected ArrayList<Animation> mAnimations;
  
  U3DObject(){
    mPosition = mAngles =
    mInertia = new PVector(0,0,0);
    
    mShape = loadShape("./assets/interrogationPoint.obj");
    
    mAirResistFactor = 0.58f;
    touchingEarth = false;
    
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
     //temp false while collisions are weird
    if(false &&!touchingEarth && mPosition.y>2){
      mInertia.y -= (float)mPlanet.getGravity()/18.0f;
    }
    
  }
  
  void handle_collision(U3DObject collided){
    if(doCollisions()){    
    PVector oPos,
            oSize,
            mPos,
            mSize;
           
           oPos = collided.getPosition();
              oSize = collided.getSize();
             mPos = this.getPosition();
             mSize = this.getSize();
             
        if(((inBetween(oPos.x, mPos.x+mSize.x, oPos.x+oSize.x) ||inBetween(oPos.x, mPos.x, oPos.x+oSize.x))&& 
            (inBetween(oPos.y, mPos.y+mSize.y, oPos.y+oSize.y) || inBetween(oPos.y, mPos.y, oPos.y+oSize.y))  && 
            (inBetween(oPos.z, mPos.z+mSize.z, oPos.z+oSize.z) || inBetween(oPos.z, mPos.z, oPos.z+oSize.z)))){
             
                mPos.y += oSize.copy().y+mSize.y;
           }
           
        if(collided instanceof Earth){
          touchingEarth = true;
        }
      mInertia.mult(0);
    }
          
  }
    
  void animate(){
    apply_gravity();
    applyInertia();
    if(mPosition.y!=2)
      touchingEarth = false; 
    
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
  
  boolean checkInteria(PVector mInert){
    //x
    
    return false;
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
    return false;
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
    return new PVector(mShape.getWidth(), mShape.getHeight(), mShape.getDepth());
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
  
  
/*
public U3DObjects sortByDistance(U3DObjects list, U3DObject o){
  U3DObjects temp_list = new U3DObjects();
  U3DObjects remaining_list = new U3DObjects(list);
  
  for(U3DObject e: list){
    temp_list.add(closestObject(remaining_list, o));
    remaining_list.remove(closestObject(remaining_list, o));
  }
  return temp_list;
}

public  U3DObject closestObject(U3DObjects list, U3DObject o){
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
*/
}
