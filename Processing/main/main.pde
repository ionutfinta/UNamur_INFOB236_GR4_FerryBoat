import processing.opengl.*;

Universe myUniverse;

Me me;
Car myFirstCar;
PImage skyBox;
int slowFPS = (int) frameRate;

void setup(){
  size(1024,768,P3D);
  myUniverse = new Universe();
  me = myUniverse.spawnMyself("God", "Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>"+
                                     "Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>" +
                                     "Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>" +
                                     "Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject");

  myFirstCar = myUniverse.spawnCar();
  
  skyBox = loadImage("./assets/skybox_test.jpg");
}

void draw(){
  //background(255);
  background(skyBox);
  myUniverse.display();
  
  if(second()%2 == 0 && millis() % 1000 <= 300){
    slowFPS = (int)frameRate;
  }
  
  textSize(32);
  text("FPS: " + slowFPS, 10, 30);
}
