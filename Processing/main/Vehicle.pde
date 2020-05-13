class Vehicle extends U3DObject{
  PVector[] mWheelsPos;
  PVector[] mWheelsAngles;
  String mWheelShape;
  
  float speedMult;
  
  private boolean isSelected;
  private float angularSpeed;
  private float rotationAngle;
  private PVector  directionalVector;
  
  private int mQueue;
  public int apparent_id = 0;
  
  Vehicle(Universe uni, PVector pos, String shape) {
    super(uni, pos, shape);
    setMovable(uni);
    mCollide = true;
    speedMult = 0.2;
    angularSpeed = 0.05;
    rotationAngle = HALF_PI;
    directionalVector = new PVector(1,0,0);
    mQueue = 0;
    setAngles(new PVector(0,HALF_PI, 0));
  }
  
  void initWheels(){
   if(mWheelsPos == null || mWheelsAngles == null)
     return;
     
   for(int i = 0; i < mWheelsPos.length ; i++){
      mShape.addChild(loadShape(mWheelShape), i);
      mShape.getChild(i).rotateY(mWheelsAngles[i].y);
      mShape.getChild(i).translate(mWheelsPos[i].x, mWheelsPos[i].y, mWheelsPos[i].z);
   }
  }
  
  void animate(){
    super.animate();
    if(keyPressed == true && isSelected()){
      if(pressedKeys.contains('z')){
        mInertia.add(directionalVector);
      }
      if(pressedKeys.contains('s'))
        mInertia.sub(directionalVector);
      
      if(pressedKeys.contains('q')){
         updateRotation(true);
         steere(-QUARTER_PI);
     }else{steere(0);}
     if(pressedKeys.contains('d')){
         updateRotation(false);
         steere(QUARTER_PI);
     }else{steere(0);}
        if(key == 'c')
        println(mPosition);
      mInertia.z*=speedMult;
      mInertia.x*=speedMult;
    }
    
    // ---- Gestion de Vehicle_in et Vehicle_out(Event-B)
    PVector mSize = getSize();
    if(inBetween(114, mPosition.z + mSize.z, 116) && inBetween(-19.5, mPosition.x, -12)){
      if(mQueue == 0){
        boolean is_left = mPosition.x + mSize.x <= -14.8;
        if(is_left && myEventBMachine.evt_Vehicle_in.guard_Vehicle_in(true, myEventBMachine.get_queue2())){
          myEventBMachine.evt_Vehicle_in.run_Vehicle_in(true, myEventBMachine.get_queue2());
          mQueue = 1;
        }else if(!is_left && myEventBMachine.evt_Vehicle_in.guard_Vehicle_in(myEventBMachine.get_queue1(), true)){
          myEventBMachine.evt_Vehicle_in.run_Vehicle_in(myEventBMachine.get_queue1(), true);
          mQueue = 2;
        }
      }
    }else if (mQueue > 0 && !inBetween(111, mPosition.z + mSize.z, 115) && !inBetween(-19.5, mPosition.x, -12) && !myEventBMachine.get_auth_on_ids().has(getId())){
      if(mQueue == 1 && myEventBMachine.evt_Vehicle_out.guard_Vehicle_out(false, myEventBMachine.get_queue2())){
        myEventBMachine.evt_Vehicle_out.run_Vehicle_out(false, myEventBMachine.get_queue2());
        mQueue = 0;
      }if(mQueue == 2 && myEventBMachine.evt_Vehicle_out.guard_Vehicle_out(myEventBMachine.get_queue1(), false)){
        myEventBMachine.evt_Vehicle_out.run_Vehicle_out(myEventBMachine.get_queue1(), false);
        mQueue = 0;
      }
    }
  }
  
  // --- Usefull for Event-B
  int getId(){
    return apparent_id;
  }
  
  
  void setID(int ID) //Setter
  {
    this.apparent_id  = ID;
  }
  
  int getQueue(){
    return mQueue;
  }
  
  /** Must be Overriden ! **/
  int getVehicleType(){
    return 0;
  }
  
  // --- Driving Functions
 void updateRotation(boolean positive){
   if(positive){
     mShape.rotate(-angularSpeed,0,1,0);
     rotationAngle-=angularSpeed;
   
   }
   else{
     mShape.rotate(angularSpeed,0,1,0);
     rotationAngle+=angularSpeed;
   }
   directionalVector.x = sin(rotationAngle);
   directionalVector.z = cos(rotationAngle);
   
 }
 
 void steere(float a){
   // Doesn't Work because of Processing :'(
   /*for(int i = 0; i < 2; i++){
     mShape.getChild(i).resetMatrix();
     mShape.getChild(i).rotateY(a);
     mShape.getChild(i).translate(mWheelsPos[i].x, mWheelsPos[i].y, mWheelsPos[i].z);
   }*/
 }
 
 @Override
 void handle_collision(U3DObject o){/*
           PVector oPos,
            oSize,
            mPos,
            mInert,
            mSize;
              
            mPos = this.getPosition();
            mInert = this.getInertia();
            mSize = this.getSize();
            oPos = o.getPosition();
            oSize = o.getSize();
   
             if  ((inBetween(mPos.x-mSize.x, oPos.x+oSize.x, mPos.x+mSize.x) || inBetween(mPos.x-mSize.x, oPos.x-mSize.x, mPos.x+mSize.x) || inBetween(oPos.x-oSize.x, mPos.x-mSize.x, oPos.x+oSize.x) || inBetween(oPos.x-oSize.x, mPos.x+mSize.x, oPos.x+oSize.x))
            &&(inBetween(mPos.z-mSize.z, oPos.z+oSize.z, mPos.z+mSize.z) ||inBetween(mPos.z-mSize.z, oPos.z-oSize.z, mPos.z+mSize.z) || inBetween(oPos.z-oSize.z, mPos.z-mSize.z, oPos.z+oSize.z) || inBetween(oPos.z-oSize.z, mPos.z+mSize.z, oPos.z+oSize.z))
            &&(inBetween(mPos.y-mSize.y, oPos.y+oSize.y, mPos.y+mSize.y) ||inBetween(mPos.y-mSize.y, oPos.y-oSize.y, mPos.y+mSize.y) || inBetween(oPos.y-oSize.y, mPos.y-mSize.y, oPos.y+oSize.y) || inBetween(oPos.y-oSize.y, mPos.y+mSize.y, oPos.y+oSize.y))){
              mPosition.y += mPos.y-(oPos.y+oSize.y);
            }
             was supposed to tp up when stuck */ 
 }
  
  @Override
  boolean isSelectable(){
    return true;
  }
  
  @Override
  boolean isSelected(){
    return isSelected;
  }
  
  @Override
  void setSelectionState(boolean state){
    isSelected = state;
    if(state = true){
      me.attachObject(this);
      me.getPosition().y = 7;
      me.getPosition().z -= 5;
    }
  }
}
