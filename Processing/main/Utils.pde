public static boolean inArray(ArrayList<U3DObject> array, U3DObject o){
  for(U3DObject o1 : array){
    if(o1==o)
      return true;
  }
  return false;
}

public static boolean inBetween(float L, float x, float U){
  return(x>=L && x<=U);
}
