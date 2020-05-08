/*This U3DObject will keep going forward in the direction same direction at each 'animate' tick
it will then update its selected U3DObject and update its associated SelectionArrow*/

class SelectionDetectorObject extends U3DObject{
  ArrayList<Wheel> wheels;
  PShape chassis;
  
  final int IT_LIMIT = 20;
  
  boolean detected;
  int it_since_launch;
  U3DObject selected;
  
  private ArrayList<U3DObject> collidingEntities;
  public SelectionArrow arrow;
  
  SelectionDetectorObject(SelectionArrow arr) {
    arrow = arr;
    sendAway();
    detected = false;
  }
  

  @Override
  void handle_collision(U3DObject o){ 
    
    if(o!=null && selected!=o && o.isSelectable()){
      detected = true;
      if(selected != null)
        selected.setSelectionState(false);
      selected = o;
      o.setSelectionState(true);
      arrow.updateSelected(o);
      sendAway();
    }
    
  
  }
  
  void sendAway(){
    mPosition = new PVector(1000,1000,1000);
  }
 
  void setDirection(PVector direc){
    mInertia = direc.copy().mult(3);
  }
  
  void setPosition(PVector pos){
    mPosition = pos.copy();
  }
  
  void send(PVector pos, PVector dir){
    detected = false;
    it_since_launch = 0;
    setDirection(dir);
    setPosition(pos);
  }
  
  @Override
  void applyInertia(){
    mPosition.add(mInertia);
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
    return new PVector(1,1,1);
  }
  
  
  
}
