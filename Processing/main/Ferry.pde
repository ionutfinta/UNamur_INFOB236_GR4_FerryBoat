class Ferry extends U3DObject{

/* Notre système permettant de moduler son ferry, il faudrait créer un système de ferry modulaire */
PShape proue, coque, parroiBabord, parroiTribord, plancher1, plancher2, facadeArriere;

//TODO: tout
//NOTE: idée: Le bateau devrait pouvoir intéragir avec les vagues pour bouger et on ferait ainsi marcher nos sensors !

Ferry(){
    mPosition = new PVector(10,4,175);
    mShape = loadShape("./assets/proue.obj");
}
  
}
