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

 private class Message{
  int iterations;
  int currentIteration;
  float x;
  float y;
  String message;
  final int defaultDuration = 15;
  
  public Message(String content, float x_coord, float y_coord, int duration){
    message = content;
    x = x_coord*width/10;
    y = y_coord*height/10;
    iterations = duration;
    currentIteration = iterations;
    
  }
  public Message(String content, float x_coord, float y_coord){
    message = content;
    x = x_coord*width/10;
    y = y_coord*height/10;
    iterations = defaultDuration;
    currentIteration = iterations;
  }
  
  void display(){
    if(currentIteration<iterations){
      ui.fill(0);
      ui.text(message, x, y);
      currentIteration++;
    }
  }
  void activate(){
    currentIteration=0;
  
  }

}


void message(String name, float x, float y)
{
  float xCenter = x*width/10;
  float yCenter = y*height/10;
  
  ui.fill(0);
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
    myEventBMachine.evt_Boat_ready.run_Boat_ready(new BRelation<Integer, Integer>(new Pair<Integer,Integer>(1,3), new Pair<Integer,Integer>(1,3), new Pair<Integer,Integer>(1,3))); //ferry has BRelation mCapacities which represents that
  }
}

void leaveBoat(float x, float y)
{
  boolean isCalled = button("Leave dock", x ,y);
  if(isCalled)
  {
    myEventBMachine.evt_Boat_leave.run_Boat_leave();
  }
}

void addCar(float x, float y)
{
  boolean isCalled = button("Add car", x ,y);
  if(isCalled)
  {
    if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.voiture))
    {
      cars.add(new Car(myUniverse, new PVector(-20, 4, 100 - (20*cars.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.voiture);
      cars.get(cars.size()-1).setID(ID);
      ID++;
      message("Car added", x - 2.5, y);
    }
    else
    {
      message("Car cannot be added here", x-2, y);
      message("Select topmost available floor", x-2, y-2);
    }
  }
}
void addTruck1(float x, float y)
{
  boolean isCalled = button("Add truck of size 1", x ,y);
  if(isCalled)
  {
    if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.camion_1))
    {
      CyberTrucks.add(new CyberTruck(myUniverse, new PVector(-12, 4, 100 - (20*CyberTrucks.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.camion_1);
      CyberTrucks.get(CyberTrucks.size()-1).setID(ID);
      ID++;
      message("CyberTruck added", x + 2.5, y);
    }
    else
    {
      message("Maximum number or EventBMachine error", x + 2.5, y);
    }
  }
}
void addTruck2(float x, float y)
{
  boolean isCalled = button("Add truck of size 2", x ,y);
  if(isCalled)
  {
     if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.camion_2))
    {
      Trucks.add(new Truck(myUniverse, new PVector(-28, 4, 100 - (20*Trucks.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.camion_2);
      Trucks.get(Trucks.size()-1).setID(ID);
      ID++;
      message("Truck added", x - 2.5, y);
    }
    else
    {
      message("Parking lot occupied", x-2.5, y);
    }
  }
}
void addTruck3(float x, float y)
{
  boolean isCalled = button("Add truck of size 3", x ,y);
  if(isCalled)
  {
    if(myEventBMachine.evt_Reserve.guard_Reserve(lvl, myEventBMachine.camion_3))
    {
      Limousines.add(new Limousine(myUniverse, new PVector(-4, 4, 100 - (20*Limousines.size()))));
      if(reservation) myEventBMachine.evt_Reserve.run_Reserve(lvl, myEventBMachine.camion_3);
      Limousines.get(Limousines.size()-1).setID(ID);
      ID++;
      message("Limousine added", x + 2.5, y);
    }
    else
    {
      message("Parking lot occupied", x + 2.5, y);
    }
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
