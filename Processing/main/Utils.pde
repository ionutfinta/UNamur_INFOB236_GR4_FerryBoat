public static boolean collisionInArray(ArrayList<U3DObject> l, U3DObject o){
  if(l == null || l.isEmpty()){
    return false;
  }
  for (U3DObject e : l) {
      if (e == o) {
          return true;
      }
  }
  return false;
}

/** In a cartesian graph, returns the Y of a point in the range of a line passing through pointA and pointB at X */
public static float getYLine(PVector pointA, PVector pointB, float x){
  if(pointA.x == pointB.x)
    return pointA.y;
    
  return pointA.y + ((pointB.y-pointA.y)/(pointB.x-pointA.x))*(x-pointA.x);
  
}
