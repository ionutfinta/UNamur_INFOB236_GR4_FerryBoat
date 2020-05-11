class Vehicle extends U3DObject{
  PVector[] mWheelsPos;
  PVector[] mWheelsAngles;
  String mWheelShape;
  
  float speedMult;
  
  private boolean isSelected;
  private float angularSpeed;
  private float rotationAngle;
  private PVector  directionalVector;
  
  public int apparent_id = 0;
  
  Vehicle(Universe uni, PVector pos, String shape) {
    super(uni, pos, shape);
    setMovable(uni);
    mCollide = true;
    speedMult = 0.2;
    angularSpeed = 0.05;
    rotationAngle = 0;
    directionalVector = new PVector(0,0,1);
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
        mInertia.add(directionalVector);
      }
      if(key == 's')
        mInertia.sub(directionalVector);
      
      if(key == 'q'){
         updateRotation(true);
     }
     if(key == 'd'){
         updateRotation(false);
     }
        
      mInertia.z*=speedMult;
      mInertia.x*=speedMult;
    }
  }
  
   
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
