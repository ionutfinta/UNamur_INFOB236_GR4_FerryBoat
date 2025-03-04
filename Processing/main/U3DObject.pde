import java.util.Iterator;

class U3DObject {
  protected PVector mPosition;

  // Inertia represents the speed, in m/s in all the directions
  protected PVector mInertia;
  protected PVector mAngles;
  
  // An object car rotate round a defined center (if not set, it turns round its own center)
  protected PVector mRotationZCenter;
  protected PVector mRotationXCenter;
  protected PVector mRotationYCenter;
  protected float mRotationZr;
  protected float mRotationXr;
  protected float mRotationYr;
  
  protected PShape mShape;
  
  protected float mAirResistFactor;
  
  protected boolean mCollide;
  protected boolean mCollidable;
  protected ArrayList<Animation> mAnimations;
  
  // An object can be attached to another.
  U3DObject attachedTo;
  PVector attachedTo_oldPos;
  
  // A movable object must have referece to all the others objects. NOTE: Why ?
  U3DObjects everything;
  
  U3DObject(){
    mPosition = mAngles =
    mInertia = new PVector(0,0,0);
    everything = null;
    
    mShape = loadShape("interrogationPoint.obj");
    
    mAirResistFactor = 0.58f;
    mCollide = false;
    mCollidable = true;
    
    
    
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
        setPos(a.getNewValue());
      }
      
      if(a.isElapsed()){
        ait.remove();
      }
    }
    
    if(attachedTo != null){
      PVector atPos = attachedTo.getPosition().copy();
      atPos.sub(attachedTo_oldPos);
      if(atPos.x != 0 || atPos.y != 0 || atPos.z != 0){
        updateCenters(atPos);
        mPosition.add(atPos);
        attachedTo_oldPos = attachedTo.getPosition().copy();
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
      if(mRotationXCenter != null){
        pushMatrix();
        translate(mPosition.x, mRotationXCenter.y, mRotationXCenter.z);
        noStroke();
        fill(#FF0000);
        sphere(.1);
        popMatrix();
      }
      if(mRotationYCenter != null){
        pushMatrix();
        translate(mRotationYCenter.x, mPosition.y, mRotationXCenter.z);
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
          
        try{
         iter2 = everything.n_closest(10, o1);
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
          
          if(o1==o2 || (o2 instanceof Me && o1 instanceof SelectionDetectorObject) || o2 instanceof SelectionArrow);
          else{
            handle_entity_collision(o1,o2);
          }
        }
      }
  }
  
  void handle_entity_collision(U3DObject o1,U3DObject o2){
    
      if(!o2.collidable()) //should not happen unless forced collision
        return;
    
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
            && (inBetween(mPosNext.x-mSize.x, oPos.x+oSize.x, mPosNext.x+mSize.x) || inBetween(mPosNext.x-mSize.x, oPos.x-oSize.x, mPosNext.x+mSize.x) || inBetween(oPos.x-oSize.x, mPosNext.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x-oSize.x, mPosNext.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPos.z-mSize.z, oPos.z+oSize.z, mPos.z+mSize.z) ||inBetween(mPos.z-mSize.z, oPos.z-oSize.z, mPos.z+mSize.z) || inBetween(oPos.z-oSize.z, mPos.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPos.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPos.y-mSize.y, oPos.y+oSize.y, mPos.y+mSize.y) ||inBetween(mPos.y-mSize.y, oPos.y-oSize.y, mPos.y+mSize.y) || inBetween(oPos.y-oSize.y, mPos.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPos.y+mSize.y, oPos.y+oSize.y))){
              mInertia.x-=mInertia.x;
              
              collided_once = true;
            }
            if(mInertia.z!=0
            && (inBetween(mPos.x-mSize.x, oPos.x+oSize.x, mPos.x+mSize.x) || inBetween(mPos.x-mSize.x, oPos.x-mSize.x, mPos.x+mSize.x) || inBetween(oPos.x-oSize.x, mPos.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x-oSize.x, mPos.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPosNext.z-mSize.z, oPos.z+oSize.z, mPosNext.z+mSize.z) ||inBetween(mPosNext.z-mSize.z, oPos.z-oSize.z, mPosNext.z+mSize.z) || inBetween(oPos.z-oSize.z, mPosNext.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPosNext.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPos.y-mSize.y, oPos.y+oSize.y, mPos.y+mSize.y) ||inBetween(mPos.y-mSize.y, oPos.y-oSize.y, mPos.y+mSize.y) || inBetween(oPos.y-oSize.y, mPos.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPos.y+mSize.y, oPos.y+oSize.y))){
              mInertia.z-=mInertia.z;
              collided_once = true;
            }
            
            if(mInertia.y!=0 
            && ((inBetween(mPos.x-mSize.x, oPos.x+oSize.x, mPos.x+mSize.x) || inBetween(mPos.x-mSize.x, oPos.x-mSize.x, mPos.x+mSize.x) || inBetween(oPos.x-oSize.x, mPos.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x-oSize.x, mPos.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPos.z-mSize.z, oPos.z+oSize.z, mPos.z+mSize.z) ||inBetween(mPos.z-mSize.z, oPos.z-oSize.z, mPos.z+mSize.z) || inBetween(oPos.z-oSize.z, mPos.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPos.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPosNext.y-mSize.y, oPos.y+oSize.y, mPos.y+mSize.y) ||inBetween(mPosNext.y-mSize.y, oPos.y-oSize.y, mPos.y+mSize.y) || inBetween(oPos.y-oSize.y, mPosNext.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPosNext.y+mSize.y, oPos.y+oSize.y)))){
              
              mInertia.y-=mInertia.y;
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
    if(type.equals("rotateX"))
      mAnimations.add(new Animation(mAngles, new PVector(a, mAngles.y, mAngles.z), duration, true, reversed));
    if(type.equals("rotateY"))
      mAnimations.add(new Animation(mAngles, new PVector(mAngles.x, a, mAngles.z), duration, true, reversed));
  }
  
  void addAnimation(String type, float a, int duration){
    addAnimation(type,a,duration,false);
  }
  
  void addAnimation(PVector start, PVector end, int duration){
    mAnimations.add(new Animation(start, end ,duration));
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
  
  boolean collidable(){
    return mCollidable;
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
    mAngles = angle;
    mShape.resetMatrix();
    mShape.rotate(mAngles.x, 1,0,0);
    mShape.rotate(mAngles.y, 0,1,0);
    mShape.rotate(mAngles.z, 0,0,1);
    
    
    if(mAngles.z != 0 && mRotationZCenter != null){
      setPos(new PVector( mRotationZCenter.x + cos(mAngles.z)*mRotationZr,
                          mRotationZCenter.y + sin(mAngles.z)*mRotationZr,
                          mPosition.z));
    }
    if(mAngles.x != 0 && mRotationXCenter != null){
      setPos(new PVector( mPosition.x,
                          mRotationXCenter.y + cos(mAngles.x)*mRotationXr,
                          mRotationXCenter.z + sin(mAngles.x)*mRotationXr));
    }
    if(mAngles.y != 0 && mRotationYCenter != null){
      setPos(new PVector( mRotationYCenter.x + cos(mAngles.y)*mRotationYr,
                          mPosition.y,
                          mRotationYCenter.z + sin(mAngles.y)*mRotationYr));
    }
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
    mRotationZr = mPosition.x-mRotationZCenter.x;
  }
  void setRotationXCenter(PVector center){
    mRotationXCenter = center;
    mRotationXr = mPosition.y-mRotationXCenter.y;
  }
  void setRotationYCenter(PVector center){
    mRotationYCenter = center;
    mRotationYr = mPosition.x - mRotationYCenter.x;
  }
  
  void updateCenters(PVector p){
    if(mRotationZCenter != null){
      mRotationZCenter.add(p);
    }
    if(mRotationXCenter != null){
      mRotationXCenter.add(p);
    }
    if(mRotationYCenter != null){
      mRotationYCenter.add(p);
    }
  }
    
  
  void attachObject(U3DObject o){
    attachedTo = o;
    attachedTo_oldPos = o.getPosition().copy();
  }
  
  void detachObjects(){
    attachedTo = null;
    attachedTo_oldPos = null;
  }
  
  void remove(Universe uni){
    uni.remove(this);
  }
  
  void disableCollisions(){
    mCollidable = false;
  }
  
  /** Sets the source of the main shape of the object. Don't call this at each frame, it is verry slow ! */
  void setShapeSRC(String src){
    mShape = loadShape(src);
  }
  
  void setSelectionState(boolean state){
    
  }


}
