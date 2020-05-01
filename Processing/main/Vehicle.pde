class Vehicle extends U3DObject{
  ArrayList<Wheel> wheels;
  ArrayList<PVector> whiteLights;
  
  Vehicle() {
    wheels = new ArrayList<Wheel>();
    whiteLights = new ArrayList<PVector>();
  }
}
