class UI{
  // Paramètres dont tu aurais besoin
  boolean return3D;
  
  // Ce qui va dans setup, tu le mets ici dans le constructeur
  UI(){
    return3D = false;  
  }
  
  //Fonctions
  void draw(){
    background(#FFFFFF);
    fill(0);
    rect(0,0,200,200);
  }
  
  void mousePressed(){
    // Par exemple:
    return3D = true;
  }
  
  void mouseReleased(){
  }
  
  boolean canIReturn3D(){
    return return3D;
  }
 //etc...  
}
