class UI{
  //setup
  PImage rearBoat = loadImage("rearBoat.jpg"); //schematics of the biggest electric ferry boat
  PImage middleBoat = loadImage("middleBoat.jpg");
  PImage boat = loadImage("boat.jpg");
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
    
    if(editFerry)
    {
      message("Current ferry length : " + ferryLength, 5, 2.5, 0);
      increaseFerry( 8, 2.5);
      decreaseFerry( 2, 2.5);
      
      rearBoat.resize(width/12, height/4);
      ui.image(rearBoat, 2 * width/12, 4 * height/10);
      for(int len = 1; len < ferryLength; len ++)
      {
        middleBoat.resize(width/12, height/4);
        ui.image(middleBoat, (2 + len) * width/12, 4 * height/10);
      }
      boat.resize(width/12, height/4);
      ui.image(boat, (2 +  ferryLength) * width/12, 4 * height/10);
      
      returnUI(8.8, 0.7);    
    }
    else
    {
      //call to the method displaying non interactive visual elements
      UIart();
      
      //ID
      message("Next Vehicle ID will be : " + ID, 5, 2, deepSkyBlue);
      if(reservation)
      {
        message("Current selected level for reservations is : " + lvl, 5 , 8, deepSkyBlue);
      }
      else
      {
        message("The vehicule will not have a reservation", 5 , 8, crimson);
      }
      
      message(topLeft, 1.5, 4.4, TLfade);
      message(bottomLeft, 1.5, 5.6, BLfade);
      message(topRight, 8.5, 4.4, TRfade);
      message(bottomRight, 8.5, 5.6, BRfade);
      
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
      editFerry(8.8, 1.8);
      exitApp(8.8, 0.7); //exit button
      
      //fade effects for the messages
      TLfade += 2;
      BLfade += 2;
      TRfade += 2;
      BRfade += 2;
    }
  }
}
