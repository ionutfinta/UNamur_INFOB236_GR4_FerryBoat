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
