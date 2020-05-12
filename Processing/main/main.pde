import processing.opengl.*;

static final boolean DEBUG = true;
static final fifthRef myEventBMachine = new fifthRef();
static PGraphics ui;

Universe myUniverse;
Me me;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;
Lift mLift;

boolean return3D;

ArrayList<Car> cars = new ArrayList<Car>();
ArrayList<CyberTruck> CyberTrucks = new ArrayList<CyberTruck>();
ArrayList<Limousine> Limousines = new ArrayList<Limousine>();
ArrayList<Truck> Trucks = new ArrayList<Truck>();

int ID = 1;
int lvl = 1;

SelectionDetectorObject selector;

void setup(){
  size(1024,768,P3D);
  ui = createGraphics(width,height);
  shapeMode(CORNER);
  smooth(4);
  
  // --- Initialisation
  myUniverse = new Universe();
  myUniverse.init();
  return3D = false;
  
  me = new Me(myUniverse, "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                           "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                           "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                           "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  //init vehicles
  cars.add(new Car(myUniverse, new PVector(-100, -100, -100)));
  CyberTrucks.add(new CyberTruck(myUniverse, new PVector(-100, -100, -100)));
  Limousines.add(new Limousine(myUniverse, new PVector(-100, -100, -100)));
  Trucks.add(new Truck(myUniverse, new PVector(-100, -100, -100)));
  
  Scaner scan = new Scaner(myUniverse, true,myEventBMachine);
  Scaner scan2 = new Scaner(myUniverse, false,myEventBMachine);
  mLift = new Lift(myUniverse, new PVector(-14.5, -10, 131.65));
  
  mBarriere1 = new Barriere(myUniverse, new PVector(-11.5, 2.629905, 123.5));
  mBarriere2 = new Barriere(myUniverse, new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI,0), true);
  
  // Spawn Ferry avec 3 compartiments
  mFerry = new Ferry(myUniverse, 3);
  
  selector = myUniverse.initSelector();  
}

void draw(){
  me.setBackground();
  if(return3D)
    myUniverse.display();
}

void keyReleased(){
  switch(key){
    case '0':
       if(mBarriere1.switchState());
         mBarriere2.switchState();
       break;
    case '1':
      if(mFerry != null)
        mFerry.switchRDC();
      break;
    case '2':
      if(mFerry != null)
        mFerry.switchP2();
      break;
    case '3':
      if(mFerry != null)
        mFerry.switchP3();
      break;
    case '4':
      mLift.switchLiftIn();
      break;
    case '5':
      mLift.switchLiftOut();
      break;
      
    case 'o':
      mLift.move_lift(mLift.getFloor()-1);
      break;
    
    case 'p':
      mLift.move_lift(mLift.getFloor()+1);
      break;
  }
}

void mousePressed(){
  
  if(mouseButton == LEFT){
    //SelectEntity(me, myUniverse, 30);
    selector.send(me.getPosition(), me.getCamDir(), me.getCamRotationAngle(), me.getCamElevationAngle());
  }
}
