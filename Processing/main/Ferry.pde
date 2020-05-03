class Ferry extends U3DObject{

/* Notre système permettant de moduler son ferry, il faudrait créer un système de ferry modulaire */
PShape proue, coque, parroiBabord, parroiTribord, plancher1, plancher2, facadeArriere;

//TODO: tout
//NOTE: idée: Le bateau devrait pouvoir intéragir avec les vagues pour bouger et on ferait ainsi marcher nos sensors !

Ferry(){
    mPosition = new PVector(14,uniScale*.4,175);
    mSize = new PVector(4,4,4);
    proue = loadShape("./assets/proue.obj");
}
  
void display(){
    pushMatrix();
      scale(uniScale);
      translate(mPosition.x, mPosition.y, mPosition.z);
      rotateY(PI);
      shape(proue);
    popMatrix();
  }
  
}
