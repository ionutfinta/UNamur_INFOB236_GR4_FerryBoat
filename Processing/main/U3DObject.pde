import java.util.Iterator;

class U3DObject {
  protected PVector mPosition;

  // Inertia represents the speed, in m/s in all the directions
  protected PVector mInertia;
  protected PVector mAngles;
  
  // An object car rotate round a defined center (if not set, it turns round its own center)
  protected PVector mRotationZCenter;
  protected float mRotationZr;
  
  protected PShape mShape;
  
  protected float mAirResistFactor;
  
  protected boolean mCollide;
  protected ArrayList<Animation> mAnimations;
  
  
  U3DObjects everything;
  
  U3DObject(){
    mPosition = mAngles =
    mInertia = new PVector(0,0,0);
    everything = null;
    
    mShape = loadShape("./assets/interrogationPoint.obj");
    
    mAirResistFactor = 0.58f;
    mCollide = false;
    
    
    
    mAnimations = new ArrayList<Animation>();
  }
  
  U3DObject(Universe u){
    this();
    u.addObject(this);
  }

  U3DObject(Universe u, PVector pos){
    this(u);
    mPosition = pos;
  }
  
  U3DObject(Universe u, PVector pos, String shape){
    this(u, pos);
    mShape = loadShape(shape);
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
  
  void handle_collision(U3DObject collided){
    if(doCollisions()){    
      //only used by SelectionDetectorObject for now
         
    }
          
  }
    
  void animate(){
    if(isMovable())
    applyInertia();
    
    
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
      shape(mShape,0,0);
      
      if(DEBUG){
        if(mShape.getName() == null || !mShape.getName().equals("noStroke")){
          noFill();
          stroke(192);
          strokeWeight(1);
          PVector dim = getSize().mult(2);
          box(dim.x, dim.y, dim.z);
        }
      }
    popMatrix();

    if(DEBUG){
      if(mRotationZCenter != null){
        pushMatrix();
        translate(mRotationZCenter.x, mRotationZCenter.y, mPosition.z);
        noStroke();
        fill(#FF0000);
        sphere(.1);
        popMatrix();
      }
    }
  }
  
  // --- 3D Moving
  void applyInertia(){
    if(!doCollisions()){
      mPosition.add(mInertia);
      mInertia.mult(mAirResistFactor);
      return;
    }
    //no movement past -5
      if(mPosition.y<-5){
        return;
      }
      
      //if it's trying to move
      
      if(mInertia.x!=0||mInertia.z!=0||mInertia.y!=0){
         handle_entity_collision();
          mPosition.add(mInertia);
          mInertia.mult(mAirResistFactor);
        
      }
  }
  
  boolean checkInteria(PVector mInert){
    //x
    
    return false;
  }
  
  //returns true if a single collision is encountered
  void handle_entity_collision(){
    
    
       
            
       Iterator<U3DObject> iter2;
       U3DObject o1 = this;
       U3DObject o2;
       
        
      
      if(!o1.doCollisions())
        return; //shouldn't get here
      
      else{
          //check earth
          handle_entity_collision(o1, everything.get(0));
          
        try{
         iter2 = everything.n_closest(5, o1);
        }catch(IllegalArgumentException i){
          System.err.println(i);
          print(i);
          iter2 = everything.iterator();
        }catch(NullPointerException n){
          System.err.println(n);
          print(n);
          iter2 = everything.iterator();
        }
          
        while(iter2.hasNext()){
          o2 = iter2.next();
          
          if(o1==o2 || o2 instanceof Me || o2 instanceof SelectionArrow);
          else{
            handle_entity_collision(o1,o2);
          }
        }
      }
  }
  
  void handle_entity_collision(U3DObject o1,U3DObject o2){
          boolean collided_once = false;
    
            PVector oPos,
            oSize,
            mPos,
            mPosNext,
            mInert,
            mSize;
              
            mPos = o1.getPosition().copy();
            mPosNext =  o1.getPosition().copy().add(mInertia);
            mInert = o1.getInertia().copy();
            mSize = o1.getSize().copy();
    
             oPos = o2.getPosition().copy().add(o2.getInertia());
             oSize = o2.getSize().copy();
             
            if(mInertia.x!=0 
            && (inBetween(mPosNext.x-mSize.x, oPos.x+oSize.x, mPosNext.x+oSize.x) || inBetween(mPosNext.x-mSize.x, oPos.x, mPosNext.x+mSize.x) || inBetween(oPos.x, mPosNext.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x, mPosNext.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPos.z-mSize.z, oPos.z+oSize.z, mPos.z+oSize.z) ||inBetween(mPos.z-mSize.z, oPos.z-oSize.z, mPos.z+mSize.z) || inBetween(oPos.z-oSize.z, mPos.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPos.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPos.y-mSize.y, oPos.y+oSize.y, mPos.y+oSize.y) ||inBetween(mPos.y-mSize.y, oPos.y-oSize.y, mPos.y+mSize.y) || inBetween(oPos.y-oSize.y, mPos.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPos.y+mSize.y, oPos.y+oSize.y))){
              mInertia.x-=mInertia.x;
              collided_once = true;
            }
            if(mInertia.z!=0
            && (inBetween(mPos.x-mSize.x, oPos.x+oSize.x, mPos.x+oSize.x) || inBetween(mPos.x-mSize.x, oPos.x, mPos.x+mSize.x) || inBetween(oPos.x, mPos.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x, mPos.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPosNext.z-mSize.z, oPos.z+oSize.z, mPosNext.z+oSize.z) ||inBetween(mPosNext.z-mSize.z, oPos.z-oSize.z, mPosNext.z+mSize.z) || inBetween(oPos.z-oSize.z, mPosNext.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPosNext.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPos.y-mSize.y, oPos.y+oSize.y, mPos.y+oSize.y) ||inBetween(mPos.y-mSize.y, oPos.y-oSize.y, mPos.y+mSize.y) || inBetween(oPos.y-oSize.y, mPos.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPos.y+mSize.y, oPos.y+oSize.y))){
              mInertia.z-=mInertia.z;
              collided_once = true;
            }
            
            if(mInertia.y!=0 
            && (inBetween(mPos.x-mSize.x, oPos.x+oSize.x, mPos.x+oSize.x) || inBetween(mPos.x-mSize.x, oPos.x, mPos.x+mSize.x) || inBetween(oPos.x, mPos.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x, mPos.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPos.z-mSize.z, oPos.z+oSize.z, mPos.z+oSize.z) ||inBetween(mPos.z-mSize.z, oPos.z-oSize.z, mPos.z+mSize.z) || inBetween(oPos.z-oSize.z, mPos.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPos.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPosNext.y-mSize.y, oPos.y+oSize.y, mPosNext.y+oSize.y) ||inBetween(mPosNext.y-mSize.y, oPos.y-oSize.y, mPosNext.y+mSize.y) || inBetween(oPos.y-oSize.y, mPosNext.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPosNext.y+mSize.y, oPos.y+oSize.y))){
              mInertia.y-=mInertia.y;
            if(o2 instanceof Earth)
              print("earth");
              collided_once = true;
            }      
                  
             if(collided_once){
                  o1.handle_collision(o2);
                  o2.handle_collision(o1);
             }
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
  
  boolean isMovable(){
    return everything != null;
  }
  
  // --- Mutators
  void setPos(PVector p){
    mPosition = p;
  }
  
  void setMovable(Universe uni){
    everything = uni.objs;
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
