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
  
  Earth getEarth(){
    return (Earth) objs.get(0);
  }
}
