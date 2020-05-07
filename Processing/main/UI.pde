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
    
    rect(0,0,200,200);
    
    // Par exemple, à la 150ème frame, on repasse en 3D... Tu modifieras ça pour que ça soit enclanché par un bouton...
    if(frameCount == 150)
      return3D = true;
  }
  
  void mousePressed(){
  }
  
  void mouseReleased(){
  }
  
  boolean canIReturn3D(){
    return return3D;
  }
 //etc...  
}
