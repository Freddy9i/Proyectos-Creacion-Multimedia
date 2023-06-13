import oscP5.*;
OscP5 oscP5;
int port = 2020;

// Imagenes del arkanoid
PImage bloque, playerBlock, playerBall;
PImage arkanoidBackground;

class Rectangulo {
  float x;
  float y;
  float ancho;
  float alto;
  PImage sprite;
  
  public Rectangulo(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
    this.sprite = playerBlock;
  }
}

ArrayList<Rectangulo> cuadradosDeJuego = new ArrayList<Rectangulo>();
ArrayList<Rectangulo> bordesYJugador = new ArrayList<Rectangulo>(); //jugador = última posicion

int anchoPantalla = 1000;
int altoPantalla = 800;
int tamañoCuadrados = anchoPantalla/30;
int cantidadFilasCuadrados = 10;
int anchoBarraJugador = tamañoCuadrados*4;
int tamañoBola = tamañoCuadrados/2;
float bolaPosicionInicialX = anchoPantalla/2;
float bolaPosicionInicialY = altoPantalla-5*tamañoCuadrados;
float bolaPosicionX = bolaPosicionInicialX;
float bolaPosicionY = bolaPosicionInicialY;
float velocidadBolaX = -4;
float velocidadBolaY = -4;
int vidasRestantes = 3;

void settings() {
  size(anchoPantalla, altoPantalla, P2D);
}

void setup() {
  oscP5 = new OscP5(this, port);
  
  // Imagenes arkanoid
  bloque = loadImage("Block.png");
  playerBall = loadImage("Ball.png");
  playerBlock = loadImage("Platform.png");
  arkanoidBackground = loadImage("arkanoid_background.jpg");
  
  //agregando bordes de pantalla y jugador
  bordesYJugador.add(new Rectangulo(0, -10, anchoPantalla, 10));
  bordesYJugador.add(new Rectangulo(-10, 0, 10, altoPantalla));
  bordesYJugador.add(new Rectangulo(anchoPantalla, 0, 10, altoPantalla));
  //barra jugador
  bordesYJugador.add(new Rectangulo((anchoPantalla/2)-(anchoBarraJugador/2), bolaPosicionY+tamañoCuadrados, anchoBarraJugador, 20));
  
  //agregando cuadrados de juego
  inicializarCuadradosDeJuego();
}

void draw() {
  background(0);
  image(arkanoidBackground, 0, 0, anchoPantalla, altoPantalla);
  
  verificarColisiones(cuadradosDeJuego, true);
  verificarColisiones(bordesYJugador, false);
  
  //dibujar rectángulos
  for (int i = 0; i < cuadradosDeJuego.size(); i++) {
    Rectangulo rectangulo = cuadradosDeJuego.get(i);
    fill(0, 0, 255);
    image(bloque, rectangulo.x, rectangulo.y, rectangulo.ancho, rectangulo.alto);  
  }
  for (int i = 0; i < bordesYJugador.size(); i++) {
    Rectangulo rectangulo = bordesYJugador.get(i);
    fill(255, 0, 0);
    image(rectangulo.sprite,rectangulo.x, rectangulo.y, rectangulo.ancho, rectangulo.alto);  
  }  

  //actualizar posición bola
  bolaPosicionX += velocidadBolaX;
  bolaPosicionY += velocidadBolaY;
  
  //si la bola se sale la posición se reinicia y se resta una vida
  //si las vidas llegan a cero se reinician y se inicializan todos los cuadrados de nuevo
  if (bolaPosicionY>altoPantalla){
    vidasRestantes--;
    if (vidasRestantes==0){
      inicializarCuadradosDeJuego();
      vidasRestantes = 3;
    }
    bolaPosicionX = bolaPosicionInicialX;
    bolaPosicionY = bolaPosicionInicialY;
    velocidadBolaX = -4;
    velocidadBolaY = -4;
  }

  //dibujar bola
  fill(0, 255, 0);
  image(playerBall, bolaPosicionX, bolaPosicionY, tamañoBola, tamañoBola);
  
  //texto vidas
  textSize(40);
  fill(255);
  text("Vidas: "+vidasRestantes, 10, altoPantalla-tamañoBola); 
}


void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/multisense/orientation/pitch")){
    Rectangulo jugador = bordesYJugador.get(bordesYJugador.size() - 1);
    float signal = constrain(Math.abs(message.get(0).floatValue()), 45, 90);
    float shipAccel = map(signal, 45, 90, 8, -8);
    println(signal);
    //rectangles.get(rectangles.size() - 1).x = 20;
    float aux = jugador.x + shipAccel;
    //println(aux);
    
    if (aux<0){
      jugador.x = 0;
    }
    else if (aux>anchoPantalla-jugador.ancho){
      jugador.x = anchoPantalla-jugador.ancho;
    }
    else {
      jugador.x = (int) aux;
    }
  }
}


void inicializarCuadradosDeJuego(){
  cuadradosDeJuego.clear();
  for (int x = tamañoCuadrados; x < anchoPantalla - tamañoCuadrados*2; x+=tamañoCuadrados*2) {
    for (int y = 0; y < tamañoCuadrados*cantidadFilasCuadrados; y+=tamañoCuadrados) {
      if (x > y && y < (anchoPantalla - tamañoCuadrados*2) - x){
        cuadradosDeJuego.add(new Rectangulo(x, y, tamañoCuadrados*2, tamañoCuadrados));
      }
    }
  }
}


void verificarColisiones(ArrayList<Rectangulo> rectangulos, boolean eliminarElemento){
  for (int i = 0; i < rectangulos.size(); i++) {
    
    //check collision for this obstacle
    Rectangulo rectangulo = rectangulos.get(i);
    
    //verificar colisiones eje X
    if (bolaPosicionX + tamañoBola + velocidadBolaX > rectangulo.x && 
      bolaPosicionX + velocidadBolaX < rectangulo.x + rectangulo.ancho && 
      bolaPosicionY + tamañoBola > rectangulo.y && 
      bolaPosicionY < rectangulo.y + rectangulo.alto) {

      velocidadBolaX *= -1;
      if(eliminarElemento){
        rectangulos.remove(i);
      }
    }

    //verificar colisiones eje Y
    if (bolaPosicionX + tamañoBola> rectangulo.x && 
      bolaPosicionX< rectangulo.x + rectangulo.ancho && 
      bolaPosicionY + tamañoBola + velocidadBolaY > rectangulo.y && 
      bolaPosicionY + velocidadBolaY < rectangulo.y + rectangulo.alto) {

      velocidadBolaY *= -1;
      if(eliminarElemento){
        rectangulos.remove(i);
      }
    }
  }
}
