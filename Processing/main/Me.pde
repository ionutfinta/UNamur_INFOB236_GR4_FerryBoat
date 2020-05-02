class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
  private PVector cameraDir;
  
  private float cameraSpeed;
  float rotationAngle;
  float elevationAngle;
  
 Me(String m, String ap){
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject"))
     ap = "port";
   absPosition = ap;
   
   mPosition = new PVector(141.91565, 3.81, 399.17892);
   cameraDir = new PVector(-0.10412201, 0.35225204, -0.99456453);
   elevationAngle = 0.2290752;
   rotationAngle = 3.4299822;
   cameraSpeed = uniScale*.5f;
 }
 
 void animate(int gravity){
   if(mode.equals("God")){
   if(keyPressed == true){
     if(key == CODED){
       if(keyCode == UP){
         mPosition = mPosition.add(cameraDir);
         
         updateCameraDir();
       }
       if(keyCode == DOWN){
         mPosition = mPosition.sub(cameraDir);
         
         updateCameraDir();
       }
       if(keyCode == LEFT){
         PVector new_pos = new PVector(mPosition.x, mPosition.z).sub(new PVector(cameraDir.x, cameraDir.z).rotate(HALF_PI));
         mPosition.x = new_pos.x;
         mPosition.z = new_pos.y;
         
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         PVector new_pos = new PVector(mPosition.x, mPosition.z).sub(new PVector(cameraDir.x, cameraDir.z).rotate(-HALF_PI));
         mPosition.x = new_pos.x;
         mPosition.z = new_pos.y;
         
         updateCameraDir();
       }
       if(keyCode == SHIFT){
         println("Camera position: " + mPosition);
         println("Camera Direction: " + cameraDir);
         println("Elevation: " + elevationAngle);
         println("Rotation: " + rotationAngle);
       }
     }
     if(key == '4'){
         rotationAngle += radians(cameraSpeed);
         updateCameraDir();
     }
     if(key == '6'){
         rotationAngle -= radians(cameraSpeed);
         updateCameraDir();
     }
     if(key == '8'){
         elevationAngle += radians(cameraSpeed);
         updateCameraDir();
     }
     if(key == '2'){
         elevationAngle -= radians(cameraSpeed);
         updateCameraDir();
     }
   }
   if(mousePressed && (pmouseX != mouseX || pmouseY != mouseY)){
     int differenceMouse = pmouseY-mouseY;
     elevationAngle += map(elevationAngle + differenceMouse, elevationAngle - height, elevationAngle + height, -PI, PI);
     
     differenceMouse = pmouseX-mouseX;
     rotationAngle -= map(rotationAngle + differenceMouse, rotationAngle - width, rotationAngle + width, -PI, PI);
     
     truncateAngles();
     
     updateCameraDir();
   }

   //TODO: Améliorer via un système de collisions
   if(mPosition.y > 0)
     mPosition.y = 0;

   return;
   }
   apply_gravity(gravity);
 }
 
 void truncateAngles(){
     if(elevationAngle >= PI) elevationAngle -= TWO_PI;
     if(elevationAngle <= -PI) elevationAngle += TWO_PI;
     if(rotationAngle >= PI) rotationAngle -= TWO_PI;
     if(rotationAngle <= -PI) rotationAngle += TWO_PI;
 }
 
 void updateCameraDir(){
     cameraDir.x = cameraSpeed*sin(rotationAngle);
     cameraDir.y = cameraSpeed*sin(elevationAngle);
     cameraDir.z = cameraSpeed*cos(rotationAngle);
 }
 
 void display(){
   if(absPosition.equals("port")){
     camera(mPosition.x, mPosition.y, mPosition.z, mPosition.x+cameraDir.x, mPosition.y+cameraDir.y, mPosition.z+cameraDir.z, 0, 1, 0);
     pointLight(51, 102, 126, 0, -50, 0);
     ambientLight(51, 102, 126);
  }
 }
}
