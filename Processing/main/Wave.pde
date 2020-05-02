/**
* floating objects on water
*
* @author aa_debdeb
* @date 2016/07/17
* @url https://www.openprocessing.org/sketch/376797
*/

class Wave{
  PVector stepSize;
  PVector rectSize;
  float maxZ;
  PVector noiseOffset;
  float noiseScale;
  float timeScale;

  Wave(int ampli){
    stepSize = new PVector(20, 30);
    rectSize = new PVector(20, 30);
    maxZ = ampli;
    noiseScale = 0.001;
    timeScale = 0.003;

    noStroke();
    rectMode(CENTER);
    noiseOffset = new PVector(random(10000), random(10000), random(10000));
  }
  
  void renderWave(){
    
    rotateX(HALF_PI);
    fill(#005FDF);
    float t = frameCount * timeScale;
    for(float w = 2 * stepSize.x; w <= width - 2 * stepSize.x; w += stepSize.x){
      for(float h = 2 * stepSize.y; h <= height - 2 * stepSize.y; h += stepSize.y){
        pushMatrix();
        float z = map(noise(w * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxZ, maxZ); 
        translate(w, h, z);
        float pxz = map(noise((w - stepSize.x) * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxZ, maxZ); 
        float nxz = map(noise((w + stepSize.x) * noiseScale + noiseOffset.x + t, h * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxZ, maxZ);       
        float radianY = (atan2(pxz - z, stepSize.x) + atan2(z - nxz, stepSize.x)) / 2.0; 
        rotateY(radianY);
        float pyz = map(noise(w * noiseScale + noiseOffset.x + t, (h - stepSize.y) * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxZ, maxZ); 
        float nyz = map(noise(w * noiseScale + noiseOffset.x + t, (h + stepSize.y) * noiseScale + noiseOffset.y + t, t + noiseOffset.z), 0, 1, -maxZ, maxZ);       
        float radianX = (atan2(z - pyz, stepSize.y) + atan2(nyz - z, stepSize.y)) / 2.0; 
        rotateX(radianX);
        fill(color(0,map(radianX, -QUARTER_PI/6, QUARTER_PI/6, 30, 100),map(radianX, -QUARTER_PI/6, QUARTER_PI/6, 186, 215), 131));
        rect(0, 0, rectSize.x, rectSize.y);
        
        fill(#005FDF);
        popMatrix();
      } 
    } 
  }
}
