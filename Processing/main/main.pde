import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;
Ferry mFerry;
EntitySelector selector;

void setup(){
  size(1024,768,P3D);
  myUniverse = new Universe();
  me = myUniverse.spawnMyself("God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = myUniverse.spawnCar(new PVector(14.515, -50.0, 100));
  mCar2 = myUniverse.spawnCar(new PVector(10, -50.0, 100));
  
  //TODO: C'est trop bizzare, soit je suis mort fatiggué soit la barrière bouge en fonction d'où on la regarde !
  mBarriere1 = myUniverse.spawnBarriere(new PVector(12.6698, -3, 121.83273));
  
  mFerry = myUniverse.spawnFerry();
  
  myUniverse.handleCollisions();
  myUniverse.handleSelection();
}

void draw(){
  me.setBackground();
  myUniverse.display();
}

void mousePressed(){
  
}

void SelectEntity(Me observer, Universe u, float distance){
  boolean found = false;
  U3DObject found_object;
  
  U3DObject detector = new SelectionDetectorObject();
  
  detector.setSize(new PVector(10,10,10));
  detector.setPos(me.getPosition());
  detector.setInertia(me.getCamDir());
  
  for(float i = 0; i<distance && !found; i+=1){
    found_object = myUniverse.reportCollisionsWith(detector);
    if(found_object != null && found_object.isSelectable()){
      found = true;
      found_object.setSelectionState(true);
    }
  }
}
