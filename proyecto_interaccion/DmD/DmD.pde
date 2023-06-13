import java.util.LinkedList;

float diameter = 300;
float strokeWidth = 2;
float speed = 2;
float pos = 0;
color strokeColor = color(255, 255, 255);
color bgColor = color(0, 0, 0);

//paletas de colores, el orden es segun la rueda cromatica
color[] tonoVerde = {#00E00F, #01FA10, #00AD0C, #006B07};
color[] tonoAzul = {#003EFA, #0038E0, #002BAD, #001C70};
color[] tonoMorado = {#C800FA, #B400E0, #8B00AD, #61007A};
color[] tonoRojo = {#FA0008, #E00007, #AD0006, #700105};
color[] tonoNaranja = {#FA5700, #E04F00, #AD3D00, #752800};
color[] tonoAmarillo = {#FAEE01, #E0D500, #ADA500, #7A7401};
ArrayList <color[]> paletasDeColores = new ArrayList<color[]>();

// Fuentes y Fondo
PFont activatorFont;
PFont scoreFont;
PImage fondo;

//Tiempo para activadores
int tiempoEntreActivadores = 500;
int ultimoTiempoActivador = 0;

// Cola de activadores para llevar el orden
LinkedList<Activador> cola = new LinkedList<Activador>();
// Puntos para dibujar los activadores
ArrayList<PVector> points;
int activadoresCount;
int activadoresText;

// flag para eventos de activacion
boolean isInEvent = false;

// Marcador
Score score;

void setup() {
  size(1480,1000);
  background(bgColor);
  activatorFont = createFont("Holyrock", 60);
  scoreFont = createFont("Holyrock", 120);
  fondo = loadImage("dmc.png");

  score = new Score(width-50, 75);
}

void draw() {
  image(fondo, 0, 0);
  // Se dibuja el marcador
  score.drawScore();

  // Verificamos que no se haya otro tipo de evento para crearlo
  if (!isInEvent) {
    Snake snake = new Snake();

    // Avisamos que comenzo un evento de activadores
    isInEvent = true;

    // obtenemos los Puntos del camino de la serpiente
    points = snake.getPoints();
    activadoresCount = points.size();
    activadoresText = 0;
  }

  // Verificamos si es tiempo de crear un nuevo activador en los tres tipos
  if (millis() - ultimoTiempoActivador >= tiempoEntreActivadores) {

    // Comprobar si hay camino de la serpiente
    if (!points.isEmpty()) {
      PVector p = points.get(0);
      activadoresText ++;
      Activador nuevoActivador = new Activador(p.x, p.y);
      cola.add(nuevoActivador);
      // Se actualiza el tiempo del ultimo activador creado
      ultimoTiempoActivador = millis();
      // Se remueve el punto donde ya se estuvo
      points.remove(0);
    }
  }

  // Dibujar activadores en la cola
  for (Activador activador : cola) {
    activador.drawActivador();
  }
  // Si no se acierta al activador se borra
  if (!cola.isEmpty()) {
    Activador activador = cola.getFirst();
    activador.actColor = color(0, 0, 255);
    boolean fail = activador.fail();
    // Comprobamos si falló
    if (fail) {
      activador.deactive();
      cola.removeFirst();
      activadoresCount --;
    }
  }
  
  // Si ya no quedan activadores en pantalla poner evento disponible
  if (activadoresCount == 0){
    isInEvent = false;
  }
}

// Para usar el teclado
//void keyPressed() {
//  if (!cola.isEmpty()) {
//    Activador activador = cola.getFirst();
//    boolean nice = activador.nice(key);
//    // Comprobamos si acertó
//    if (nice) {
//      activador.deactive();
//      cola.removeFirst();
//      activadoresCount -= 1;
//      score.acierto();
//    }
//  }
//}

void mousePressed(){
  if(!cola.isEmpty()){
    Activador activador = cola.getFirst();
    boolean nice = activador.nice();
    
    // Comprobamos si acertó
    if (nice){
      score.acierto();
    } else {
      score.perderRacha();
    }
    
    // Removemos el activado de la cola
    activador.deactive();
    cola.removeFirst();
    activadoresCount --;
  }
}
