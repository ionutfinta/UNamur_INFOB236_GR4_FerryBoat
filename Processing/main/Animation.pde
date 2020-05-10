/** Animations Manager
    An animation is defined by 2 vectors: A start position and a end position and a duration.
    It can affect Position or Angles
    It can be reversed.
    This type is immutable
    */
    
class Animation{
  
  private PVector mVStart, mVEnd;
  
  private boolean mBoolAngles, mReversed;
  
  private int mEnd, mDuration;
  
  // --- Constructors
  // Create a new animation (position) duration in milliseconds
  Animation(PVector act, PVector obj, int duration){
    mBoolAngles = false;
    mVStart = obj;
    mVEnd = act;
    mEnd = millis() + duration;
    mDuration = duration;
    mReversed = false;
  }
  
  // Create a new animation (angles if last parameter is true)
  Animation(PVector act, PVector obj, int duration, boolean affectsAngles){
    this(act, obj, duration);
    mBoolAngles = affectsAngles;
  }
  
  // Create a new animation (angles if last parameter is true)
  Animation(PVector act, PVector obj, int duration, boolean affectsAngles, boolean rev){
    this(act, obj, duration, affectsAngles);
    mReversed = rev;
  }
  
  // --- Observers
  public boolean affectsAngles(){
     return mBoolAngles;
  }
  
  public boolean isElapsed(){
    return mEnd < millis();
  }
  
  public PVector getNewValue(){
    if(isElapsed()){
      if(mReversed)
        return mVEnd;
        
      return mVStart;
    }
    
    int t = millis();
    
    return new PVector(
      getYLine(new PVector(0, mVStart.x), new PVector(mDuration, mVEnd.x), mEnd - t),
      getYLine(new PVector(0, mVStart.y), new PVector(mDuration, mVEnd.y), mEnd - t),
      getYLine(new PVector(0, mVStart.z), new PVector(mDuration, mVEnd.z), mEnd - t)
    );
  }
}
