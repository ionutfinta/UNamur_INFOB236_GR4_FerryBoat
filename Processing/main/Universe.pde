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
    SelectionDetectorObject selec = new SelectionDetectorObject(arr, this);
    addObject(arr);
    addObject(selec);
    return selec;
  }
  
  Earth getEarth(){
    return (Earth) objs.get(0);
  }
  
  

}
