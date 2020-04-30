class Earth extends U3DObject{
  
  Earth(){
  }
  
  void animate(){
    
    // Ground
    //rectMode(CENTER);
    fill(0);
    stroke(255);
    pushMatrix();
    translate(0, 2500, 0);
    rotateX(PI/2);
    rect(0, 0, 20000, 20000);
    popMatrix();
  }
}
