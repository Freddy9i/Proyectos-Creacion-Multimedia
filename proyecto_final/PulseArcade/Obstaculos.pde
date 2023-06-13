class Obstaculo{
  float x, y;
  int tipo;
  PImage sprite;
  boolean logrado;
  
  Obstaculo(){
    x = width;
    logrado = false;
    Random random = new Random();
    tipo = random.nextInt(4);
    
    switch(tipo){
      case 0:
        sprite = edificio1;
        y = height - edificio1.height/2;
        break;
      case 1:
        sprite = edificio2;
        y = height - edificio2.height/2;
        break;
      case 2:
        sprite = edificio1r;
        y = edificio1r.height/2;
        break;
      case 3:
        sprite = edificio2r;
        y = edificio2r.height/2;
        break;
    }
  }
  
  boolean getLogrado(){
    return this.logrado;
  }
  
  void setLogrado(boolean value){
    this.logrado = value;
  }
}

void generarObstaculo(){
  // Crear un nuevo obstaculo
  Obstaculo obstaculo = new Obstaculo();
  obstaculos.add(obstaculo);
}

void drawObstaculos(){
  
  //velocidad de obstaculos
  int speed = 24;
  
  // Mostrar y mover los obstáculos
  for (int i = obstaculos.size() - 1; i >= 0; i--) {
    Obstaculo obstaculo = obstaculos.get(i);
    image(obstaculo.sprite, obstaculo.x, obstaculo.y);
    if(!deadShip){
      obstaculo.x -= speed; // Mueve el obstáculo hacia la izquierda si aun se está en juego
    }
    
    
    // Verificar si el obstáculo sale de la pantalla
    if (obstaculo.x + obstaculo.sprite.width < 0) {
      obstaculos.remove(i); // Elimina el obstáculo de la lista si sale de la pantalla
    }
    
    // Verificar si hay colisión de la nave
    if (verificarColision(nave.sprite, obstaculo.sprite, nave.x, nave.y, obstaculo.x, obstaculo.y, obstaculo.tipo)){
      if (!deadShip){
        nave.collision();  // para evitar que se reproduzca varias veces
      }
    }
    
    // Verificar si ya pasó el obstaculo puntuar
    if(nave.x >= obstaculo.x && !obstaculo.getLogrado() && !deadShip){
      score.acierto();
      obstaculo.setLogrado(true);
    }
  }
}

boolean verificarColision(PImage objeto1, PImage objeto2, float x1, float y1, float x2, float y2, int obsType) {
  // Obtener las coordenadas y dimensiones de los objetos
  float obj1X = x1;
  float obj1Y = y1;
  float obj1Ancho = objeto1.width-40;
  float obj1Alto = objeto1.height-15;
  
  float obj2X = x2;
  float obj2Y = y2;
  float obj2Ancho = objeto2.width - 20;
  float obj2Alto = objeto2.height - 15;
  
  // Visualización del collider
  //pushMatrix();
  //strokeWeight(3);
  //noFill();
  //rectMode(CENTER);
  //rect(x1, y1, obj1Ancho, obj1Alto);
  //rect(x2, y2, obj2Ancho, obj2Alto);
  //popMatrix();
  
  // Verificar si las cajas delimitadoras se superponen con la distancia, NO CAMBIAR ESTE CONDICIONAL
  // TODO REVISAR COLLIDERS DE OBJETOS SUPERIORES
  if (obsType == 0 || obsType == 1){
    if (obj1X + obj1Ancho >= obj2X && obj1X <= obj2X + obj2Ancho &&
      obj1Y + obj1Alto/2 <= obj2Y + obj2Alto/2 && obj1Y >= obj2Y - obj2Alto/2) {
      return true; // Hay colisión
    } else {
      return false; // No hay colisión
    }
  } 
  else{
    if (obj1X + obj1Ancho >= obj2X && obj1X <= obj2X + obj2Ancho/2 &&
      obj1Y - obj1Alto/2 <= obj2Y + obj2Alto/2  && obj1Y <= obj2Y + obj2Alto/2) {
      return true; // Hay colisión
    } else {
      return false; // No hay colisión
    }
  }
}
