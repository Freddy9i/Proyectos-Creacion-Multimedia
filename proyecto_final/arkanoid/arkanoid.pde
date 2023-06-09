import oscP5.*;
OscP5 oscP5;
int port = 2020;

class Rectangulo {
  float x;
  float y;
  float ancho;
  float alto;
  
  public Rectangulo(float x, float y, float ancho, float alto) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }
}

ArrayList<Rectangulo> cuadradosDeJuego = new ArrayList<Rectangulo>();
ArrayList<Rectangulo> bordesYJugador = new ArrayList<Rectangulo>(); //jugador = última posicion

int anchoPantalla = 1000;
int altoPantalla = 800;
int tamañoCuadrados = anchoPantalla/40;
int cantidadFilasCuadrados = 10;
int anchoBarraJugador = tamañoCuadrados*4;
int tamañoBola = tamañoCuadrados/2;
float bolaPosicionInicialX = anchoPantalla/2;
float bolaPosicionInicialY = altoPantalla-10*tamañoCuadrados;
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
  
  //agregando bordes de pantalla y jugador
  bordesYJugador.add(new Rectangulo(0, -10, anchoPantalla, 10));
  bordesYJugador.add(new Rectangulo(-10, 0, 10, altoPantalla));
  bordesYJugador.add(new Rectangulo(anchoPantalla, 0, 10, altoPantalla));
  //barra jugador
  bordesYJugador.add(new Rectangulo((anchoPantalla/2)-(anchoBarraJugador/2), bolaPosicionY+tamañoCuadrados, anchoBarraJugador, 10));
  
  //agregando cuadrados de juego
  inicializarCuadradosDeJuego();
}

void draw() {
  background(0);
  
  verificarColisiones(cuadradosDeJuego, true);
  verificarColisiones(bordesYJugador, false);
  
  //dibujar rectángulos
  for (int i = 0; i < cuadradosDeJuego.size(); i++) {
    Rectangulo rectangulo = cuadradosDeJuego.get(i);
    fill(0, 0, 255);
    rect(rectangulo.x, rectangulo.y, rectangulo.ancho, rectangulo.alto);  
  }
  for (int i = 0; i < bordesYJugador.size(); i++) {
    Rectangulo rectangulo = bordesYJugador.get(i);
    fill(255, 0, 0);
    rect(rectangulo.x, rectangulo.y, rectangulo.ancho, rectangulo.alto);  
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
  rect(bolaPosicionX, bolaPosicionY, tamañoBola, tamañoBola);
  
  //texto vidas
  textSize(40);
  fill(255);
  text("Vidas: "+vidasRestantes, 10, altoPantalla-tamañoBola); 
}


void oscEvent(OscMessage message) {
  if(message.checkAddrPattern("/multisense/orientation/roll")){
    Rectangulo jugador = bordesYJugador.get(bordesYJugador.size() - 1);
    //rectangles.get(rectangles.size() - 1).x = 20;
    float aux = jugador.x + message.get(0).floatValue();
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
  for (int x = 0; x < anchoPantalla; x+=tamañoCuadrados) {
    for (int y = 0; y < tamañoCuadrados*cantidadFilasCuadrados; y+=tamañoCuadrados) {
      cuadradosDeJuego.add(new Rectangulo(x, y, tamañoCuadrados, tamañoCuadrados));
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
