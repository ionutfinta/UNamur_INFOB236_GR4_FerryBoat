class Truck extends Vehicle {
  Truck(Universe u, PVector pos){
    super(u, pos, "./assets/truck.obj");
  }
  
  
  @Override
  int getVehicleType(){
    return myEventBMachine.camion_2;
  }
}
