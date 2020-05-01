class Car extends Vehicle {
  private PShape s;
  
  private float angle_x;
  private float angle_y;
  private float angle_z;
  
  private boolean switcherLights;
  
  
  Car(){
    s = loadShape("./assets/car_chassis.obj");
    pos_x = 0;
    pos_y = -5;
    pos_z = 0;
    
    angle_x = 0;
    angle_y = 0;
    angle_z = 0;
    
    switcherLights = false;
    
    float frontPos = 0.86,
           wh_height = -0.44,
           backPos = 1.27;
    
    wheels.add(new Wheel(this, frontPos, wh_height, backPos, 180, true));
    wheels.add(new Wheel(this, frontPos, wh_height,-backPos, 180, false));
    wheels.add(new Wheel(this, -frontPos,wh_height, backPos, 000, true));
    wheels.add(new Wheel(this, -frontPos,wh_height,-backPos, 000, false));
    whiteLights.add(new PVector(frontPos, wh_height, 3.52));
    whiteLights.add(new PVector(-frontPos, wh_height, 3.52));
  }
  
  void display() {
    pushMatrix();
    scale(uniScale);
    translate(pos_x, pos_y);
    rotateY(radians(angle_y));
    if(switcherLights){
      //for(PVector l:whiteLights){
        //pointLight(255, 255, 255, l.x, l.y, l.z);
      //}
    }
    if(keyPressed == true && key == 'l' && switcherLights == false)
      switcherLights = !switcherLights;
    if(keyPressed == true && key == 'n' && switcherLights == true)
      switcherLights = !switcherLights;
    
    shape(s, 0, 0);
    for(Wheel w: wheels){
       if(keyPressed == true && key == 'q'){
         w.setDir(45);
       } else if(keyPressed == true && key == 'd'){
         w.setDir(-45);
       } else {
         w.setDir(0);
       }
      w.move();
      w.display();
    }
    
    popMatrix();
  }
}
