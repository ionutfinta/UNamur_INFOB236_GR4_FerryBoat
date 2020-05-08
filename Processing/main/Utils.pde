public static boolean inArray(U3DObjects array, U3DObject o){
  for(U3DObject o1 : array){
    if(o1==o)
      return true;
  }
  return false;
}

public static boolean inBetween(float L, float x, float U){
  return(x>=L && x<=U);
}
/** In a cartesian graph, returns the Y of a point in the range of a line passing through pointA and pointB at X */
public static float getYLine(PVector pointA, PVector pointB, float x){
  if(pointA.x == pointB.x)
    return pointA.y;
    
  return pointA.y + ((pointB.y-pointA.y)/(pointB.x-pointA.x))*(x-pointA.x);
  
}
