//preset for buttons
boolean button(String name, float x, float y)
{
  boolean isCalled = false;
  boolean overBox = false;
  float xCenter = x*width/10;
  float yCenter = y*height/10;
  
  ui.stroke(0);
  ui.noFill();
  ui.strokeWeight(3);
  ui.rect(xCenter, yCenter, width/5, height/10, 30);
  
  if(mouseX < xCenter + width/10 && mouseX > xCenter - width/10
  && mouseY < yCenter + height/20 && mouseY > yCenter - height/20)
  {
    overBox = true;
  }
  
  if(overBox == true)
  {
    ui.textSize(height/35);
    ui.fill(0);
    ui.text(name, xCenter, yCenter);
  }
  else
  {
    ui.textSize(height/40);
    ui.fill(0);
    ui.text(name, xCenter, yCenter);
  }
  if(mousePressed && overBox)
  {
    isCalled = true;
    mousePressed = false;
  }
  return isCalled;
}

//preset for messages

void message(String name, float x, float y, int intColor)
{
  float xCenter = x*width/10;
  float yCenter = y*height/10;
  
  ui.fill(intColor);
  ui.text(name, xCenter, yCenter);
}

boolean leaveUI(float x, float y)
{
  boolean isCalled = button("Return to game", x ,y);
  if(isCalled)
  {
    return true;
  }
  return false;
}

void readyBoat(float x, float y)
{
  boolean isCalled = button("Prepare ferry", x ,y);
  if(isCalled)
  {
     //ask for user input and summon right amount of compartments?
    BRelation<Integer, Integer> capacities =  new BRelation<Integer, Integer>(new Pair<Integer, Integer>(1,12),new Pair<Integer, Integer>(2,12),new Pair<Integer, Integer>(3,12));
     if(!myEventBMachine.evt_Boat_ready.guard_Boat_ready(capacities)){
      println("Fatal Error ! Guard for Boat Ready Unsatisfaied, Could not create a new Ferry !");
      return;
    }
    
    myEventBMachine.evt_Boat_ready.run_Boat_ready(capacities);

    mFerry = new Ferry(myUniverse, 3);
    println(myEventBMachine.get_bs_p());
  }
}

void leaveBoat(float x, float y)
{
  boolean isCalled = button("Leave dock", x ,y);
  if(isCalled)
  {
     if(mFerry==null || !myEventBMachine.evt_Boat_leave.guard_Boat_leave()){
      println("EventB Guard not satisfied in order to remove the Ferry.");
      return;
    }
    myEventBMachine.evt_Boat_leave.run_Boat_leave();

    mFerry.remove(myUniverse);
  }
}

void addCar(float x, float y)
{
  boolean isCalled = button("Add car", x ,y);
  if(isCalled)
  {
    if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.voiture))
    {
      cars.add(new Car(myUniverse, new PVector(-16, 4, 96.5 - (2.75*cars.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.voiture);
      cars.get(cars.size()-1).setID(ID);
      ID++;
      topLeft = "Car added";
    }
    else
    {
      topLeft = "Car could not be added";
    }
    TLfade = 0;
  }
}
void addTruck1(float x, float y)
{
  boolean isCalled = button("Add truck of size 1", x ,y);
  if(isCalled)
  {
    if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.camion_1))
    {
      CyberTrucks.add(new CyberTruck(myUniverse, new PVector(-9, 4, 96.5 - (2.75*CyberTrucks.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.camion_1);
      CyberTrucks.get(CyberTrucks.size()-1).setID(ID);
      ID++;
      topRight = "CyberTruck added";
    }
    else
    {
      topRight = "CyberTruck could not be added";
    }
    TRfade = 0;
  }
}
void addTruck2(float x, float y)
{
  boolean isCalled = button("Add truck of size 2", x ,y);
  if(isCalled)
  {
     if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.camion_2))
    {
      Trucks.add(new Truck(myUniverse, new PVector(-28, 4, 96.7 - (3*Trucks.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.camion_2);
      Trucks.get(Trucks.size()-1).setID(ID);
      ID++;
      bottomLeft = "Truck added";
    }
    else
    {
      bottomLeft = "Truck could not be added";
    }
    BLfade = 0;
  }
}
void addTruck3(float x, float y)
{
  boolean isCalled = button("Add truck of size 3", x ,y);
  if(isCalled)
  {
    if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.camion_3))
    {
      Limousines.add(new Limousine(myUniverse, new PVector(8, 4, 96.5 - (2.75*Limousines.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.camion_3);
      Limousines.get(Limousines.size()-1).setID(ID);
      ID++;
      bottomRight = "Limousine added";
    }
    else
    {
      bottomRight = "Limousine could not be added";
    }
    BRfade = 0;
  }
}

void selectLvl1(float x, float y)
{
  boolean isCalled = button("Level 1 reservations", x ,y);
  if(isCalled)
  {
    reservation = true;
    lvl = 1;
  }
}
void selectLvl2(float x, float y)
{
  boolean isCalled = button("Level 2 reservations", x ,y);
  if(isCalled)
  {
    reservation = true;
    lvl = 2;
  }
}
void selectLvl3(float x, float y)
{
  boolean isCalled = button("Level 3 reservations", x ,y);
  if(isCalled)
  {
    reservation = true;
    lvl = 3;
  }
}

void noReservation(float x, float y)
{
  boolean isCalled = button("No reservation", x ,y);
  if(isCalled)
  {
    reservation = false;
  }
}

void exitApp(float x, float y)
{
  boolean isCalled = button("Exit the application", x ,y);
  if(isCalled)
  {
    exit();
  }
}
