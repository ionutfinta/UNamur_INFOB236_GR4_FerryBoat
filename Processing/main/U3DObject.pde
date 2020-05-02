class U3DObject {
  protected int uniScale;
  protected float limitBelow;
  
  protected PVector mPosition;
  protected float y_speed;
  
  U3DObject(){
    uniScale = 18;
    
     //TODO: Améliorer via un système de collisions
    limitBelow = uniScale*0.250;
  }
  
  // --- Must be overwritten
  void apply_gravity(int gravity){
   //TODO: Améliorer via un système de collisions
    if(mPosition.y < limitBelow){
      y_speed += gravity*0.005;
      mPosition.y += y_speed;
    }else{
      mPosition.y = limitBelow;
      y_speed = 0;
    }
  }
  
  void animate(int gravity){
    apply_gravity(gravity);
  }
  void display(){
  }
  
  // --- 3D Moving
  
}
