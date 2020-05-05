/**
* floating objects on water
*
* @author aa_debdeb
* @date 2016/07/17
* @url https://www.openprocessing.org/sketch/376797
*/

class Wave{
  PVector stepSize, rectSize,  noiseOffset;
  float maxY, noiseScale, timeScale;
  int mWidth, mHeight;

  Wave(){
    stepSize = new PVector(40, 20);
    rectSize = new PVector(41, 22);
    maxY = 1.3;
    noiseScale = 0.001;
    timeScale = 0.003;
    mWidth = 700;
    mHeight = 700;
    
    
    noStroke();
    rectMode(CENTER);
    noiseOffset = new PVector(random(10000), random(10000), random(10000));
  }
  
  void renderWave(){
    
    rotateX(HALF_PI);
    fill(#005FDF);
    float t = frameCount * timeScale;
    for(float w = 2 * stepSize.x; w <= mWidth - 2 * stepSize.x; w += stepSize.x){
      for(float h = 2 * stepSize.y; h <= mHeight - 2 * stepSize.y; h += stepSize.y){
        pushMatrix();
        float z = map(noise(w * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxY, maxY); 
        translate(w, h, z);
        float pxz = map(noise((w - stepSize.x) * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxY, maxY); 
        float nxz = map(noise((w + stepSize.x) * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxY, maxY);       
        float radianY = (atan2(pxz - z, stepSize.x) + atan2(z - nxz, stepSize.x)) / 2.0; 
        rotateY(radianY);
        float pyz = map(noise(w * noiseScale + noiseOffset.x + t, (h - stepSize.y) * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxY, maxY); 
        float nyz = map(noise(w * noiseScale + noiseOffset.x + t, (h + stepSize.y) * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxY, maxY);       
        float radianX = (atan2(z - pyz, stepSize.y) + atan2(nyz - z, stepSize.y)) / 2.0; 
        rotateX(radianX-.05);
        fill(color(0,map(radianX, -QUARTER_PI/16, QUARTER_PI/16, 30, 100),map(radianX, -QUARTER_PI/16, QUARTER_PI/16, 186, 215), 75));
        rect(0, 0, rectSize.x, rectSize.y);
        
        fill(#005FDF);
        popMatrix();
      } 
    } 
  }
}
