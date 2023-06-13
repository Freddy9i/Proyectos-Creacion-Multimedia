import java.util.Random;
import processing.sound.FFT;
import processing.sound.AudioIn;
import ddf.minim.*;
import oscP5.*;

PImage fondo;
Ship nave;
PImage heart;
PImage bullet, enemyBullet;
PImage edificio1, edificio2, edificio1r, edificio2r;
PImage enemyShip;
PImage expShip;
// Imagenes del arkanoid
PImage bloque0, bloque1, bloque2, bloque3, bloque4 , playerBlock, playerBall;
PImage arkanoidBackground;

// Efectos de sonido
Minim minim;
import g4p_controls.*;
AudioPlayer musicaFondo;
AudioSample gunShot;
AudioSample laser;
AudioSample explosion;
AudioSample impact;
AudioSample turbo;
AudioSample buttonSound;
AudioSample GOSound;
AudioSample startSound;

// Entradas OSC
OscP5 oscP5;
int port = 2020;
float shipAccel = 0; // Controlar la aceleracion de la nave con el telefono
float shipImpulse = 0;

// Marcador de puntos
Score score;
PFont scoreFont;

// Variables para la pantalla
GButton btn0, btn1, btn2, btn3;

// Tamaño de las pantallas
float sWidth;
float sHeight;
float offsetw;
float offseth;

// paleta de colores
color d1 = color(73,177,202);
color d2 = color(216,1,122);
color d3 = color(10,119,244);
color d4 = color(255, 255, 255);
color d5 = color(55,1,113);
color d6 = color(252,133,98);
color[] d = {d1, d2, d3, d4, d5, d6};
int Y_AXIS = 1;
int X_AXIS = 2;

// Posiciones de las figuras de fondo y Arreglo de luces de fondo
ArrayList<PVector> fPos = new ArrayList<PVector>();
ArrayList<Integer> fType = new ArrayList<Integer>();
ArrayList<BGStar> bgStars = new ArrayList<BGStar>();

// flags para control del juego
boolean deadShip = false;
boolean gameOver = false;
int gameOverDelay;
boolean inMenu = true;
String game = "NG";

// Array de obstaculos, usaremos numeros del 0 al 3 para distinguirlos 
ArrayList<Obstaculo> obstaculos;

// Array de naves enemigas
EnemyShip enemyShip1;
EnemyShip enemyShip2;
EnemyShip enemyShip3;

// Proyectiles disparados por el player y los enemigos
ArrayList<Bullet> proyectiles;
ArrayList<BulletEnemy> enemyProyectiles;

// Arrays usados en arkanoid
ArrayList<Rectangulo> cuadradosDeJuego = new ArrayList<Rectangulo>();
ArrayList<Rectangulo> bordesYJugador = new ArrayList<Rectangulo>(); //jugador = última posicion
ArrayList<PImage> bloquesColores = new ArrayList<PImage>();

// Variables arkanoid
int anchoPantalla = 1000;
int altoPantalla = 800;
int tamañoCuadrados = anchoPantalla/30;
int cantidadFilasCuadrados = 10;
int anchoBarraJugador = tamañoCuadrados*4;
int tamañoBola = tamañoCuadrados/2;
float bolaPosicionInicialX = 1680/2;
float bolaPosicionInicialY = altoPantalla-5*tamañoCuadrados;
float bolaPosicionX = bolaPosicionInicialX;
float bolaPosicionY = bolaPosicionInicialY;
float velocidadBolaX;
float velocidadBolaY;
int vidasRestantes;

// Inputs de audio
FFT fft;
AudioIn in;
int bands = 1; // Solo una banda para una sola muestra de audio
float[] spectrum = new float[bands];
float amplitud;

void setup(){
  size(1680, 800, P2D);
  frameRate(30);
  fondo = loadImage("cityBG.jpg");
  bullet = loadImage("bullet.png");
  enemyBullet = loadImage("bullet_laser.png");
  edificio1 = loadImage("build1.png");
  edificio2 = loadImage("build2.png");
  edificio1r = loadImage("build1r.png");
  edificio2r = loadImage("build2r.png");
  expShip = loadImage("shipExp.png");
  enemyShip = loadImage("ship_enemy.png");
  heart = loadImage("heart.png");
  // Imagenes arkanoid
  bloque0 = loadImage("Block0.png");
  bloque1 = loadImage("Block1.png");
  bloque2 = loadImage("Block2.png");
  bloque3 = loadImage("Block3.png");
  bloque4 = loadImage("Block4.png");
  bloquesColores.add(bloque0);
  bloquesColores.add(bloque1);
  bloquesColores.add(bloque2);
  bloquesColores.add(bloque3);
  bloquesColores.add(bloque4);
  playerBall = loadImage("Ball.png");
  playerBlock = loadImage("Platform.png");
  arkanoidBackground = loadImage("arkanoid_background.jpg");
  
  // Juego
  nave = new Ship();
  
  proyectiles = new ArrayList<Bullet>();
  enemyProyectiles = new ArrayList<BulletEnemy>();
  obstaculos = new ArrayList<Obstaculo>();
  
  // Marcador
  score = new Score(width - 100, 0);
  scoreFont = createFont("I pixel U", 120);
  
  // Inputs de audio
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  in.start();
  
  fft.input(in);
  
  // Input Osc
  oscP5 = new OscP5(this, port);
  
  // Efectos de sonido
  minim = new Minim(this);
  
  musicaFondo = minim.loadFile("ROAD.mp3");
  gunShot = minim.loadSample("sound_gun.wav");
  laser = minim.loadSample("sound_laser.mp3");
  turbo = minim.loadSample("sound_turbo.mp3");
  explosion = minim.loadSample("sound_explosion.mp3");
  impact = minim.loadSample("sound_player_impact.wav");
  //startSound = minim.loadSample("start.wav");
  GOSound =  minim.loadSample("game_over.wav");
  buttonSound = minim.loadSample("button.wav");
  
  // Reproducir en bucle el soundtrack
  musicaFondo.loop();
  
  // Pantallas
  sWidth = width*0.75;
  sHeight = height*0.75;
  offsetw = (width - sWidth)/2;
  offseth = (height - sHeight)/2;
  G4P.messagesEnabled(false);
  
  // Botones
  btn0 = new GButton(this, width/2 - 100, height - height/4, 200, 60, "MENU");
  btn1 = new GButton(this, width/2 - 400, height - height/4, 200, 60, "RUNNER");
  btn2 = new GButton(this, width/2 + 200, height - height/4, 200, 60, "COMMANDER");
  btn3 = new GButton(this, width/2 - 100, height - height/4, 200, 60, "ARKANOID");
  btn0.setVisible(false);
  btn1.setVisible(false);
  btn2.setVisible(false);
  btn3.setVisible(false);
  
  // Figuras de fondo
  for (int x = 0; x < 35; x ++){
    fPos.add(new PVector(random(offsetw + 10, sWidth + offsetw - 10), random(offseth + 10, sHeight + offseth - 10)));
    fType.add(int(random(1, 6)));
  }
  
  // Luces de fondo
  for (float x = offsetw+10; x < sWidth+offsetw-10; x += sWidth/25){
    for(float y = offseth+10; y < sHeight+offseth-10; y += sHeight/25){
      bgStars.add(new BGStar(x, y));
    }
  }
}

void draw(){
  background(0);
  
  // Si no se está en menú se empieza el juego
  if(!inMenu){
    
    // Corremos el juego
    // TODO: Elegir el juego
    switch(game){
      case "runner":
        runGameRunner();
        break;
      case "commander":
        runGameCommander();
        break;
      case "arkanoid":
        runGameArkanoid();
        break;
    }
    
    // Marcador, siempre al final para que se dibuje por encima
    score.drawScore();
    
    // Comprobamos si mostramos la pantalla de gameOver
    if(gameOver){
      drawGOScreen();
    }
  } else {
    imageMode(CENTER);
    image(fondo, width/2, height/2, width, height);
    drawSTScreen();
  }
}


// Se usó la app multisense OSC, se conecta al puerto indicado y con la ip local del pc
void oscEvent(OscMessage message) {
  if(game == "runner" || game == "commander"){
    if(message.checkAddrPattern("/multisense/orientation/pitch")){
      float signal = constrain(Math.abs(message.get(0).floatValue()), 45, 90);
      shipAccel = map(signal, 45, 90, -10, 13);
    }
  }
  
  if(game == "arkanoid"){
    if(message.checkAddrPattern("/multisense/orientation/pitch")){
      Rectangulo jugador = bordesYJugador.get(bordesYJugador.size() - 1);
      float signal = constrain(Math.abs(message.get(0).floatValue()), 45, 90);
      float movement = map(signal, 45, 90, 12, -12);
      //rectangles.get(rectangles.size() - 1).x = 20;
      float aux = jugador.x + movement;
      //println(aux);
      
      if (aux<width/2 - anchoPantalla/2){
        jugador.x = width/2 - anchoPantalla/2;
      }
      else if (aux>width/2 + anchoPantalla/2 - jugador.ancho){
        jugador.x = width/2 + anchoPantalla/2 - jugador.ancho;
      }
      else {
        jugador.x = (int) aux;
      }
    }
  }
}


void stop(){
  // Detiene la reproducción y libera los recursos al cerrar la aplicación
  musicaFondo.close();
  gunShot.close();
  laser.close();
  explosion.close();
  turbo.close();
  minim.stop();
  
  super.stop();
}
