class Me extends U3DObject{
  private String mode;
  private String absPosition;
  
  private PVector cameraDir;
  
  private PVector mSize; // I'm not a shape
  private float cameraSpeed;
  private float rotationAngle;
  private float elevationAngle;
  
  
  PImage mClouds0;
  PImage mSun;
  
  PGraphics mBackground;
  
 Me(Universe uni, String m, String ap){
   super(uni);
   
   mode = m;
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject"))
     ap = "port";
   absPosition = ap;
   
   mPosition = new PVector(-17.180944, 5.1451683, 102.502914 );
   cameraDir = new PVector(-0.033744603, -0.15778065, 0.9994305);
   elevationAngle = 0;
   rotationAngle = 0;
   cameraSpeed = 1;
   
   mSize = new PVector(1, 2.7, 1);
   
   mClouds0 = loadImage("./assets/clouds0.gif");
   mSun = loadImage("./assets/sun.png");
   mBackground = createGraphics(width, height);
 }
 

 
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
         PVector goLeft = new PVector(-cameraDir.x, -cameraDir.z).rotate(-HALF_PI);
         mInertia.x = goLeft.x;
         mInertia.y = 0;
         mInertia.z = goLeft.y;
         
         super.applyInertia();
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         PVector goLeft = new PVector(-cameraDir.x, -cameraDir.z).rotate(HALF_PI);
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
         rotationAngle -= radians(cameraSpeed);
         updateCameraDir();
     }
     if(key == '6'){
         rotationAngle += radians(cameraSpeed);
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
     elevationAngle -= map(elevationAngle + differenceMouse, elevationAngle - height, elevationAngle + height, -PI, PI);
     
     differenceMouse = pmouseX-mouseX;
     rotationAngle += map(rotationAngle + differenceMouse, rotationAngle - width, rotationAngle + width, -PI, PI);
     
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
       mPosition.y += mSize.y;
     }
     cameraDir.x = cameraSpeed*sin(rotationAngle);
     cameraDir.y = cameraSpeed*sin(elevationAngle);
     cameraDir.z = cameraSpeed*cos(rotationAngle);
 }

  void setBackground(){
     //TODO: Vérifier la trigonométrie
     int factorx = (int) (tan(-rotationAngle/2) * width),
       factory = (int) (sin(elevationAngle) * height * 0.5);
       
     mBackground.beginDraw();
     mBackground.background(#8EC6FE);
     
     mBackground.image(mClouds0, factorx, factory - 200);
     mBackground.image(mClouds0, (int) (tan(-rotationAngle/2 + QUARTER_PI) * width), factory - 250);
     mBackground.image(mClouds0, (int) (tan(-rotationAngle/2 + 3*QUARTER_PI) * width), factory - 150);
     mBackground.image(mClouds0, (int) (tan(-rotationAngle/2 + HALF_PI) * width), factory - 225);
       
     if(rotationAngle > -1.576932 && rotationAngle < 0.34054446){
       mBackground.image(mSun, factorx, factory);
     }
     
     PVector forLenses = new PVector(cos(-rotationAngle) ,cos(-elevationAngle) );
     mBackground.fill(color(#FFFFFF, 80));
     mBackground.noStroke();
     mBackground.translate(forLenses.x* width*.5, forLenses.y* height*.5);
     mBackground.rotate(rotationAngle/2);
     mBackground.circle(0, 0, 45);
     mBackground.circle(exp(abs(forLenses.x)+5)-350, exp(forLenses.y+5)-350, 25);
     mBackground.endDraw();
   
   if(mBackground.height == height && mBackground.width == width)
     background(mBackground);
   else
     background(#FFFFFF);
 }
 
 void display(){
   if(absPosition.equals("port")){
     perspective(PI/3, float(width)/float(height), 
            ((height/2.0) / tan(PI/6))/200, ((height/2.0) / tan(THIRD_PI))*5);
     camera(mPosition.x, mPosition.y, mPosition.z, mPosition.x+cameraDir.x, mPosition.y+cameraDir.y, mPosition.z+cameraDir.z, 0, -1, 0);
  }
 }
 
 public PVector getSize(){
   return mSize;
 }
 
 public PVector getCamDir(){
   return cameraDir;
 }
 public float getCamRotationAngle(){
   return rotationAngle;
 }
 public float getCamElevationAngle(){
   return elevationAngle;
 }
}
