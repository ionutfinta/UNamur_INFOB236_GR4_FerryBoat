class Universe{
  U3DObjects objs;
  
  
  
  Universe(){
    objs = new U3DObjects();
    objs.add( new Earth() );
  }
  
  void init(){
    getEarth().load(this);
  }
  
  void display(){
    for(U3DObject o: objs){
      o.animate();
      o.display();
    }
  }
  
  void addObject(U3DObject o){
    objs.add(o);
  }
  
  SelectionDetectorObject initSelector(){
    SelectionArrow arr = new SelectionArrow();
    objs.add(arr);
    SelectionDetectorObject selec = new SelectionDetectorObject(arr);
    addObject(arr);
    addObject(selec);
    return selec;
  }
  
    
  Car spawnCar(PVector pos){
    Car c = new Car(pos, this);
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
    Barriere b = new Barriere(pos, angle, this);
    b.setPlanet(getEarth());
    objs.add(b);
    return b;
  }
  
  // Exemple d'overloading : Permet de spawner la barrière sans donner son angle
  Barriere spawnBarriere(PVector pos){
    Barriere b = new Barriere(pos, new PVector(0,0,0), this);
    b.setPlanet(getEarth());
    objs.add(b);
    return b;
  }
  
  Ferry spawnFerry(int lg){
    Ferry f = new Ferry(lg, this);
    f.setPlanet(getEarth());
    objs.add(f);
    return f;
  }
  
  Earth getEarth(){
    return (Earth) objs.get(0);
  }
  
  

}
