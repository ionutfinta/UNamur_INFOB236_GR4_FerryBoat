/**
* floating objects on water
*
* @author aa_debdeb
* @date 2016/07/17
* @url https://www.openprocessing.org/sketch/376797
*/

class Wave{
  PVector stepSize, noiseOffset;
  float maxY, noiseScale, timeScale;
  int mWidth, mHeight;

  Wave(){
    stepSize = new PVector(70, 30);
    maxY = 40;
    noiseScale = 0.03;
    timeScale = 0.003;
    mWidth = 700;
    mHeight = 700;
    
    noiseOffset = new PVector(random(10000), random(10000), random(10000));
  }
  
  void renderWave(){
    fill(#004D7B, 170);
    float t = frameCount * timeScale;
    int i = 0;
    
    beginShape(POLYGON);
    for(float w = 2 * stepSize.x; w <= mWidth - 2 * stepSize.x; w += stepSize.x, i++){
      
        for(float h = 2 * stepSize.y; h <= mHeight - 2 * stepSize.y; h += stepSize.y){
            float z = map(noise(w * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxY, maxY); 
            //if(w != 2 * stepSize.x && w != mWidth - 2 * stepSize.x && h != 2 * stepSize.y && h != mHeight - 2 * stepSize.y)
            /*if(i%3==0)
              curveVertex(w,i%2==0?h:mHeight-h, z);
            else*/
              vertex(w,i%2==0?h:mHeight-h, z);
        }
        
    }
    
    endShape();
    
    fill(#004D7B);
    translate(0,0,40);
    rect(400,400,2100,2100);
  }
}
