void inicializarCuadradosDeJuego(){
  cuadradosDeJuego.clear();
  for (int x = tamañoCuadrados*3 + width/2 - anchoPantalla/2 ; x < width/2 + anchoPantalla/2 - tamañoCuadrados*4; x+=tamañoCuadrados*2) {
    for (int y = 0; y < tamañoCuadrados*cantidadFilasCuadrados; y+=tamañoCuadrados) {
      if (true){  // Para cambiar la distribución de cuadrados
        cuadradosDeJuego.add(new Rectangulo(x, y, tamañoCuadrados*2, tamañoCuadrados, bloquesColores.get((int)random(0, 5))));  // Se agruega un bloque con un color random
      }
    }
  }
}

void verificarColisionesArk(ArrayList<Rectangulo> rectangulos, boolean eliminarElemento){
  for (int i = 0; i < rectangulos.size(); i++) {
    
    //check collision for this obstacle
    Rectangulo rectangulo = rectangulos.get(i);
    
    //verificar colisiones eje X
    if (bolaPosicionX + tamañoBola + velocidadBolaX > rectangulo.x && 
      bolaPosicionX + velocidadBolaX < rectangulo.x + rectangulo.ancho && 
      bolaPosicionY + tamañoBola > rectangulo.y && 
      bolaPosicionY < rectangulo.y + rectangulo.alto) {

      velocidadBolaX *= -1;
      impact.trigger();
      if(eliminarElemento){
        score.acierto();
        rectangulos.remove(i);
      }
    } else if (bolaPosicionX + tamañoBola> rectangulo.x &&
      bolaPosicionX< rectangulo.x + rectangulo.ancho && 
      bolaPosicionY + tamañoBola + velocidadBolaY > rectangulo.y && 
      bolaPosicionY + velocidadBolaY < rectangulo.y + rectangulo.alto) {    //verificar colisiones eje Y

      velocidadBolaY *= -1;
      impact.trigger();
      if(eliminarElemento){
        score.acierto();
        rectangulos.remove(i);
      }
    }
  }
}

void verificarColisionesExt(){
  //verificar colisiones eje X
  if (bolaPosicionX + tamañoBola/2 >= width/2 + anchoPantalla/2 || bolaPosicionX - tamañoBola/2 <= width/2 - anchoPantalla/2){
    velocidadBolaX *= -1;
  }

  //verificar colisiones eje Y, solo se comprueba la superior
  if(bolaPosicionY - tamañoBola/2 <= 0){
    velocidadBolaY *= -1;
  }
}

void runGameArkanoid(){
  imageMode(CENTER);
  image(fondo, width/2, height/2, width, height);
  image(arkanoidBackground, width/2, height/2, anchoPantalla, altoPantalla);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(10);
  rect(width/2, height/2, anchoPantalla + 10, altoPantalla+20);
  
  verificarColisionesArk(cuadradosDeJuego, true);
  verificarColisionesArk(bordesYJugador, false);
  verificarColisionesExt();
  
  //dibujar rectángulos
  for (int i = 0; i < cuadradosDeJuego.size(); i++) {
    Rectangulo rectangulo = cuadradosDeJuego.get(i);
    fill(0, 0, 255);
    imageMode(CORNER);
    image(rectangulo.sprite, rectangulo.x, rectangulo.y, rectangulo.ancho, rectangulo.alto);
    imageMode(CENTER); // Para no romper el modo de las demás imagenes
  }
  for (int i = 0; i < bordesYJugador.size(); i++) {
    Rectangulo rectangulo = bordesYJugador.get(i);
    fill(255, 0, 0);
    imageMode(CORNER);
    image(rectangulo.sprite,rectangulo.x, rectangulo.y, rectangulo.ancho, rectangulo.alto);
    imageMode(CENTER); // Para no romper el modo de las demás imagenes
  }  

  //actualizar posición bola
  bolaPosicionX += velocidadBolaX;
  bolaPosicionY += velocidadBolaY;
  
  //si la bola se sale la posición se reinicia y se resta una vida
  //si las vidas llegan a cero se reinician y se inicializan todos los cuadrados de nuevo
  if (bolaPosicionY>altoPantalla){
    vidasRestantes--;
    if (vidasRestantes==0){
      // Detener la bola
      velocidadBolaX = 0;
      velocidadBolaY = 0;
      bolaPosicionX = bolaPosicionInicialX;
      bolaPosicionY = bolaPosicionInicialY;
      GOSound.trigger();
      gameOver = true;
    } else {
      bolaPosicionX = bolaPosicionInicialX;
      bolaPosicionY = bolaPosicionInicialY;
      velocidadBolaX = -10;
      velocidadBolaY = -10;
    }
  }
  
  // EL juego acaba si se revientan todos los bloques
  if(cuadradosDeJuego.size() == 0){
    // Detener la bola
    velocidadBolaX = 0;
    velocidadBolaY = 0;
    bolaPosicionX = bolaPosicionInicialX;
    bolaPosicionY = bolaPosicionInicialY;
    GOSound.trigger();
    gameOver = true;
  }

  //dibujar bola
  fill(0, 255, 0);
  image(playerBall, bolaPosicionX, bolaPosicionY, tamañoBola, tamañoBola);
  
  // Dibujamos las vidas
  for (int i = 1; i <= vidasRestantes; i++){
    tint(255, 255, 0);
    image(heart, 20 + 52*i, 40);
    noTint();
  }
}
