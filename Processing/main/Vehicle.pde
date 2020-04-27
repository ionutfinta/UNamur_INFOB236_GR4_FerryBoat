class Vehicle extends U3DObject{
  ArrayList<Wheel> wheels;

  Vehicle() { 
    wheels = new ArrayList<Wheel>();
  }

  void display() {
    for(Wheel w: wheels){
      w.move();
      w.display();
    }
  }
  
  // Function.  
  void move() {
  }
}
