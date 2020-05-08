/**
* Ocean Waves Class
* Inspired from: https://github.com/BenTommyE/3D_wave_sim
*/
class Wave{
  private PVector noiseOffset;
  
  private int lastUpdate, mPCountx, mPCounty, mUpdateTime;
  private float zoom, mMaxHeight, waveOrNot, noiseScale, timeScale;
  private float[][] particle,
            particlesSpeedNew,
            particlesNew;

  Wave(){
    noiseScale = 0.007;
    timeScale = 0.003;
    
    //funberOfPArticles = 30;
    
    mPCountx = 30;
    mPCounty = 30;
    waveOrNot = -2;
    zoom = 1000 / mPCountx;
    
    mMaxHeight = 12;
    
    noiseOffset = new PVector(random(1000), random(1000), random(1000));
    
    particle = new float[30][30];
    particlesNew = new float[30][30];
    particlesSpeedNew = new float[30][30];
    lastUpdate = 0;
    mUpdateTime = 250;
  }
  
  Wave(int w, int h, float a, int s, int ut){
    noiseScale = 0.007;
    timeScale = 0.003;
    mUpdateTime = ut;
    
    mPCountx = w;
    mPCounty = h;
    waveOrNot = -2;
    zoom = s / mPCountx;
    
    mMaxHeight = a;
    
    noiseOffset = new PVector(random(1000), random(1000), random(1000));
    
    particle = new float[mPCountx][mPCounty];
    particlesNew = new float[mPCountx][mPCounty];
    particlesSpeedNew = new float[mPCountx][mPCounty];
    lastUpdate = 0;
  }
  
  void renderWave(){
    noStroke();
    for (int x = 0; x<mPCountx-1; x++) {
      for (int y = 0; y<mPCounty-1; y++) {
        beginShape();
          fill(0, getGreen(particle[x][y]), getBlue(particle[x][y]), 160);
          vertex( (x)*zoom, (y)*zoom, miniMax(particle[x][y]) );
          
          fill(0, getGreen(particle[x+1][y]), getBlue(particle[x+1][y]), 145);
          vertex( (x+1)*zoom, (y)*zoom, miniMax(particle[x+1][y]) );
          
          fill(0, getGreen(particle[x+1][y+1]), getBlue(particle[x+1][y+1]), 145);
          vertex( (x+1)*zoom, (y+1)*zoom, miniMax(particle[x+1][y+1]) );
          
          fill(0, getGreen(particle[x][y+1]), getBlue(particle[x][y+1]), 145);
          vertex( (x)*zoom, (y+1)*zoom, miniMax(particle[x][y+1]) );
        endShape();
      }
    }
  }
  
  int getGreen(float i){
    return (int) map(i, -10,10, 0, 91);
  }
  
  int getBlue(float i){
    return (int) map(i, -10,10, 0, 190);
  }
  
  float miniMax(float i){
    return min(mMaxHeight, max(-mMaxHeight, i));
  }
  
  int miniMax(int l, int u, int x){
    return min(u, max(l, x));
  }
  
  void updateNoise(){
    if(lastUpdate - millis() > mUpdateTime) return;
    lastUpdate = millis();
    for (int x = 1; x<mPCountx-2; x++) {
      for (int y = 1; y<mPCounty-2; y++) {
        //under 
        float force1 = 0.0;
        force1 += particle[x-1][y-1] - particle[x][y];
        force1 += particle[x-1][y] - particle[x][y];
        force1 += particle[x-1][y+1] - particle[x][y];
        //over
        force1 += particle[x+1][y-1] - particle[x][y];
        force1 += particle[x+1][y] - particle[x][y];
        force1 += particle[x+1][y+1] - particle[x][y];
        //sidene
        force1 += particle[x][y-1] - particle[x][y];
        force1 += particle[x][y+1] - particle[x][y];
  
        force1 -= particle[x][y+1] / 8;
  
        particlesSpeedNew[x][y] = 0.995 * particlesSpeedNew[x][y] + force1/100;
  
        particlesNew[x][y] = particle[x][y] + particlesSpeedNew[x][y];
      }
    }
  
    for (int x = 1; x<mPCountx-1; x++) {
      for (int y = 1; y<mPCounty-1; y++) {
        particle[x][y] = particlesNew[x][y];
      }
    }
    
    float t = frameCount * timeScale;
    
    if (waveOrNot != 0 && mPCounty > 3 && mPCounty > 3) {
        int NoiseXIndex = miniMax(1,mPCountx-2, (int)((mPCountx-4) * noise(noiseScale + noiseOffset.x + t, noiseScale + noiseOffset.y + t, t + noiseOffset.z)));
        int NoiseYIndex = miniMax(1,mPCounty-2, (int)((mPCounty-4) * noise(noiseScale + noiseOffset.x + t, noiseScale + noiseOffset.y + t, t + noiseOffset.z)));
        particlesSpeedNew[NoiseXIndex][NoiseYIndex] = waveOrNot;
        particlesSpeedNew[NoiseXIndex+1][NoiseYIndex+1] = waveOrNot;
        particlesSpeedNew[NoiseXIndex+1][NoiseYIndex] = waveOrNot;
        particlesSpeedNew[NoiseXIndex+1][NoiseYIndex-1] = waveOrNot;
        particlesSpeedNew[NoiseXIndex][NoiseYIndex-1] = waveOrNot;
        particlesSpeedNew[NoiseXIndex-1][NoiseYIndex+1] = waveOrNot;
        particlesSpeedNew[NoiseXIndex-1][NoiseYIndex] = waveOrNot;
        particlesSpeedNew[NoiseXIndex-1][NoiseYIndex-1] = waveOrNot;
    
        particle[NoiseXIndex][NoiseYIndex] = waveOrNot*10;
        particle[NoiseXIndex+1][NoiseYIndex+1] = waveOrNot*5;
        particle[NoiseXIndex+1][NoiseYIndex] = waveOrNot*10;
        particle[NoiseXIndex+1][NoiseYIndex-1] = waveOrNot*5;
        particle[NoiseXIndex][NoiseYIndex-1] = waveOrNot*10;
        particle[NoiseXIndex-1][NoiseYIndex+1] = waveOrNot*5;
        particle[NoiseXIndex-1][NoiseYIndex] = waveOrNot*10;
        particle[NoiseXIndex-1][NoiseYIndex-1] = waveOrNot*5;
    }
  }
}
