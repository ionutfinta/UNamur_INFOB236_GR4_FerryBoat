import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;


SelectionArrow arrow;


//U3DObject selected; A remplacer par une fonction de Me:
boolean is2DEnv;

// Instance principale de l'ui:
UI mainUI;

void setup(){
  size(1024,768,P3D);
  shapeMode(CORNER);
  is2DEnv = true;
  
  myUniverse = new Universe();
  
  myUniverse.init();
  me = myUniverse.spawnMyself("God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = myUniverse.spawnCar(new PVector(0, 2, 110));
  mCar2 = myUniverse.spawnCar(new PVector(-10, 5, 110));
  myFirstCar.setSelectionState(true);
  mBarriere1 = myUniverse.spawnBarriere(new PVector(-11.5, 2.629905, 123.5));
  mBarriere2 = myUniverse.spawnBarriere(new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI,0));
  mBarriere2.setOuvert();
  
  mFerry = myUniverse.spawnFerry();
  
  detector = myUniverse.initSelection();
  
  
  // Instantiation de l'ui:
  mainUI = new UI();
}

void draw(){
  me.setBackground();
  if(! is2DEnv){
    myUniverse.display();
    arrow.display();
  }
  else{
    mainUI.draw();
    is2DEnv = !mainUI.canIReturn3D();
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    (me, myUniverse, 30);
    println("Boat position: " + mFerry.getPosition());
  }
  
  // Tu peux relayer toutes les fonctions de main à ta classe ainsi:
  mainUI.mousePressed();
}

void SelectEntity(Me observer, Universe u, float distance){
  boolean found = false;
  
  
  U3DObject detector = new SelectionDetectorObject(arrow);
  
  // TODO, trouve un autre moyen que setSize();
  detector.setPos(observer.getPosition().copy());
  detector.setInertia(observer.getCamDir().copy().mult(10));
  
  for(float i = 0; i<distance; i+=1){
    
    u.col_hand.handle_entity_collision();
    
    detector.applyInertia();
  }
}
