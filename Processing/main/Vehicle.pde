class Vehicle extends U3DObject{
  PVector[] mWheelsPos;
  PVector[] mWheelsAngles;
  String mWheelShape;
  
  float speedMult;
  
  private boolean isSelected;
  
  public int apparent_id = 0;
  
  Vehicle(Universe uni, PVector pos, String shape) {
    super(uni, pos, shape);
    setMovable(uni);
    mCollide = true;
    speedMult = 1;
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
  
  /* Inspiration for turning the wheels:
  
      mShape.getChild(0).resetMatrix();
      mShape.getChild(0).rotateY(-HALF_PI);
      mShape.getChild(0).translate(mWheelsPos[i].x, mWheelsPos[i].y, mWheelsPos[i].z);
  */
  
  void animate(){
    super.animate();
    if(keyPressed == true && isSelected()){
      if(key == 'z'){
        mInertia.z += .05f;
      }
      if(key == 'a'){
        mInertia.z += .05f;
        mInertia.x += .01f;
      }
      if(key == 'e'){
        mInertia.z += .05f;
        mInertia.x -= .01f;
      }
      if(key == 'q'){
        mInertia.x += .01f;
        mInertia.z -= .03f;
      }
      if(key == 'd'){
        mInertia.x -= .01f;
        mInertia.z -= .03f;
      }
      if(key == 's')
        mInertia.z -= .03f;
        
      mInertia.z*=speedMult;
      mInertia.x*=speedMult;
    }
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
  }
  
  int getId(){
    return apparent_id;
  }
  
  void setID(int ID) //Setter
  {
    this.apparent_id  = ID;
  }
}
