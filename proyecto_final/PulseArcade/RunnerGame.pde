void runGameRunner(){
  // Analizamos el audio
  fft.analyze(spectrum);
  amplitud = constrain(spectrum[0]*height*5, 0.0, 400.0); // Contenemos la muestra de audio para evitar errores
   
  // Para colocar las imagenes en un centro
  imageMode(CENTER);
  image(fondo, width/2, height/2, width, height);
  
  // Generar nuevos obstáculos
  if (frameCount % 30 == 0 && !deadShip) { // Cada 60 cuadros (aproximadamente 1 segundo)
    generarObstaculo();
  }
  
  if(!deadShip){
    nave.drawShip();
    // comprobamos si fue destruida o aun estando viva
    if(nave.lifePoints == 0){
      deadShip = true;
      nave.destroy();
      gameOverDelay = millis();
    }
  } else {
    nave.drawExplosion();
    // Despues de 3 segundos de la muerte mostramos el Game Over
    if(millis() - gameOverDelay >= 3000 && millis() - gameOverDelay <= 3200) {
      GOSound.trigger();
      gameOver = true;
    }
  }
  
  // Comprobar colisión con los bordes
  if(nave.y - nave.sprite.height + 30 < 0 || nave.y + nave.sprite.height - 30 > height){
    if (!deadShip){
        nave.collision();  // para evitar que se reproduzca varias veces
      }
  }
    
    
  // Mostrar y mover los proyectiles
  drawBullets();
  
  // Mostrar y mover obstaculo
  drawObstaculos();
  
  // hacer caer la nave constantemente
  //nave.caer();
  
  // impulsar la nave con el OSC
  nave.adelantar(shipImpulse);
  
  // Contolar por osc
  nave.impulsar(shipAccel);
}
