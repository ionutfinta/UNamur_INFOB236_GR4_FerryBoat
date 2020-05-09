import processing.opengl.*;

fifthRef myEventBMachine;
Universe myUniverse;
Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;

SelectionDetectorObject selector;


// A remplacer par une fonction de Me:
boolean is2DEnv;

// Instance principale de l'ui:
UI mainUI;

void setup(){
  size(1024,768,P3D);
  shapeMode(CORNER);
  smooth(4);
  is2DEnv = true;
  
  // --- Initialisation
  myEventBMachine = new fifthRef();
  
  myUniverse = new Universe();
  myUniverse.init();
  
  me = new Me(myUniverse, "God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = new Car(myUniverse, new PVector(-20, 11, 120));
  mCar2 = new Car(myUniverse, new PVector(-20, 10, 100));
  
  mBarriere1 = new Barriere(myUniverse, new PVector(-11.5, 2.629905, 123.5));
  mBarriere2 = new Barriere(myUniverse, new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI,0));
  
  // Spawn Ferry avec 3 compartiments
  mFerry = new Ferry(myUniverse, 3, myEventBMachine);
  
  selector = myUniverse.initSelector();  
  
  // Instantiation de l'ui:
  mainUI = new UI();
}

void draw(){
  me.setBackground();
  if(! is2DEnv){
    myUniverse.display();
    
    //--- Controls in 3D environement... maybe we should move that later...
    if(keyPressed && key=='0'){
       mBarriere1.switchState();
       mBarriere2.switchState();
    }
  }
  else{
    mainUI.draw();
    is2DEnv = !mainUI.canIReturn3D();
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    //SelectEntity(me, myUniverse, 30);
    selector.send(me.getPosition(), me.getCamDir(), me.getCamRotationAngle(), me.getCamElevationAngle());
  }

  // Tu peux relayer toutes les fonctions de main à ta classe ainsi:
  mainUI.mousePressed();
}
