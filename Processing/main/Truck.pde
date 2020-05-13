class Truck extends Vehicle {
  Truck(Universe u, PVector pos){
    super(u, pos, "truck.obj");
  }
  
  
  @Override
  int getVehicleType(){
    return myEventBMachine.camion_2;
  }
}
