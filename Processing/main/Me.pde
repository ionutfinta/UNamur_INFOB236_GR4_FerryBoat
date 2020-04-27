class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
 Me(String m, String ap){
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers"))
     ap = "port";
   absPosition = ap;
   camera(250, height/2, (height/2) / tan(PI/6), 250, height/2, 0, 0, 1, 0);
 }
 
 void animate(){
   if(mode.equals("God"))
     return;
 }
 
 void display(){
   if(absPosition.equals("port")){
     if(mousePressed)
        camera(mouseX, height/2, (height/2) / tan(PI/6), mouseY, height/2, 0, 0, 1, 0);
     if(absPosition.equals("port"))
     directionalLight(126, 126, 126, 0, 0, -1);
     ambientLight(188, 11, 95);
   }
 }
}
