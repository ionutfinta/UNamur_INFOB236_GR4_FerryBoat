/*This U3DObject will keep going forward in the same direction at each 'animate' tick
it will then update its selected U3DObject and update its associated SelectionArrow*/

class SelectionDetectorObject extends U3DObject{
  final int IT_LIMIT = 20;
  
  boolean detected;
  int it_since_launch;
  U3DObject selected;
  
  private float rotationAngle;
  private float elevationAngle;
  
  private ArrayList<U3DObject> collidingEntities;
  public SelectionArrow arrow;
  
  SelectionDetectorObject(SelectionArrow arr, Universe u) {
    arrow = arr;
    sendAway();
    detected = false;
    everything = u.objs;
    mAirResistFactor = 1;
  }
  

  @Override
  void handle_collision(U3DObject o){ 
    if(o instanceof Me)
    return;
    
    if(o!=null && selected!=o && o.isSelectable()){
      
      if(selected != null)
        selected.setSelectionState(false);
      selected = o;
      o.setSelectionState(true);
      arrow.updateSelected(o);
      
    }
    detected = true;
    sendAway();
  
  }
  //teleports object to a position where it won't intersect anything
  void sendAway(){
    mPosition = new PVector(1000,1000,1000);
  }
 
  void setDirection(PVector direc, float ra, float ea){
    mInertia = direc.copy();
     rotationAngle = ra;
     elevationAngle = ea;
  }
  
  void setPosition(PVector pos){
    mPosition = pos.copy();    
  }
  
  //Changes direction of projectile accordng to mouse position
  void correctDirection(){
     //default FOV is perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0), where cameraZ is((height/2.0) / tan(PI*60.0/360.0)), PI/3 vertical angle
    //=> the angle between k_hat and the i_hat*width/2 is PI/3 rad, same for j_hat*(width/height)/2
    
    //percentage of distance from center
    float mouse_x = (float) mouseX;
    float mouse_y = (float) mouseY;
    PVector centerRelative = new PVector((mouse_x-((float)width/2))/((float)width/2), -1*(mouse_y-((float)height/2))/((float)height/2));
    
    //basis
    PVector i_hat = new PVector(-1,0,0); //lateral
    PVector j_hat = new PVector(0,1,0); //top/down
    //PVector k_hat = new PVector(0,0,1); //depth
    
    float dir_angle_H = rotationAngle; //horizontal PVector.angleBetween(new PVector(0,1), planeFrom(mInertia,1,0,1))
    float dir_angle_V = elevationAngle/2; //vertical
    
    //maximum angle
    float ik_angle = (PI/3)*((float)width/height)*centerRelative.x/2;
    float jk_angle = (PI/3)*centerRelative.y/2;
      
    //assume inertia to have k component 1, rotate afterwards
    float i_val, j_val, k_val;
    k_val = 1;
    i_val = tan(ik_angle);
    j_val = tan(jk_angle);
    PVector correction = new PVector(i_val,j_val,k_val);
    mInertia.normalize();
    correction = correction.copy().mult(cos(dir_angle_H)).add(j_hat.copy().cross(correction).mult(sin(dir_angle_H))).add(j_hat.copy().mult(j_hat.copy().dot(correction)).mult(1-cos(dir_angle_H)));
    correction = correction.copy().mult(cos(dir_angle_V)).add(i_hat.copy().cross(correction).mult(sin(dir_angle_V))).add(i_hat.copy().mult(i_hat.copy().dot(correction)).mult(1-cos(dir_angle_V)));
    
    mInertia = correction;
    
  }
  
  //launchforward
  void send(PVector pos, PVector dir, float ra, float ea){
    detected = false;
    it_since_launch = 0;
    setDirection(dir,ra,ea);
    setPosition(pos);
    correctDirection();
  }
  

  @Override
  void animate(){
    if(!detected && it_since_launch<IT_LIMIT){
      applyInertia();
    }
  }
  
  @Override
  boolean doCollisions(){
    return true;
  }
  
  @Override
  PVector getSize(){
    return new PVector(0.35,0.35,0.35);
  }
  
  
  
}
