class SelectionBeam extends U3DObject{
  
  private PVector beamDir;
  private ArrayList<U3DObject> objects;
  private float len_limit;
  
  SelectionBeam(ArrayList<U3DObject> obj ,PVector pos, PVector dir, float proj_size, float l){
    //create a "projectile" of size proj_size
    mSize = new PVector(proj_size, proj_size, proj_size);
    //move it center
    mPosition = pos.copy().add(mSize.div(-2.0));
    //normalize direction and move according to size
    beamDir = dir.copy().normalize().mult(proj_size);
    mInertia = beamDir;
    
    objects = obj;
    len_limit = l;
    
    
    
  }
  
  void selectFirst(){
    boolean collided = false;
    int i = 0;
    
    //loop until collision and if collision with selectable, clear all and select that one
    while(!collided && i<len_limit){
      
      for(U3DObject o : objects){
        
        if(this.collision(o)){
          
          
          
          if(o.isSelectable()){
            clearSelected(objects);  
            o.setSelectionState(true);
          }
          
          collided = true;
        }
        
        //break from for loop once found
        if(collided)
          break;
      }
      
      i++;
      super.applyInertia();
    }
  }
  
  
  
  public void clearSelected(ArrayList<U3DObject> obj){
    for(U3DObject o : obj){
      if(o.isSelectable()){
        o.setSelectionState(false);
      }
    }
  }
  
  
  
}
