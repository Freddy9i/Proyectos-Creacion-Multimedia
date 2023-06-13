void startGameRunner(){
  game = "runner";
  nave = new Ship();
  
  proyectiles = new ArrayList<Bullet>();
  obstaculos = new ArrayList<Obstaculo>();
  
  score.setPuntos(0);
  
  gameOver = false;
  inMenu = false;
  deadShip = false;
  btn0.setVisible(false);
  btn1.setVisible(false);
  btn2.setVisible(false);
  btn3.setVisible(false);
  
  // Cargo la cancion respectiva
  musicaFondo.close();
  musicaFondo = minim.loadFile("PUSH_IT.mp3");
  musicaFondo.loop();
}

void startGameCommander(){
  game = "commander";
  nave = new Ship();
  
  proyectiles = new ArrayList<Bullet>();
  
  enemyShip1 = new EnemyShip(50, 200);
  enemyShip2 = new EnemyShip(250, 500);
  enemyShip3 = new EnemyShip(550, 700);
  
  score.setPuntos(0);
  
  gameOver = false;
  inMenu = false;
  deadShip = false;
  btn0.setVisible(false);
  btn1.setVisible(false);
  btn2.setVisible(false);
  btn3.setVisible(false);
  
  // Cargo la cancion respectiva
  musicaFondo.close();
  musicaFondo = minim.loadFile("GAS.mp3");
  musicaFondo.loop();
}

void startGameArkanoid(){
  game = "arkanoid";
  score.setPuntos(0);
  gameOver = false;
  inMenu = false;
  deadShip = false;
  btn0.setVisible(false);
  btn1.setVisible(false);
  btn2.setVisible(false);
  btn3.setVisible(false);
  
  // Cargo la cancion respectiva
  musicaFondo.close();
  musicaFondo = minim.loadFile("DEJA_VU.mp3");
  musicaFondo.loop();
  
  //agregando bordes de pantalla y jugador
  //bordesYJugador.add(new Rectangulo(0, -10, anchoPantalla, 10));
  //bordesYJugador.add(new Rectangulo(width/2 + anchoPantalla + 10, 0, 10, altoPantalla));
  //bordesYJugador.add(new Rectangulo(width/2+anchoPantalla, 0, 10, altoPantalla));
  //barra jugador
  bordesYJugador = new ArrayList<Rectangulo>();
  bordesYJugador.add(new Rectangulo(width/2, bolaPosicionY+tamañoCuadrados, anchoBarraJugador, 20));
  
  // Variables gameplay
  velocidadBolaX = -10;
  velocidadBolaY = -10;
  vidasRestantes = 3;
  
  //agregando cuadrados de juego
  inicializarCuadradosDeJuego();
}

void loadMenu(){
  inMenu = true;
  btn0.setVisible(false);
  btn1.setVisible(false);
  btn2.setVisible(false);
  btn3.setVisible(false);
  
  // Cargo la cancion respectiva
  musicaFondo.close();
  musicaFondo = minim.loadFile("ROAD.mp3");
  musicaFondo.loop();
}


// Manejadores de eventos
public void handleBtn1(GButton button, GEvent event) {
  buttonSound.trigger();
  startGameRunner();
}

// Manejadores de eventos
public void handleBtn2(GButton button, GEvent event) {
  buttonSound.trigger();
  startGameCommander();
}

// Manejadores de eventos
public void handleBtn3(GButton button, GEvent event) {
  buttonSound.trigger();
  startGameArkanoid();
}

public void handleBtn0(GButton button, GEvent event) {
  buttonSound.trigger();
  loadMenu();
}
