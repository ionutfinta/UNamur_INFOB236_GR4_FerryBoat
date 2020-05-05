class Universe{
  ArrayList<U3DObject> objs;
  U3DObject B;
  
  Universe(){
    shapeMode(CORNER);
    objs = new ArrayList<U3DObject>();
    objs.add( new Earth() );
  }
  
  void display(){
    for(U3DObject o: objs){
      o.animate();
      o.display();
    }
  }
    
  Car spawnCar(PVector pos){
    Car c = new Car(pos);
    c.setPlanet(getEarth());
    objs.add(c);
    return c;
  }
  
  
  Me spawnMyself(String mode, String position){
    Me m = new Me(mode, position);
    m.setPlanet(getEarth());
    objs.add(m);
    return m;
  }
  
  Barriere spawnBarriere(PVector pos, PVector angle){
    Barriere b = new Barriere(pos, angle);
    b.setPlanet(getEarth());
    objs.add(b);
    B = b;
    return b;
  }
  
  
  Ferry spawnFerry(){
    Ferry f = new Ferry();
    f.setPlanet(getEarth());
    objs.add(f);
    return f;
  }
  
  Earth getEarth(){
    return (Earth) objs.get(0);
  }
  
  void handleCollisions(){
    Thread collision_thread = new Thread(){
      public void run(){
        
        while(true){
          for(U3DObject o1: objs){
            
              U3DObject ret = reportCollisionsWith(o1);
              if(o1==B && ret !=null)
                print(ret);
          }
        }
    }
   };
  collision_thread.start();
     
  }
  
  //@returns closest object or null if none were detected
  public U3DObject reportCollisionsWith(U3DObject o1){
    
        
        U3DObject closest = null;
        
        float closeness = Float.MAX_VALUE;
        
        if(o1.doCollisions()){
          for(U3DObject o2: objs){
            if(!o1.equals(o2) && o2.doCollisions() && o1.collision(o2)){
              if(!collisionInArray(o1.collidingEntities(),o2))
                o1.addCollidingEntity(o2);
              if(!collisionInArray(o2.collidingEntities(),o1))
                o2.addCollidingEntity(o1);
              
              if(closest == null){
                closest = o2;
              }
              else{
                if(o2.getPosition().dist(o1.getPosition())<closeness){
                  closeness = o2.getPosition().dist(o1.getPosition());
                  closest = o2;
                }
              }
            }
          }
        }
      return closest;
  }


}
