class Universe {
  ArrayList<U3DObject> objs;
  
  Universe(){
    objs = new ArrayList<U3DObject>();
    objs.add( new Earth() );
  }
  
  void display(){
    for(U3DObject o: objs){
      o.animate();
      o.display();
    }
  }
  
  Car spawnCar(){
    Car c = new Car();
    objs.add(c);
    return c;
  }
  
  
  Me spawnMyself(String mode, String position){
    Me m = new Me(mode, position);
    objs.add(m);
    return m;
  }
}
