import processing.opengl.*;

static final boolean DEBUG = true;

fifthRef myEventBMachine;
Universe myUniverse;
Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;

SelectionDetectorObject selector;

// Instance principale de l'ui:
UI mainUI;

void setup(){
  size(1024,768,P3D);
  shapeMode(CORNER);
  smooth(4);
  
  // --- Initialisation
  myEventBMachine = new fifthRef();
  myUniverse = new Universe();
  myUniverse.init();
  
  me = new Me(myUniverse, "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                           "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                           "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                           "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = new Car(myUniverse, new PVector(-20, 10, 120));
  mCar2 = new Car(myUniverse, new PVector(-20, 10, 100));
  
  mBarriere1 = new Barriere(myUniverse, myEventBMachine, new PVector(-11.5, 2.629905, 123.5));
  mBarriere2 = new Barriere(myUniverse, null, new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI,0));
  
  // Spawn Ferry avec 3 compartiments
  mFerry = new Ferry(myUniverse, 3, myEventBMachine);
  
  selector = myUniverse.initSelector();  
  
  // Instantiation de l'ui:
  mainUI = new UI();
}

void draw(){
  background(255);
  if(mainUI.canIReturn3D()){
    me.setBackground();
    myUniverse.display();
  }else{
    mainUI.draw();
  }
}

void keyReleased(){
  switch(key){
    case '0':
       if(mBarriere1.switchState());
         mBarriere2.switchState();
       break;
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    //SelectEntity(me, myUniverse, 30);
    selector.send(me.getPosition(), me.getCamDir(), me.getCamRotationAngle(), me.getCamElevationAngle());
  }

  mainUI.mousePressed();
}
