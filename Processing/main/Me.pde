class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
  private PVector cameraDir;
  
  private float cameraSpeed;
  float rotationAngle;
  float elevationAngle;
  
  PImage mSkyBox;
  PImage mSkyBoxWater;
  
  PGraphics mBackground;
  
 Me(String m, String ap){
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject"))
     ap = "port";
   absPosition = ap;
   
   mPosition = new PVector(-703.41016, 0.0, 712.5138);
   cameraDir = new PVector(-1.6473945, 1.3935885, -8.847943);
   elevationAngle = 0.1554687;
   rotationAngle = -2.957511;
   cameraSpeed = uniScale*.5f;
   
   mSkyBox = loadImage("./assets/skybox_test.jpg");
   mSkyBoxWater = loadImage("./assets/skybox_water.jpg");
   mBackground = createGraphics(width, height);
 }
 
 void animate(int gravity){
   if(mode.equals("God")){
   if(keyPressed == true){
     if(key == CODED){
       if(keyCode == UP){
         mInertia = cameraDir;
         super.applyInertia();
         updateCameraDir();
       }
       if(keyCode == DOWN){
         mInertia = cameraDir.mult(-1);
         super.applyInertia();
         
         updateCameraDir();
       }
       if(keyCode == LEFT){
         PVector goLeft = new PVector(-cameraDir.x, -cameraDir.z).rotate(HALF_PI);
         mInertia.x = goLeft.x;
         mInertia.y = 0;
         mInertia.z = goLeft.y;
         
         super.applyInertia();
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         PVector goLeft = new PVector(-cameraDir.x, -cameraDir.z).rotate(-HALF_PI);
         mInertia.x = goLeft.x;
         mInertia.y = 0;
         mInertia.z = goLeft.y;
         
         super.applyInertia();
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
     if(elevationAngle >= TWO_PI) elevationAngle -= TWO_PI;
     if(elevationAngle < 0) elevationAngle += TWO_PI;
     if(rotationAngle >= PI) rotationAngle -= TWO_PI;
     if(rotationAngle <= -PI) rotationAngle += TWO_PI;
 }
 
 void updateCameraDir(){
     cameraDir.x = cameraSpeed*sin(rotationAngle);
     cameraDir.y = cameraSpeed*sin(elevationAngle);
     cameraDir.z = cameraSpeed*cos(rotationAngle);
 }
 
 void setBackground(){
   int factor = (int) (tan(-elevationAngle/2.15) * height);
     
   mBackground.beginDraw();
   mBackground.image(mSkyBox, 0,0, width, height);
   mBackground.image(mSkyBoxWater, 0, height/2+factor, width, height);
   if(height/2+factor < 0)
     mBackground.image(mSkyBoxWater, 0, 0, width, height);
   mBackground.endDraw();
   background(mBackground);
 }
 
 void display(){
   if(absPosition.equals("port")){
     camera(mPosition.x, mPosition.y, mPosition.z, mPosition.x+cameraDir.x, mPosition.y+cameraDir.y, mPosition.z+cameraDir.z, 0, 1, 0);
     pushMatrix();
       fill(#FFFFFF);
       textSize(9);
       translate(mPosition.x+cameraDir.x-7*uniScale, mPosition.y+cameraDir.y-2*uniScale, mPosition.z+cameraDir.z-7*uniScale);
       text("CamSpeed " + cameraSpeed, 0,0);
       text("FPS: " + (int)frameRate, 10, 30);
     popMatrix();
     pointLight(51, 102, 126, 0, -50, 0);
     ambientLight(51, 102, 126);
  }
 }
}
