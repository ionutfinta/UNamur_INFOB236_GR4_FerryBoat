import processing.opengl.*;

class Wheel {
  Vehicle attachedOwner;
  private float r_pos_x;
  private float r_pos_y;
  private float r_pos_z;
  private int r_angle_y;
  private float rotation_speed;
  private boolean directional;
  private float dir_angle;
  
  private int angle;
  private PShape s;

  Wheel(Vehicle veh, float rpx, float rpy, float rpz, int ray, boolean dir) { 
    s = loadShape("./assets/car_wheel.obj");
    attachedOwner = veh;
    r_pos_x = rpx;
    r_pos_y = rpy;
    r_pos_z = rpz;
    r_angle_y = ray;
    directional = dir;
    rotation_speed = random(1,3);
    angle = 0;
    dir_angle = 0;
  }

  void display() {
    pushMatrix();
      translate(r_pos_x, r_pos_y, r_pos_z);
      rotateY(radians(r_angle_y + dir_angle));
      pushMatrix();
        rotateX(radians(angle));
        shape(s, 0, 0);
      popMatrix();
    popMatrix();
  }
  
  // Function.  
  void move() {
    angle -= rotation_speed;
    angle = angle%360;
  }
  
  void setDir(int nDir){
    if(directional)
      dir_angle = nDir; 
  }
}
