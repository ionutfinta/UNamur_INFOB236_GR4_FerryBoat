class Earth extends U3DObject{
  private PShape sol;
  private int gravity;
  
  Earth(){
    sol = loadShape("./assets/berge.obj");
    gravity = 10;
  }
  
  void animate(int gravity){
    pushMatrix();
    translate(0, limitBelow*uniScale);
    scale(uniScale);
    shape(sol, 0, 0);
    popMatrix();
  }
  
  int getGravity(){
    return gravity;
  }
}
