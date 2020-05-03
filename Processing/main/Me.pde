class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
  private PVector cameraDir;
  
  private float cameraSpeed;
  private float rotationAngle;
  private float elevationAngle;
  
  
  PImage mSkyBox;
  PImage mSkyBoxWater;
  PImage mSun;
  
  PGraphics mBackground;
  
 Me(String m, String ap){
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject"))
     ap = "port";
   absPosition = ap;
   
   mPosition = new PVector(-353.90564, -582.3443, -376.73193);
   cameraDir = new PVector(1.9988941, 6.518429, 8.775216);
   elevationAngle = 0.8099749;
   rotationAngle = 0.22396708
;
   cameraSpeed = uniScale*.5f;
   
   mSize = new PVector(1, 2.7, 1);
   
   mSkyBox = loadImage("./assets/skybox_test.jpg");
   mSkyBoxWater = loadImage("./assets/skybox_water.jpg");
   mSun = loadImage("./assets/sun.png");
   mBackground = createGraphics(width, height);
   
   
 }
 
 //void select(ArrayList<U3DObject> everything){
  // new Selector(everything, );
 //}
 
 void animate(){
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
   if(mousePressed && mouseButton == RIGHT && (pmouseX != mouseX || pmouseY != mouseY)){
     int differenceMouse = pmouseY-mouseY;
     elevationAngle += map(elevationAngle + differenceMouse, elevationAngle - height, elevationAngle + height, -PI, PI);
     
     differenceMouse = pmouseX-mouseX;
     rotationAngle -= map(rotationAngle + differenceMouse, rotationAngle - width, rotationAngle + width, -PI, PI);
     
     truncateAngles();
     
     updateCameraDir();
   }

   return;
   }
   super.animate();
 }
 
 void truncateAngles(){
     if(elevationAngle >= HALF_PI) elevationAngle = HALF_PI-radians(1);
     if(elevationAngle <= -HALF_PI) elevationAngle = -HALF_PI+radians(1);
     if(rotationAngle >= PI) rotationAngle -= TWO_PI;
     if(rotationAngle <= -PI) rotationAngle += TWO_PI;
 }
 
 void updateCameraDir(){
     if(mPlanet != null && collision(mPlanet)){
       mPosition.y -= mSize.y*uniScale;
     }
     cameraDir.x = cameraSpeed*sin(rotationAngle);
     cameraDir.y = cameraSpeed*sin(elevationAngle);
     cameraDir.z = cameraSpeed*cos(rotationAngle);
 }
 
 void setBackground(){
     //TODO: Vérifier la trigonométrie
     float factor = tan(-elevationAngle) * height;
       
     mBackground.beginDraw();
     mBackground.image(mSkyBox, 0,0, width, height);
     mBackground.image(mSkyBoxWater, 0, factor + height/2 + 160);
     if(height/2+factor < 0)
       mBackground.image(mSkyBoxWater, 0, 0, width, height);
     mBackground.image(mSun, tan(rotationAngle/2) * width, factor * .5);
     
     mBackground.fill(color(#FFFFFF, 80));
     mBackground.noStroke();
     mBackground.translate(cos(rotationAngle) * width*.5,cos(elevationAngle) * height*.5);
     mBackground.rotate(rotationAngle/2);
     mBackground.circle(0, 0, 45);
     mBackground.circle(cos(2*rotationAngle)*160,cos(4*elevationAngle)*80, 25);
     mBackground.endDraw();
   
   if(mBackground.height == height && mBackground.width == width)
     background(mBackground);
   else
     background(#FFFFFF);
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
     pointLight(200, 231, 255, 0, -50, 0);
     ambientLight(202, 231, 255);
  }
 }
}
