class AuraBureau extends U3DObject{
  AuraBureau(Universe uni, PVector pos, String shape) {
    super(uni, pos, shape);
    mCollide = true;
  }
  
  @Override
  void handle_collision(U3DObject o){ 
    if(o instanceof Me){
      o.setPos(new PVector(0,0,5).add(o.getPosition()));
      ((Me)o).cameraDir = new PVector(0,0,0);
      return3D = false;
    }
  }
  
}
