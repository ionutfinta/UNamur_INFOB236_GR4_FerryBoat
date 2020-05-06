class SelectionArrow extends U3DObject {
  
  final float V_OFFSET = 2;
  private U3DObject selected_o = null;
  PVector selected_pos;
  PVector selected_angle;
  SelectionArrow(){
    mShape = loadShape("./assets/arrow.obj");
  }
  
  void updateSelected(U3DObject selected){
    selected_pos = selected.getPosition();
    mPosition.z = selected_pos.z;
    mPosition.x = selected_pos.x;
    mPosition.y = selected_pos.y + selected.mShape.getHeight() + V_OFFSET;
    
    
    mInertia = selected.mInertia;
    selected_angle = selected.mAngles;
    mAngles = selected_angle;
  }
  
  @Override
  void display(){
    if(selected_o!=null && selected_o.isSelected()){
      super.display();
    }
  }
  
  
}
