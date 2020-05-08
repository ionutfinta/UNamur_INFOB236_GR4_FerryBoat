class UI{
  //Parameters
  boolean return3D;
  
  //setup
  UI()
  {
    smooth(8);
    return3D = false;
    background(255);
    fill(255);
    stroke(0);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
  }
  
  //Fonctions
  void draw()
  {
    background(255);
    
    readyBoat(1, 0.5);
    return3D = leaveUI(9,  9.5);
    leaveBoat(3, 0.5);
    addCar(2, 5);
    addTruck1(4, 5);
    addTruck2(6, 5);
    addTruck3(8, 5);
  }
  
  void mousePressed()
  {
    // Par exemple:
    return3D = true;
  }
  
  void mouseReleased()
  {
    return3D = false;
  }
  boolean canIReturn3D(){
    return return3D;
  }
 //etc...  
}
