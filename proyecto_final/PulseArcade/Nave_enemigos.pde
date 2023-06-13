class EnemyShip{
  PImage sprite;
  float x = width;
  float maxX;
  float y;
  float lifePoints;
  boolean alive;
  boolean inScreen = true;
  float deadTime;
  
  EnemyShip(float posymin, float posymax){
    sprite = enemyShip;
    sprite.resize(100, 60);
    y = random(posymin, posymax);
    maxX = random(width-500, width-100);
    lifePoints = 5;
    alive = true;
  }
  
  void drawShip(){
    image(sprite, x, y);
    
    // Para que entre un poco en pantalla
    if (x >= maxX){
      x -= 6;
    }
    
    // Pequeña barra de vida en la parte superior
    pushMatrix();
    rectMode(CENTER);
    fill(255);
    noStroke();
    rect(x, y-50, sprite.width, 10);
    fill(0,0,255);
    rect(x, y-50, sprite.width - sprite.width/5 * lifePoints , 10);
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(x, y-50, sprite.width, 10);
    popMatrix();
  }
  
  float getLifePoints(){
    return lifePoints;
  }
  
  void setAlive(){
    alive = false;
  }
  
  void impact(){
    lifePoints -= 1;
    impact.trigger();
  }
  
  void destroy(){
    explosion.trigger();
  }
  
  void checkDead(){
    if(lifePoints <= 0){
      alive = false;
      score.acierto();
      deadTime = millis();
      destroy();
    }
  }
  
  void checkDestroy(){
    if(millis() >= deadTime + 2000){ // desaparecer de la pantalla luego de 2 segundos de explosion
      inScreen = false;
    }
  }
  
  void drawExplosion(){
    pushMatrix();
    tint(0, 255, 0);
    image(expShip, x, y);
    noTint();
    popMatrix();
  }
}


// Funciones para el manejo de enemigos
void generarEnemigo(){
  
  // Crear un nuevo enemigo
  if (!enemyShip1.inScreen){
    enemyShip1 = new EnemyShip(150, 300);
  } else if (!enemyShip2.inScreen){
    enemyShip2 = new EnemyShip(350, 500);
  } else if (!enemyShip3.inScreen){
    enemyShip3 = new EnemyShip(550, 700);
  }
}

void drawEnemigos(){
  
  // Mostrar y mover los enemigos
  
  if (enemyShip1.alive){
    enemyShip1.drawShip();
    
    // Verificar si el enemigo muere y puntua si lo hace
    enemyShip1.checkDead();
  } else if(enemyShip1.inScreen){  // Luego de morir mostrar una explosion
    enemyShip1.drawExplosion();
    enemyShip1.checkDestroy();
  }
  
  if (enemyShip2.alive){
    enemyShip2.drawShip();
    enemyShip2.checkDead();
  } else if(enemyShip2.inScreen){  // Luego de morir mostrar una explosion
    enemyShip2.drawExplosion();
    enemyShip2.checkDestroy();
  }
  
  if (enemyShip3.alive){
    enemyShip3.drawShip();
    enemyShip3.checkDead();
  } else if(enemyShip3.inScreen){  // Luego de morir mostrar una explosion
    enemyShip3.drawExplosion();
    enemyShip3.checkDestroy();
  }
}
