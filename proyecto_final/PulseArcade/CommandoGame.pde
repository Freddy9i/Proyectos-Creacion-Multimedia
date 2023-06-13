void runGameCommander(){
  // Analizamos el audio
  fft.analyze(spectrum);
  amplitud = constrain(spectrum[0]*height*5, 0.0, 400.0); // Contenemos la muestra de audio para evitar errores
   
  // Para colocar las imagenes en un centro
  imageMode(CENTER);
  image(fondo, width/2, height/2, width, height);
  
  // Generar nuevos enemigos
  if (frameCount % 60 == 0 && !deadShip) { // Cada 120 cuadros (aproximadamente 2 segundo)
    generarEnemigo();
  }
  
  // Enemigos disparan cada cierta cantidad de frames
  if ((frameCount % 120 == 0 || frameCount % 60 == 0) && !deadShip && enemyShip1.alive) {
    BulletEnemy proyectil = new BulletEnemy(enemyShip1.x, enemyShip1.y, enemyBullet);
    enemyProyectiles.add(proyectil);
    laser.trigger();
  }
  
  if ((frameCount % 90 == 0 || frameCount % 80 == 0) && !deadShip && enemyShip2.alive) {
    BulletEnemy proyectil = new BulletEnemy(enemyShip2.x, enemyShip2.y, enemyBullet);
    enemyProyectiles.add(proyectil);
    laser.trigger();
  }
  
  if ((frameCount % 100 == 0 || frameCount % 70 == 0) && !deadShip && enemyShip3.alive) {
    BulletEnemy proyectil = new BulletEnemy(enemyShip3.x, enemyShip3.y, enemyBullet);
    enemyProyectiles.add(proyectil);
    laser.trigger();
  }
  
  if(!deadShip){
    nave.drawShip();
    
    // Dibujamos las vidas
    for (int i = 1; i <= nave.lifePoints; i++){
      tint(255, 255, 0);
      image(heart, 20 + 52*i, 40);
      noTint();
    }
    
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
  drawEnemyBullets();
  
  // Mostrar y mover obstaculo
  drawEnemigos();
  
  // hacer caer la nave constantemente
  // nave.caer();
  
  // impulsar la nave con el audio, probar diciando A
  //if (amplitud > 200){
  //  //nave.impulsar(map(amplitud, 0, 400.0, 1, 20));
  //  nave.impulsar();
  //}
  
  nave.impulsar(shipAccel);
  
  // Disparar con la voz, probar con la I
  if (amplitud > 40 && amplitud < 100){
    // Disparar un nuevo proyectil desde la posición de la nave, la idea es que solo sea en modo combate
    if (!deadShip){
      Bullet bulletPlayer = new Bullet(nave.x, nave.y, bullet);
      proyectiles.add(bulletPlayer);
      gunShot.trigger();
    }
  }
}
