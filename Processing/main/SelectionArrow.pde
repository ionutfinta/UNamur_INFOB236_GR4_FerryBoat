/* A selection arrow is used to designate selectable U3DObject
the arrow will remain above the last selected U3DObject
it will only be displayed if the U3DObject is selected*/

class SelectionArrow extends U3DObject {
  
  final float V_OFFSET = 2;
  private U3DObject selected_o = null;
  PVector selected_pos;
  PVector selected_angle;
  
  SelectionArrow(){
    mPosition = new PVector(1000, 1000, 1020);
    mShape = loadShape("arrow.obj");
  }
  
  void updateSelected(U3DObject selected){
    selected_o = selected;
    
    
    
    
    
   
  }
  
  @Override
  void display(){
    if(selected_o!=null && selected_o.isSelected()){
      super.display();
    }
  }
  @Override
  void animate(){
    if(selected_o==null)
    return;
    
    selected_pos = selected_o.getPosition();
    mPosition.z = selected_pos.z;
    mPosition.x = selected_pos.x;
    mPosition.y = selected_pos.y + selected_o.mShape.getHeight() + V_OFFSET;
    
    
    mAngles = selected_o.mAngles;
  }
  
  
}
