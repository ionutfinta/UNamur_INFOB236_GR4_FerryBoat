class Me extends U3DObject{
  PVector cameraDir;
  
  private PVector mSize; // I'm not a shape
  private float cameraSpeed;
  float rotationAngle;
  float elevationAngle;
  
  
  PImage mClouds0;
  PImage mSun;
  
 Me(Universe uni, String ap){
   super(uni);
   setMovable(uni);
   
   if(ap.equals("Laniakea>Virgo Supercluster>Local Sheet>Local Group>Milky Way subgroup>Milky Way Galaxy>Orbit of the Solar System>Orion Arm>Gould Belt>Local Bubble>Local Interstellar Cloud>Solar System>Oort cloud>Scattered disc>Heliosphere>Kuiper belt>Outer Solar System>Inner Solar System>Earth's orbit>Geospace>Orbit of the Moon>Earth>Europe>Belgium>Anvers>Port d'Anvers>ferryBoatProject"))
     println("Welcome to FerryBoat Simulator !");
   
   mPosition = new PVector(-17.180944, 3.7, 102.502914 );
   cameraDir = new PVector(0,0,0);
   elevationAngle = 0;
   rotationAngle = 0;
   cameraSpeed = 1;
   
   mSize = new PVector(1, 1.75, 1);
   
   mClouds0 = loadImage("clouds0.gif");
   mSun = loadImage("sun.png");
 }
 
 void applyInertia(){
   if(!DEBUG){
     mInertia.y =0;
   }
   
   super.applyInertia();
 }
 
 void animate(){
   if(keyPressed){
     if(key == CODED){
       if(keyCode == UP){
         mInertia = cameraDir;
         applyInertia();
         updateCameraDir();
       }
       if(keyCode == DOWN){
         mInertia = cameraDir.mult(-1);
         applyInertia();
         
         updateCameraDir();
       }
       if(keyCode == LEFT){
         PVector goLeft = new PVector(-cameraDir.x, -cameraDir.z).rotate(-HALF_PI);
         mInertia.x = goLeft.x;
         mInertia.y = 0;
         mInertia.z = goLeft.y;
         
         applyInertia();
         updateCameraDir();
       }
       if(keyCode == RIGHT){
         PVector goLeft = new PVector(-cameraDir.x, -cameraDir.z).rotate(HALF_PI);
         mInertia.x = goLeft.x;
         mInertia.y = 0;
         mInertia.z = goLeft.y;
         
         applyInertia();
         updateCameraDir();
       }
     }
     if(pressedKeys.contains('4')){
         rotationAngle -= radians(cameraSpeed);
         updateCameraDir();
     }
     if(pressedKeys.contains('6')){
         rotationAngle += radians(cameraSpeed);
         updateCameraDir();
     }
     if(pressedKeys.contains('8')){
         elevationAngle += radians(cameraSpeed);
         updateCameraDir();
     }
     if(pressedKeys.contains('2')){
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
   
   if(!DEBUG)
     super.animate();
 }
 
 void truncateAngles(){
     if(elevationAngle >= HALF_PI) elevationAngle = HALF_PI-radians(1);
     if(elevationAngle <= -HALF_PI) elevationAngle = -HALF_PI+radians(1);
     if(rotationAngle >= PI) rotationAngle -= TWO_PI;
     if(rotationAngle <= -PI) rotationAngle += TWO_PI;
 }
 
 void updateCameraDir(){
   cameraDir.x = cameraSpeed*sin(rotationAngle);
   cameraDir.y = cameraSpeed*sin(elevationAngle);
   cameraDir.z = cameraSpeed*cos(rotationAngle);
 }

  void setBackground(){
    if(return3D){
     int factorx = (int) (tan(-rotationAngle/2) * width),
       factory = (int) (sin(elevationAngle) * height * 0.5);
       
     ui.beginDraw();
     ui.background(#8EC6FE);
     
     ui.image(mClouds0, factorx, factory - 200);
     ui.image(mClouds0, (int) (tan(-rotationAngle/2 + QUARTER_PI) * width), factory - 250);
     ui.image(mClouds0, (int) (tan(-rotationAngle/2 + 3*QUARTER_PI) * width), factory - 150);
     ui.image(mClouds0, (int) (tan(-rotationAngle/2 + HALF_PI) * width), factory - 225);
       
     if(rotationAngle > -1.576932 && rotationAngle < 0.34054446){
       ui.image(mSun, factorx, factory);
     }
     
     PVector forLenses = new PVector(cos(-rotationAngle) ,cos(-elevationAngle) );
     ui.fill(color(#FFFFFF, 80));
     ui.noStroke();
     ui.translate(forLenses.x* width*.5, forLenses.y* height*.5);
     ui.rotate(rotationAngle/2);
     ui.circle(0, 0, 45);
     ui.circle(exp(abs(forLenses.x)+5)-350, exp(forLenses.y+5)-350, 25);
     ui.endDraw();
   
   if(ui.height == height && ui.width == width)
     background(ui);
   else
     background(#FFFFFF);
    }else{
     ui.beginDraw();
     new UI().draw();
     ui.endDraw();
     background(ui);
    }
 }
 
 void display(){
   if(keyPressed && key == CODED && keyCode == SHIFT && DEBUG){
     println("Camera position: " + mPosition);
     println("Camera Direction: " + cameraDir);
     println("Elevation: " + elevationAngle);
     println("Rotation: " + rotationAngle);
   }
   
   perspective(PI/3, float(width)/float(height), 
          ((height/2.0) / tan(PI/6))/2200, ((height/2.0) / tan(THIRD_PI))*2);
   camera(mPosition.x, mPosition.y, mPosition.z, mPosition.x+cameraDir.x, mPosition.y+cameraDir.y, mPosition.z+cameraDir.z, 0, -1, 0);
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
 
 @Override
 boolean doCollisions(){
   return inBetween(-2,mPosition.x,2) && inBetween(-10,mPosition.z, -5) && inBetween(2, mPosition.y, 4);
 }
 
 @Override
 boolean isMovable(){ return false; }
}
