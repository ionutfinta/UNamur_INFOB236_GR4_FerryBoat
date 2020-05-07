import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;

U3DObject selected;
SelectionArrow arrow;


// A remplacer par une fonction de Me:
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
  mCar2 = myUniverse.spawnCar(new PVector(-10, 2, 110));
  
  mBarriere1 = myUniverse.spawnBarriere(new PVector(-11.5, 2.629905, 123.5));
  mBarriere2 = myUniverse.spawnBarriere(new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI,0));
  mBarriere2.setOuvert();
  
  mFerry = myUniverse.spawnFerry();
  
  arrow = new SelectionArrow();
  
  myUniverse.handleCollisions();
  
  // Instantiation de l'ui:
  mainUI = new UI();
}

void draw(){
  if(! is2DEnv){
    me.setBackground();
    myUniverse.display();
    arrow.display();
  }
  else{
    mainUI.draw();
    
  }
}

void mousePressed(){
  if(mouseButton == LEFT){
    SelectEntity(me, myUniverse, 30);
    println("Boat position: " + mFerry.getPosition());
  }
  
  // Tu peux relayer toutes les fonctions de main à ta classe ainsi:
  mainUI.mousePressed();
}

void SelectEntity(Me observer, Universe u, float distance){
  boolean found = false;
  U3DObject found_object;
  if(selected!=null)
    selected.setSelectionState(false);
  
  U3DObject detector = new SelectionDetectorObject();
  
  // TODO, trouve un autre moyen que setSize();
  detector.setPos(observer.getPosition().copy());
  detector.setInertia(observer.getCamDir().copy().mult(10));
  
  for(float i = 0; i<distance && !found; i+=1){
    found_object = u.reportCollisionsWith(detector);
    if(found_object != null && found_object.isSelectable()){
      found = true;
      found_object.setSelectionState(true);
      selected = found_object;
      arrow.updateSelected(found_object);
    }
    detector.applyInertia();
  }
}
