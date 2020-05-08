/*U3DObjects behave like ArrayLists of type U3Object
with an added iterator that returns the n closest U3Object to another in
the U3Objects being iterated*/

class U3DObjects implements Iterable<U3DObject>{
  
  ArrayList<U3DObject> objects;
  
  U3DObjects(){
    objects = new ArrayList<U3DObject>();
  }
  U3DObjects(U3DObjects cp_arr){
    objects = new ArrayList<U3DObject>(cp_arr.objects);
  }
  
  
  void add(U3DObject o){
    objects.add(o);
  }
  int size(){
    return objects.size();
  }
  void remove(U3DObject o){
    objects.remove(o);
  }
  void removeAll(U3DObjects o){
    objects.removeAll(o.objects);
  }
  U3DObject get(int i){
    return objects.get(i);
  }
  
  
  
  
  Iterator<U3DObject> n_closest(int n, U3DObject o){
    return new n_closest_generator(n,o);
  }
  
  Iterator<U3DObject> iterator(){
    return objects.iterator();
  }
  
  private class n_closest_generator implements Iterator<U3DObject>{
    
    U3DObject comparee;
    int N;
    int current;
    float lastDistance;
    
    //If N ends up often being big, consider merge sort once by distance or using a SortedSet
    
    n_closest_generator(int n, U3DObject o) throws IllegalArgumentException, NullPointerException{
      if(n>objects.size()){
        throw new IllegalArgumentException("U3DObjects n_closest_generator, U3DObjects does not contain n elements");
      }
      if(o==null){
        throw new NullPointerException("U3DObjects n_closes_generator, U3DObject is null");
      }
    
      N = n;
      current = 0;
      lastDistance = 0;
      comparee = o;
    }
    
    boolean hasNext(){
      if(current==N){
        return false;
      }
      return true;
    }
    
    U3DObject next(){
      float min_encountered = Float.MAX_VALUE;
      float dist;
      U3DObject min_object = null;
      
      for(U3DObject o: objects){
          dist = comparee.getPosition().dist(o.getPosition());
          
          if(dist<min_encountered && o!=comparee && dist>=lastDistance){
             min_encountered = dist;
             min_object = o;
          }
        
        }
        
        lastDistance = min_encountered;
        current++;
        return min_object;
      }
    }
    
  } 
  
  
