class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
  private PVector cameraPos;
  private PVector cameraDir;
  
  private float cameraSpeed;
  float rotationAngle;
  float elevationAngle;
  
 Me(String m, String ap){
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers"))
     ap = "port";
   absPosition = ap;
   
   cameraPos = new PVector(724, -479, 542);
   cameraDir = new PVector(723.37714, -478.57983, 541.3401);
   elevationAngle = -0.59345734f;
   rotationAngle = -0.8500999f;
   cameraSpeed = 5.0f;
 }
 
 void animate(){
   if(mode.equals("God")){
   if(keyPressed == true){
     if(key == CODED){
       if(keyCode == UP){
         cameraPos.x += cameraSpeed * cos(elevationAngle) * sin(rotationAngle);
         cameraPos.y += cameraSpeed * sin(elevationAngle) * sin(rotationAngle);
         cameraPos.z -= cameraSpeed * cos(rotationAngle);
         
         
         updateCameraDir();
       }
       if(keyCode == DOWN){
         cameraPos.x -= cameraSpeed * cos(elevationAngle) * sin(rotationAngle);
         cameraPos.y -= cameraSpeed * sin(elevationAngle) * sin(rotationAngle);
         cameraPos.z += cameraSpeed * cos(rotationAngle);
         
         updateCameraDir();
       }
       if(keyCode == LEFT){
         cameraPos.x += cameraSpeed * cos(elevationAngle) * sin(rotationAngle-HALF_PI);
         cameraPos.y += cameraSpeed * sin(elevationAngle) * sin(rotationAngle-HALF_PI);
         cameraPos.z -= cameraSpeed * cos(rotationAngle-HALF_PI);
         
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         cameraPos.x += cameraSpeed * cos(elevationAngle) * sin(rotationAngle+HALF_PI);
         cameraPos.y += cameraSpeed * sin(elevationAngle) * sin(rotationAngle+HALF_PI);
         cameraPos.z -= cameraSpeed * cos(rotationAngle+HALF_PI);
         
         updateCameraDir();
       }
       if(keyCode == SHIFT){
         println("Camera position: " + cameraPos);
         println("Camera Direction: " + cameraDir);
         println("Elevation: " + elevationAngle);
         println("Rotation: " + rotationAngle);
       }
     }
   }
   if(mousePressed && (pmouseX != mouseX || pmouseY != mouseY)){
     float differenceMouse = map(pmouseY-mouseY, -height, height, -cameraSpeed/2, cameraSpeed/2);
     elevationAngle += map(elevationAngle + differenceMouse, elevationAngle - cameraSpeed, elevationAngle + cameraSpeed, -PI, PI);
     
     differenceMouse = map(pmouseX-mouseX, -width, width, -cameraSpeed/2, cameraSpeed/2);
     rotationAngle += map(rotationAngle + differenceMouse, rotationAngle - cameraSpeed, rotationAngle + cameraSpeed, -PI, PI);
     
     if(elevationAngle > TWO_PI) elevationAngle -= TWO_PI;
     if(elevationAngle < -TWO_PI) elevationAngle += TWO_PI;
     if(rotationAngle > TWO_PI) rotationAngle -= TWO_PI;
     if(rotationAngle < -TWO_PI) rotationAngle += TWO_PI;
     updateCameraDir();
   }
   return;
   }
   // Code for human mode: Gravity, etc...
 }
 
 void updateCameraDir(){
     cameraDir.x = cameraPos.x + cos(elevationAngle) * sin(rotationAngle);
     cameraDir.y = cameraPos.y + sin(elevationAngle) * sin(rotationAngle);
     cameraDir.z = cameraPos.z - cos(rotationAngle);
 }
 
 void display(){
   if(absPosition.equals("port")){
     camera(cameraPos.x, cameraPos.y, cameraPos.z, cameraDir.x, cameraDir.y, cameraDir.z, 0, 1, 0);
     if(absPosition.equals("port"))
     directionalLight(126, 126, 126, 0, 0, -1);
     ambientLight(188, 11, 95);
   }
 }
}
