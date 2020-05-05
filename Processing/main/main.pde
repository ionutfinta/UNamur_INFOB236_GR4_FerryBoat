import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Barriere mBarriere2;
Ferry mFerry;

void setup(){
  size(1024,768,P3D);
  myUniverse = new Universe();
  me = myUniverse.spawnMyself("God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = myUniverse.spawnCar(new PVector(0, 2, 1));
  mCar2 = myUniverse.spawnCar(new PVector(0, 5, 12));
  
  mBarriere1 = myUniverse.spawnBarriere(new PVector(-11.5, 2.629905, 123.5), new PVector());
  mBarriere2 = myUniverse.spawnBarriere(new PVector(-19.5, 2.629905, 123.5), new PVector(0,PI, 0));
  mBarriere2.setOuvert();
  
  mFerry = myUniverse.spawnFerry();
  
  myUniverse.handleCollisions();
}

void draw(){
  me.setBackground();
  myUniverse.display();
}

void mousePressed(){
  if(mouseButton == LEFT){
    SelectEntity(me, myUniverse, 10);
  }
}

void SelectEntity(Me observer, Universe u, float distance){
  boolean found = false;
  U3DObject found_object;
  
  U3DObject detector = new SelectionDetectorObject();
  
  detector.setSize(new PVector(10,10,10));
  detector.setPos(observer.getPosition().copy());
  detector.setInertia(observer.getCamDir().copy());
  
  for(float i = 0; i<distance && !found; i+=1){
    found_object = u.reportCollisionsWith(detector);
    if(found_object != null && found_object.isSelectable()){
      found = true;
      found_object.setSelectionState(true);
    }
    detector.applyInertia();
  }
}
