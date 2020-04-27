import processing.opengl.*;

class Wheel {
  Vehicle attachedOwner;
  float sc; //scale
  float r_pos_x;
  float r_pos_y;
  float r_pos_z;
  int r_angle_y;
  int rotation_speed;
  
  private int angle;
  private PShape s;

  Wheel(Vehicle veh, float scl, float rpx, float rpy, float rpz, int ray) { 
    s = loadShape("./assets/car_wheel.obj");
    attachedOwner = veh;
    sc = scl;
    r_pos_x = rpx;
    r_pos_y = rpy;
    r_pos_z = rpz;
    r_angle_y = ray;
    rotation_speed = 0;
    angle = 0;
  }

  void display() {
    pushMatrix();
    
    translate(width/2, height/2);
    rotateZ(radians(angle));
    rotateY(radians(r_angle_y));
    //scale(50);
    shape(s, 0, 0);
    
    popMatrix();
  }
  
  // Function.  
  void move() {
    angle += rotation_speed;
    angle = angle%180;
  }
}
