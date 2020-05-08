import java.util.Iterator; 


/*The collision handler will check collisions for every U3DObject that is doCollisions()
it will check for collisions against the closest(5) U3DObjects*/
class CollisionHandler{
  

  U3DObjects all;
  
  CollisionHandler(U3DObjects objs){
    all = new U3DObjects(objs);
  }
  
  
  void handle_entity_collision(){
    PVector oPos,
            oSize,
            mPos,
            mInert,
            mSize;
            
    Iterator<U3DObject> iter1 = all.iterator();
    Iterator<U3DObject> iter2;
    U3DObject o1;
    U3DObject o2;
    
    while(iter1.hasNext()){
      
      o1 = iter1.next();
      if(!o1.doCollisions());
      
      else{
        
        try{
         iter2 = all.n_closest(5, o1);
        }catch(IllegalArgumentException i){
          System.err.println(i);
          print(i);
          iter2 = all.iterator();
        }catch(NullPointerException n){
          System.err.println(n);
          print(n);
          iter2 = all.iterator();
        }
         
        while(iter2.hasNext()){
          o2 = iter2.next();
          
          if(o1==o2);
          else{
             oPos = o2.getPosition();
             oSize = o2.getSize();
             mPos = o1.getPosition();
             mInert = o1.getInertia();
             mSize = o1.getSize();
             
             
            if( (inBetween(oPos.x, mPos.x+mSize.x+mInert.x, oPos.x+oSize.x) ||inBetween(oPos.x, mPos.x+mInert.x, oPos.x+oSize.x))&& 
            (inBetween(oPos.y, mPos.y+mSize.y+mInert.y, oPos.y+oSize.y) || inBetween(oPos.y, mPos.y+mInert.y, oPos.y+oSize.y))  && 
            (inBetween(oPos.z, mPos.z+mSize.z+mInert.z, oPos.z+oSize.z) || inBetween(oPos.z, mPos.z+mInert.z, oPos.z+oSize.z))){
              print(o1, "colliding with ", o2, '\n');
              
                  o1.handle_collision(o2);
                  o2.handle_collision(o1);
                  /*
                  checked.add(o1);
                  checked.add(o2);
                  */
          }
        }
      }
      
    }
      
    }
  }
}
