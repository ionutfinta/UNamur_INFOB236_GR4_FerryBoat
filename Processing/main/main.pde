import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;


SelectionDetectorObject detector;


//U3DObject selected; A remplacer par une fonction de Me:
boolean is2DEnv;

// Instance principale de l'ui:
UI mainUI;

void setup(){
  size(1024,768,P3D);
  is2DEnv = false;
  
  myUniverse = new Universe();
  
  myUniverse.init();
  me = myUniverse.spawnMyself("God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = myUniverse.spawnCar(new PVector(0, 2, 110));
  mCar2 = myUniverse.spawnCar(new PVector(-10, 2, 110));
  myFirstCar.setSelectionState(true);
  mBarriere1 = myUniverse.spawnBarriere(new PVector(-11.5, 2.629905, 123.5));
  mBarriere2 = myUniverse.spawnBarriere(new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI,0));
  
  // Ferry de 3 'compartiments' = 18 places
  mFerry = myUniverse.spawnFerry(3);
  
  detector = myUniverse.initSelector();
  
  
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
    Select(me);
  }
  
  // Tu peux relayer toutes les fonctions de main à ta classe ainsi:
  mainUI.mousePressed();
}

void Select(Me observer){
  detector.send(observer.getPosition(), observer.getCamDir());
}
