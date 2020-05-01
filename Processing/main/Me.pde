class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
  private PVector cameraDir;
  
  private float cameraSpeed;
  float rotationAngle;
  float elevationAngle;
  
 Me(String m, String ap){
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers"))
     ap = "port";
   absPosition = ap;
   
   pos_x = 249.03185;
   pos_y = 3.81;
   pos_z =  2127.459;
   cameraDir = new PVector(0, 0, 0);
   elevationAngle = 0;
   rotationAngle = 0;
   cameraSpeed = uniScale*.5f;
 }
 
 void animate(int gravity){
   if(mode.equals("God")){
   if(keyPressed == true){
     if(key == CODED){
       if(keyCode == UP){
         PVector new_pos = new PVector(pos_x, pos_y, pos_z).sub(cameraDir.mult(-cameraSpeed));
         pos_x = new_pos.x;
         pos_y = new_pos.y;
         pos_z = new_pos.z;
         
         updateCameraDir();
       }
       if(keyCode == DOWN){
         PVector new_pos = new PVector(pos_x, pos_y, pos_z).sub(cameraDir.mult(cameraSpeed));
         pos_x = new_pos.x;
         pos_y = new_pos.y;
         pos_z = new_pos.z;
         
         updateCameraDir();
       }
       if(keyCode == LEFT){
         PVector new_pos = new PVector(pos_x, pos_z).sub(new PVector(cameraDir.x, cameraDir.z).rotate(HALF_PI).mult(cameraSpeed));
         pos_x = new_pos.x;
         pos_z = new_pos.y;
         
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         PVector new_pos = new PVector(pos_x, pos_z).sub(new PVector(cameraDir.x, cameraDir.z).rotate(-HALF_PI).mult(cameraSpeed));
         pos_x = new_pos.x;
         pos_z = new_pos.y;
         
         updateCameraDir();
       }
       if(keyCode == SHIFT){
         println("Camera position: " + new PVector(pos_x,pos_y,pos_z));
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
     
     updateCameraDir();
   }

   //TODO: Améliorer via un système de collisions
   if(pos_y > 0)
     pos_y = 0;

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
     cameraDir.x = sin(rotationAngle);
     cameraDir.y = sin(elevationAngle);
     cameraDir.z = cos(rotationAngle);
 }
 
 void display(){
   if(absPosition.equals("port")){
     camera(pos_x, pos_y, pos_z, pos_x+cameraDir.x, pos_y+cameraDir.y, pos_z+cameraDir.z, 0, 1, 0);
     pointLight(51, 102, 126, 0, -50, 0);
     ambientLight(51, 102, 126);
  }
 }
}
