import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar;

void setup(){
  size(1024,768,P3D);
  
  myUniverse = new Universe();
  me = myUniverse.spawnMyself("God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers");

  myFirstCar = myUniverse.spawnCar();
}

void draw(){ 
  background(255);
  myUniverse.display();
} 
