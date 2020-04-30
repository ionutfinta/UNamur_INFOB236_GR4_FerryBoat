class Car extends Vehicle {
  private PShape s;
  
  private float pos_x;
  private float pos_y;
  private float pos_z;
  
  private float angle_x;
  private float angle_y;
  private float angle_z;
  
  Car(){
    s = loadShape("./assets/car_chassis.obj");
    pos_x = 0;
    pos_y = 0;
    pos_z = 0;
    
    angle_x = 0;
    angle_y = 0;
    angle_z = 0;
    
    wheels.add(new Wheel(this, 86,-44, 130, 0, true));
    wheels.add(new Wheel(this, 86,-44, -127, 0, false));
    wheels.add(new Wheel(this, -87, -44,130, 180, true));
    wheels.add(new Wheel(this, -87,-44,-127, 180, false));
  }
  
  void display() {
    pushMatrix();
    
    translate(pos_x, pos_y);
    rotateY(radians(angle_y));
    
    shape(s, 0, 0);
    for(Wheel w: wheels){
       if(keyPressed == true && key == 'q'){
         w.setDir(45);
       }
       if(keyPressed == true && key == 'd'){
         w.setDir(-45);
       }
      w.move();
      w.display();
    }
    
    popMatrix();
  }
}
