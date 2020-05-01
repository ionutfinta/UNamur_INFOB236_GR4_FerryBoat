class U3DObject {
  protected int uniScale;
  protected float limitBelow;
  
  protected float pos_x;
  protected float pos_y;
  protected float pos_z;
  protected float y_speed;
  
  U3DObject(){
    uniScale = 12;
    limitBelow = uniScale*0.250;
  }
  void apply_gravity(int gravity){
    if(pos_y < limitBelow){
      y_speed += gravity*0.005;
      pos_y += y_speed;
    }else{
      pos_y = limitBelow;
      y_speed = 0;
    }
  }
  
  void animate(int gravity){
    apply_gravity(gravity);
  }
  void display(){
  }
}
