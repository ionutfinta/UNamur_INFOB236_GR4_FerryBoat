/** Animations Manager
    An animation is defined by 2 vectors: A start position and a end position and a duration.
    It can affect Position or Angles
    It can be reversed.
    This type is immutable
    */
    
class Animation{
  
  private PVector mVStart, mVEnd;
  
  private boolean mBoolAngles, mReversed;
  
  //private float mStart, mEnd;
  private int mEnd, mDuration;
  
  // Create a new animation (position) duration in milliseconds
  Animation(PVector start, PVector end, int duration){
    mBoolAngles = false;
    mVStart = start;
    mVEnd = end;
    mDuration = duration;
  }
  
  // Create a new animation (angles if last parameter is true)
  Animation(PVector start, PVector end, int duration, boolean affectsAngles){
    mBoolAngles = affectsAngles;
    mVStart = start;
    mVEnd = end;
    mDuration = duration;
    mEnd = millis() + duration;
  }
  
  // Create a new animation (angles if last parameter is true)
  Animation(PVector start, PVector end, int duration, boolean affectsAngles, boolean rev){
    mBoolAngles = affectsAngles;
    if(!rev){
      mVStart = start;
      mVEnd = end;
    }else{
      mVStart = end;
      mVEnd = start;
    }
    mDuration = duration;
    mEnd = millis() + duration;
    mReversed = rev;
  }
  
  // Getters
  public boolean affectsAngles(){
     return mBoolAngles;
  }
  
  public boolean isElapsed(){
    return mEnd < millis();
  }
  
  public PVector getNewValue(){
    if(isElapsed())
      if(mReversed)
        return mVStart;
      else
        return mVEnd;
    
    int t = millis();
    
    return new PVector(
      getYLine(new PVector(0, mVStart.x), new PVector(mDuration, mVEnd.x), mEnd - t),
      getYLine(new PVector(0, mVStart.y), new PVector(mDuration, mVEnd.y), mEnd - t),
      getYLine(new PVector(0, mVStart.z), new PVector(mDuration, mVEnd.z), mEnd - t)
    );
  }
}
