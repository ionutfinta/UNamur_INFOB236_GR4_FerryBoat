class Universe{
  ArrayList<U3DObject> objs;
  
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
    handleCollisions();
  }
  
  Car spawnCar(PVector pos){
    Car c = new Car(pos);
    c.setPlanet(getEarth());
    objs.add(c);
    return c;
  }
  
  
  Me spawnMyself(String mode, String position){
    Me m = new Me(mode, position, objs);
    m.setPlanet(getEarth());
    objs.add(m);
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
    for(U3DObject o1: objs){
      if(o1.doCollisions()){
        for(U3DObject o2: objs){
          if(!o1.equals(o2) && o2.doCollisions() && o1.collision(o2)){
            o1.setEntityColliding(true);
            o2.setEntityColliding(true);
            print(o1);
            print(o2);
          }
        }
      }
    }
  }
}
