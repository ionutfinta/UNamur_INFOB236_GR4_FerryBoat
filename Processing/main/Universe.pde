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
    Earth earth = getEarth();
    
    for(U3DObject o: objs){
      if(o.isMovable() && !(o instanceof SelectionDetectorObject)&& earth != null)
        earth.applyGravity(o);
      o.animate();
      o.display();
    }
  }
  
  void addObject(U3DObject o){
    objs.add(o);
  }
  
  void remove(U3DObject o){
    objs.remove(o);
  }
  
  SelectionDetectorObject initSelector(){
    SelectionArrow arr = new SelectionArrow();
    objs.add(arr);
    SelectionDetectorObject selec = new SelectionDetectorObject(arr, this);
    addObject(arr);
    addObject(selec);
    return selec;
  }
  
  Earth getEarth(){
    return (Earth) objs.get(0);
  }
}
