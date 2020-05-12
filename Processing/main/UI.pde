class UI{
  //setup
  UI()
  {
    ui.background(255);
    ui.fill(255);
    ui.stroke(0);
    ui.rectMode(CENTER);
    ui.textAlign(CENTER, CENTER);
  }
  
  void draw()
  {
    ui.background(255);
    
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
    noReservation(1.2, 9.3);
    
    //ID
    textSize(50);
    message("Next Vehicle ID will be : " + ID, 5, 2, 0);
    if(reservation)
    {
      message("Current selected level for reservations is : " + lvl, 5 , 8, 0);
    }
    else
    {
      message("The vehicule will not have a reservation", 5 , 8, 0);
    }
    
    message(topLeft, 1.5, 4.4, TLfade);
    message(bottomLeft, 1.5, 5.6, BLfade);
    message(topRight, 8.5, 4.4, TRfade);
    message(bottomRight, 8.5, 5.6, BRfade);
    
    //fade effects for the messages
    TLfade += 2;
    BLfade += 2;
    TRfade += 2;
    BRfade += 2;
    
    exitApp(8.8, 0.7); //exit button
  }
}
