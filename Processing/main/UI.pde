class UI{
  //Parameters
  boolean return3D;
  
  //setup
  UI()
  {
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
    
    readyBoat(1.2, 0.7);
    return3D = leaveUI(8.5,  9);
    leaveBoat(1.2, 1.8);
    addCar(3.95, 4.4);
    addTruck1(6.05, 4.4);
    addTruck2(3.95, 5.6);
    addTruck3(6.05, 5.6);
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
