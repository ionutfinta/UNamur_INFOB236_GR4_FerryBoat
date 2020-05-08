/**
* Ocean Waves Class
* Inspired from: https://github.com/BenTommyE/3D_wave_sim
*/
class Wave{
  PVector noiseOffset;
  float maxY, noiseScale, timeScale;
  
  int funberOfPArticles;
  float zoom;
  float[][] particle;
  float[][] particlesSpeedNew;
  float[][] particlesNew;
  float waveOrNot = -2;

  Wave(){
    noiseScale = 0.03;
    timeScale = 0.03;
    
    funberOfPArticles = 30;
    zoom = 1000 / funberOfPArticles;
    
    noiseOffset = new PVector(random(10000), random(10000), random(10000));
    
    particle = new float[funberOfPArticles][funberOfPArticles];
    particlesNew = new float[funberOfPArticles][funberOfPArticles];
    particlesSpeedNew = new float[funberOfPArticles][funberOfPArticles];
  }
  
  void renderWave(){
    fill(#2D78EF,230);
    stroke(#92B9F7, 230);
    for (int x = 0; x<funberOfPArticles-1; x++) {
      for (int y = 0; y<funberOfPArticles-1; y++) {
        beginShape();
          vertex( (x)*zoom, (y)*zoom, particle[x][y] );
          vertex( (x+1)*zoom, (y)*zoom, particle[x+1][y] );
          vertex( (x+1)*zoom, (y+1)*zoom, particle[x+1][y+1] );
          vertex( (x)*zoom, (y+1)*zoom, particle[x][y+1] );
        endShape();
      }
    }
  }
  
  void updateNoise(){
    for (int x = 1; x<funberOfPArticles-2; x++) {
      for (int y = 1; y<funberOfPArticles-2; y++) {
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
  
        //force1 = constrain(force1, -1, 1);
  
        particlesSpeedNew[x][y] = 0.995 * particlesSpeedNew[x][y] + force1/100;
  
        particlesNew[x][y] = particle[x][y] + particlesSpeedNew[x][y];
      }
    }
  
    for (int x = 1; x<funberOfPArticles-1; x++) {
      for (int y = 1; y<funberOfPArticles-1; y++) {
        particle[x][y] = particlesNew[x][y];
      }
    }
    
    float t = frameCount * timeScale;
    
    if (waveOrNot != 0) {
      int NoiseXIndex = 2 + (int)((funberOfPArticles-4) * noise(noiseScale + noiseOffset.x + t, noiseScale + noiseOffset.y + t, t + noiseOffset.z));
      int NoiseYIndex = 2 + (int)((funberOfPArticles-4) * noise(noiseScale + noiseOffset.x + t, noiseScale + noiseOffset.y + t, t + noiseOffset.z));
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
