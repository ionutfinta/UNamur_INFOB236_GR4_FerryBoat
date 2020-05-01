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
   
   pos_x = -176.26915;
   pos_y = 5.81;
   pos_z =  -256.0513;
   cameraDir = new PVector(-176.40393, 5.9550138, -255.46675);
   elevationAngle = 0.5788777;
   rotationAngle = 2.616964;
   cameraSpeed = uniScale*.5f;
 }
 
 void animate(int gravity){
   if(mode.equals("God")){
   if(keyPressed == true){
     if(key == CODED){
       if(keyCode == UP){
         pos_x += cameraSpeed * cos(elevationAngle) * sin(rotationAngle);
         pos_y += cameraSpeed * sin(elevationAngle) * sin(rotationAngle);
         pos_z -= cameraSpeed * cos(rotationAngle);
         
         
         updateCameraDir();
       }
       if(keyCode == DOWN){
         pos_x -= cameraSpeed * cos(elevationAngle) * sin(rotationAngle);
         pos_y -= cameraSpeed * sin(elevationAngle) * sin(rotationAngle);
         pos_z += cameraSpeed * cos(rotationAngle);
         
         updateCameraDir();
       }
       if(keyCode == LEFT){
         pos_x += cameraSpeed * cos(elevationAngle) * sin(rotationAngle-HALF_PI);
         pos_z -= cameraSpeed * cos(rotationAngle-HALF_PI);
         
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         pos_x += cameraSpeed * cos(elevationAngle) * sin(rotationAngle+HALF_PI);
         pos_z -= cameraSpeed * cos(rotationAngle+HALF_PI);
         
         updateCameraDir();
       }
       if(keyCode == SHIFT){
         println("Camera position: " + new PVector(pos_x,pos_y,pos_z));
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
     if(pos_y < limitBelow - 0.44){
        y_speed += gravity*0.005;
        pos_y += y_speed;
      }else{
        pos_y = limitBelow - 0.44;
        y_speed = 0;
      }
     updateCameraDir();
   }
   return;
   }
   apply_gravity(gravity);
 }
 
 void updateCameraDir(){
     cameraDir.x = pos_x + cos(elevationAngle) * sin(rotationAngle);
     cameraDir.y = pos_y + sin(elevationAngle) * sin(rotationAngle);
     cameraDir.z = pos_z - cos(rotationAngle);
 }
 
 void display(){
   if(absPosition.equals("port")){
     camera(pos_x, pos_y, pos_z, cameraDir.x, cameraDir.y, cameraDir.z, 0, 1, 0);
     pointLight(51, 102, 126, 0, 0, 0);
     ambientLight(51, 102, 126);
  }
 }
}
