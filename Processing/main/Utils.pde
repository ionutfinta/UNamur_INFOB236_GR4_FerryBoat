public static boolean inArray(U3DObjects array, U3DObject o){
  for(U3DObject o1 : array){
    if(o1==o)
      return true;
  }
  return false;
}

public static boolean inBetween(float L, float x, float U){
  x=shiftPositive(x);
  L=shiftPositive(L);
  U=shiftPositive(U);
  
  return(x>=L && x<=U);
}

public static float shiftPositive(float x){
  return x+1000;
}

/** In a cartesian graph, returns the Y of a point in the range of a line passing through pointA and pointB at X */
public static float getYLine(PVector pointA, PVector pointB, float x){
  if(pointA.x == pointB.x)
    return pointA.y;
    
  return pointA.y + ((pointB.y-pointA.y)/(pointB.x-pointA.x))*(x-pointA.x);
  
}

//get a 2d vector from a 3d one, ijk can be 1 or 0
//@requires i+j+k==2 && i,j,k>=0 && i,j,k<=1
public static PVector planeFrom(PVector v, int i, int j, int k){
  int[] ijk = {i,j,k};
  boolean gotOne = false;
  PVector ret = new PVector(0,0);
  for(int n=0; n<3; n++){
    if(ijk[n]>0){
      if(gotOne){
        switch(n){
          case 0:ret.y=v.x; break;
          case 1:ret.y=v.y; break;
          case 2:ret.y=v.z; break;
        }
      }
        
      else{
        switch(n){
          case 0:ret.x=v.x; break;
          case 1:ret.x=v.y; break;
          case 2:ret.x=v.z; break;
        }
        gotOne = true;
      }
    }   
  }
  return ret;
}
