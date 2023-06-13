class Ship{
  PImage sprite;
  float x = 200;
  float y;
  float acceleration = 0;
  float impulse = 0;
  float lifePoints;
  
  Ship(){
    sprite = loadImage("ship.png");
    sprite.resize(100, 60);
    y = height/2;
    lifePoints = 5;
  }
  
  void drawShip(){
    image(sprite, x, y);
    // Movimiento vertical
    if(y >= height - sprite.height/2){
      y = height - sprite.height/2;
    }
    y += acceleration;
    
    // Movimiento Horizontal
    x += impulse;
    
    if(x >= 350){
      x = 350;
    }
    if (x <= 150){
      x = 150;
    }
  }
  
  void caer(){
    if(frameCount % 5 == 0 && acceleration <= 5){
      acceleration += 2;
    }
  }
  
  void retroceder(){
    if(frameCount % 5 == 0 && impulse >= -10){
      impulse -= 2;
    }
  }
  
  // EL método debe recibir el valor de la señal recibida por voz u OSC
  void impulsar(float impulso){
    acceleration = -impulso;
  }
  
  void impulsar(){
    acceleration = -10;
  }
  
  void adelantar(float imp){
    impulse = +imp;
  }
  
  void collision(){
    lifePoints = 0;
  }
  
  void impact(){
    lifePoints -= 1;
    impact.trigger();
  }
  
  void destroy(){
    explosion.trigger();
  }
  
  void drawExplosion(){
    image(expShip, x, y);
  }
}
