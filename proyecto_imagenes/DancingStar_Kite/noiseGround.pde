float xNoise = 0.0;
float yNoise = 0.0;

float inc = 0.009;

//Esta funcion ignorarla
void noiseGround(){
  for (int y=0; y<height; y++){
    for (int x=0; x<width; x++){
      float r = noise(xNoise, yNoise)*125;
      float g = noise(xNoise, yNoise)*55;
      float b = noise(xNoise, yNoise)*215;
      stroke(r,g,b);
      point(x,y);
      xNoise += inc;
    }
    xNoise = 0.0;
    yNoise += inc;
  }
}
