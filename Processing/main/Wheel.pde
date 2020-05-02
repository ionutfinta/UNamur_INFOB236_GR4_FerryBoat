import processing.opengl.*;

class Wheel {
  Vehicle attachedOwner;
  private PVector mRelPos;
  
  private float rotation_speed;
  private boolean directional;
  
  private int r_angle_y;
  private float dir_angle;
  
  private int angle;
  private PShape s;

  Wheel(Vehicle veh, float rpx, float rpy, float rpz, int ray, boolean dir) { 
    s = loadShape("./assets/car_wheel.obj");
    attachedOwner = veh;
    mRelPos = new PVector(rpx, rpy, rpz);
    r_angle_y = ray;
    directional = dir;
    rotation_speed = 0;
    angle = 0;
    dir_angle = 0;
  }

  void display() {
    pushMatrix();
      translate(mRelPos.x, mRelPos.y, mRelPos.z);
      rotateY(radians(r_angle_y + dir_angle));
      pushMatrix();
        rotateX(radians(angle));
        shape(s, 0, 0);
      popMatrix();
    popMatrix();
  }
  
  void move() {
    angle += rotation_speed;
    angle = angle%360;
  }
  
  void setDir(int nDir){
    if(directional)
      dir_angle = nDir; 
  }
}
