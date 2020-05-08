import java.util.Iterator;

class U3DObject {
  protected Earth mPlanet;
  
  protected PVector mPosition;
  protected PVector mInertia;
  protected PVector mAngles;
  
  // An object car rotate round a defined center (if not set, it turns round its own center)
  protected PVector mRotationZCenter;
  protected float mRotationZr;
  
  protected PShape mShape;
  
  protected float mAirResistFactor;
  
  protected boolean touchingEarth, mCollide;
  protected ArrayList<Animation> mAnimations;
  
  U3DObject(){
    mPosition = mAngles =
    mInertia = new PVector(0,0,0);
    
    mShape = loadShape("./assets/interrogationPoint.obj");
    
    mAirResistFactor = 0.58f;
    touchingEarth = false;
    mCollide = false;
    
    mAnimations = new ArrayList<Animation>();
  }
  
  // Constructeur par copie
  // Attention, la Shape est une shallow copy, si vous voulez un clone ayant sa propre matrice de transformations, utilisez setShapeSRC.
  U3DObject(U3DObject original){
    mPosition = original.getPosition().copy();
    mInertia = original.getInertia().copy();
    
    mShape = original.getShape();
    mAngles = original.getAngles();
    mAngles = new PVector(0,0,0);
    
    mAnimations = original.getAnimations();
  }
  
  void apply_gravity(){
    if(mPlanet == null)
      return;
      
    if(!touchingEarth && mPosition.y>2){
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
            (inBetween(oPos.z, mPos.z+mSize.z, oPos.z+oSize.z) || inBetween(oPos.z, mPos.z, oPos.z+oSize.z))&&
            (inBetween(oPos.y, mPos.y+mSize.y, oPos.y+oSize.y) || inBetween(oPos.y, mPos.y, oPos.y+oSize.y)))&&
            !((collided instanceof SelectionDetectorObject)||(collided instanceof SelectionDetectorObject||(collided instanceof Me))) ){
             
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
        setAngles(a.getNewValue());
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
      shape(mShape, 0, 0);
      
      // DEBUG:
      if(mShape.getName() == null || !mShape.getName().equals("noStroke")){
        noFill();
        stroke(192);
        strokeWeight(1);
        PVector dim = getSize().mult(2);
        box(dim.x, dim.y, dim.z);
      }
    popMatrix();
    
      if(mRotationZCenter != null){
        pushMatrix();
        translate(mRotationZCenter.x, mRotationZCenter.y, mPosition.z);
        noStroke();
        fill(#FF0000);
        sphere(.1);
        popMatrix();
      }
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
  /** durations milliseconds */
  void addAnimation(String type, float a, int duration, boolean reversed){
    if(type.equals("rotateZ"))
      mAnimations.add(new Animation(mAngles, new PVector(mAngles.x, mAngles.y, a), duration, true, reversed));
  }
  
  void addAnimation(String type, float a, int duration){
    addAnimation(type,a,duration,false);
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
  
  boolean doCollisions(){
    return mCollide;
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
    PVector alpha = angle.copy().sub(mAngles);
    mShape.rotate(alpha.x, 1,0,0);
    mShape.rotate(alpha.y, 0,1,0);
    mShape.rotate(alpha.z, 0,0,1);
    if(alpha.z != 0 && mRotationZCenter != null){
      setPos(new PVector( mRotationZCenter.x - cos(mAngles.z)*mRotationZr,
                          mRotationZCenter.y - sin(mAngles.z)*mRotationZr,
                          mPosition.z));
    }
    mAngles = angle;
  }
  
  void setShapeName(String str){
    mShape.setName(str);
  }
  
  void setAngleY(float a){
    setAngles(new PVector(mAngles.x, a, mAngles.z));
  }
  void setAngleZ(float a){
    setAngles(new PVector(mAngles.x, mAngles.y, a));
  }
  
  void setRotationZCenter(PVector center){
    mRotationZCenter = center;
    mRotationZr = mRotationZCenter.x-mPosition.x;
  }
  
  void disableCollisions(){
    mCollide = false;
  }
  
  /** Sets the source of the main shape of the object. Don't call this at each frame, it is verry slow ! */
  void setShapeSRC(String src){
    mShape = loadShape(src);
  }
  
  void setSelectionState(boolean state){
    
  }
}
