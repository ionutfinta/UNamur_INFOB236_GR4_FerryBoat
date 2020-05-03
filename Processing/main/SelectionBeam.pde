class SelectionBeam extends U3DObject{
  
  SelectionBeam(PVector pos, PVector dir, float len){
    //wrong but not too wrong
    mSize = dir.copy();
    mSize.normalize();
    mSize.mult(len);
    mPosition = pos.copy();
  }
  
  
  
}
