class Universe{
  ArrayList<U3DObject> objs;
  Me observer;
  
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
    observer = m;
    return m;
  }
  
  Barriere spawnBarriere(PVector pos){
    Barriere b = new Barriere(pos);
    b.setPlanet(getEarth());
    objs.add(b);
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
              reportCollisionsWith(o1);
          }
        }
    }
   };
  collision_thread.start();
     
  }
  
  private boolean reportCollisionsWith(U3DObject o1){
        boolean found = false;
        if(o1.doCollisions()){
          for(U3DObject o2: objs){
            if(!o1.equals(o2) && o2.doCollisions() && o1.collision(o2)){
              o1.addCollidingEntity(o2);
              o2.addCollidingEntity(o1);
            }
          }
        }
      return found;
  }
  
  
  
  void handleSelection(){
    
    
    Thread selection_thread = new Thread(){
      public void run(){
        EntitySelector selector = new EntitySelector(observer.getPosition(), observer.getCamDir(), 10, 10);
        while(true){
          
          if(true){
            
            boolean found = false;
            
            selector.setPos(observer.getPosition());
            selector.setDir(observer.getCamDir());
            
            for(int i = 0; i<selector.len_limit && !found;i++){
              selector.applyInertia();
              if(reportCollisionsWith(selector)){
                found = true;
              }
            }
            
            
          }
        }
    }
   };
  selection_thread.start();
    
  }


}
