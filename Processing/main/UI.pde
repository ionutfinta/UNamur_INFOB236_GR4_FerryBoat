class UI{
  //setup
  UI()
  {
    background(255);
    fill(255);
    stroke(0);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
  }
  
  void draw()
  {
    background(255);
    
    //buttons
    readyBoat(1.2, 0.7);
    return3D = leaveUI(8.8,  9.3);
    leaveBoat(1.2, 1.8);
    addCar(3.95, 4.4);
    addTruck1(6.05, 4.4);
    addTruck2(3.95, 5.6);
    addTruck3(6.05, 5.6);
    selectLvl1(2.8, 6.8);
    selectLvl2(5, 6.8);
    selectLvl3(7.2, 6.8);
    exitApp(8.8, 0.7);
    
    //ID
    textSize(height/35);
    message("Next Vehicle ID will be : " + ID, 5, 2);
    message("Current selected level for reservations is : " + lvl, 5 , 8);
  }
}
