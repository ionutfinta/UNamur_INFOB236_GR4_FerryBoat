class AuraBureau extends U3DObject{
  AuraBureau(Universe uni, PVector pos, String shape) {
    super(uni, pos, shape);
    mCollide = true;
  }
  
  @Override
  void handle_collision(U3DObject o){ 
    if(o instanceof SelectionDetectorObject){
      return3D = false;
    }
  }
  
}
