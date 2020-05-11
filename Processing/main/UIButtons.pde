//preset for buttons
boolean button(String name, float x, float y)
{
  boolean isCalled = false;
  boolean overBox = false;
  float xCenter = x*width/10;
  float yCenter = y*height/10;
  
  stroke(0);
  noFill();
  strokeWeight(3);
  rect(xCenter, yCenter, width/5, height/10, 30);
  
  if(mouseX < xCenter + width/10 && mouseX > xCenter - width/10
  && mouseY < yCenter + height/20 && mouseY > yCenter - height/20)
  {
    overBox = true;
  }
  
  if(overBox == true)
  {
    textSize(height/35);
    fill(0);
    text(name, xCenter, yCenter);
  }
  else
  {
    textSize(height/40);
    fill(0);
    text(name, xCenter, yCenter);
  }
  if(mousePressed && overBox)
  {
    isCalled = true;
    mousePressed = false;
  }
  return isCalled;
}

//preset for temporary messages
void message(String name, float x, float y)
{
  float xCenter = x*width/10;
  float yCenter = y*height/10;
  
  fill(0);
  text(name, xCenter, yCenter);
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
    if(!inBetween(-30, cars.get(cars.size()-1).mPosition.x, -10))
    {
      cars.add(new Car(myUniverse, new PVector(-20, 4, 100)));
      message("Car added", x - 2.5, y);
    }
    else
    {
      message("Parking lot occupied", x-2.5, y);
    }
  }
}
void addTruck1(float x, float y)
{
  boolean isCalled = button("Add truck of size 1", x ,y);
  if(isCalled)
  {
    CyberTruck mCyberTruck = new CyberTruck(myUniverse, new PVector(-12, 4, 84));
  }
}
void addTruck2(float x, float y)
{
  boolean isCalled = button("Add truck of size 2", x ,y);
  if(isCalled)
  {
     Limousine mLimousine = new Limousine(myUniverse, new PVector(-12, 4, 100));
  }
}
void addTruck3(float x, float y)
{
  boolean isCalled = button("Add truck of size 3", x ,y);
  if(isCalled)
  {
    Truck mTruck = new Truck(myUniverse, new PVector(-20, 4, 84));
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
