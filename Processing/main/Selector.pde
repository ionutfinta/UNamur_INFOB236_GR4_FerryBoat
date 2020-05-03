class EntitySelector extends U3DObject{
  
  private ArrayList<U3DObject> collidingEntities;
  
  private PVector beamDir;
  private float len_limit;
  
  EntitySelector(PVector pos, PVector dir, float proj_size, float l){
    //create a "projectile" of size proj_size
    mSize = new PVector(proj_size, proj_size, proj_size);
    //move it center
    mPosition = pos.copy().add(mSize.div(-2.0));
    //normalize direction and move according to size
    beamDir = dir.copy().normalize().mult(proj_size);
    mInertia = beamDir;
    
    len_limit = l;
    
    
    
  }
 
  
  @Override
  void handle_entity_collision(){
    boolean selected = false;
    ArrayList<U3DObject> list;
    if(!collidingEntities().isEmpty()){
      closestObject(collidingEntities(), this).setSelectionState(true);
      removeCollidingEntities();
    }
  }
  
  @Override
  boolean doCollisions(){
    return true;
  }
  
  @Override
  void addCollidingEntity(U3DObject o){
    if(collidingEntities == null){
      collidingEntities = new ArrayList<U3DObject>();
    }
    collidingEntities.add(o);
  }
  
  @Override
  void removeCollidingEntities(){
    collidingEntities = new ArrayList<U3DObject>();
  }
  
  @Override 
  ArrayList<U3DObject> collidingEntities(){
    return collidingEntities;
  }
  
}
