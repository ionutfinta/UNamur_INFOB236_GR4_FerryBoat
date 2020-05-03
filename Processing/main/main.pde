import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar, mCar2;
Barriere mBarriere1;

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
}

void draw(){
  me.setBackground();
  myUniverse.display();
  if(keyPressed && key == 'c')
    println("Collision Earth, Car: " + myFirstCar.collision(myUniverse.getEarth()));
}
