class Universe{
  U3DObjects objs;
  
  CollisionHandler col_hand;
  
  
  Universe(){
    objs = new U3DObjects();
    shapeMode(CORNER);
    objs.add( new Earth() );
  }
  
  void init(){
    getEarth().load(this);
    
    col_hand = new CollisionHandler(myUniverse.objs);
    startCollision();
  }
  
  void display(){
    
    for(U3DObject o: objs){
      o.animate();
      o.display();
    }
  }
  
  void addObject(U3DObject o){
    objs.add(o);
    col_hand = new CollisionHandler(myUniverse.objs);
  }
  
  SelectionDetectorObject initSelector(){
    SelectionArrow arr = new SelectionArrow();
    objs.add(arr);
    SelectionDetectorObject selec = new SelectionDetectorObject(arr);
    addObject(arr);
    addObject(selec);
    return selec;
  }
  
  void startCollision(){
    new Thread()
{
    public void run() {
        while(true)
          col_hand.handle_entity_collision();
    }
}.start();
  
  }
    
  Car spawnCar(PVector pos){
    Car c = new Car(pos);
    c.setPlanet(getEarth());
    objs.add(c);
    col_hand = new CollisionHandler(myUniverse.objs);
    return c;
  }
  
  
  Me spawnMyself(String mode, String position){
    Me m = new Me(mode, position);
    m.setPlanet(getEarth());
    objs.add(m);
    col_hand = new CollisionHandler(myUniverse.objs);
    return m;
  }
  
  Barriere spawnBarriere(PVector pos, PVector angle){
    Barriere b = new Barriere(pos, angle, this);
    b.setPlanet(getEarth());
    objs.add(b);
    col_hand = new CollisionHandler(myUniverse.objs);
    return b;
  }
  
  // Exemple d'overloading : Permet de spawner la barrière sans donner son angle
  Barriere spawnBarriere(PVector pos){
    Barriere b = new Barriere(pos, new PVector(0,0,0), this);
    b.setPlanet(getEarth());
    objs.add(b);
    col_hand = new CollisionHandler(myUniverse.objs);
    return b;
  }
  
  Ferry spawnFerry(){
    Ferry f = new Ferry();
    f.setPlanet(getEarth());
    objs.add(f);
    col_hand = new CollisionHandler(myUniverse.objs);
    return f;
  }
  
  Earth getEarth(){
    return (Earth) objs.get(0);
  }
  
  

}
