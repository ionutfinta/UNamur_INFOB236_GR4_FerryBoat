import java.util.Iterator; 

class CollisionHandler{
  
  U3DObjects checked;
  U3DObjects unchecked;
  U3DObjects all;
  
  CollisionHandler(U3DObjects objs){
    checked = new U3DObjects();
    all = new U3DObjects(objs);
    unchecked = new U3DObjects(all);
  }
  
  
  void handle_entity_collision(){
    checked = new U3DObjects();
    unchecked = new U3DObjects(all);
    PVector oPos,
            oSize,
            mPos,
            oInert,
            mInert,
            mSize;
            
    Iterator<U3DObject> iter1 = all.iterator();
    Iterator<U3DObject> iter2;
    U3DObject o1;
    U3DObject o2;
    
    while(iter1.hasNext()){
      o1 = iter1.next();
      if(!o1.doCollisions()){
        checked.add(o1);
        unchecked.remove(o1);
      }
      
      else{
         iter2 = all.iterator();
         
        while(iter2.hasNext()){
          o2 = iter2.next();
          /*if(!o2.doCollisions()){
            checked.add(o2);
          }*/
          if(o1==o2);
          else{
             oPos = o2.getPosition();
             oSize = o2.getSize();
             oInert = o2.getInertia();
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
      unchecked.removeAll(checked);
    }
      
    }
  }
}
