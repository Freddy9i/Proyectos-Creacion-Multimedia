import netP5.*;
import oscP5.*;

//Ritmos que vendrán del PD
float ritmo1, ritmo2, ritmo3, ritmo3b, voice, puntas;
//Amplitudes máximas y minimas de los respectivos ritmos para usar los maps
float minr1 = 87, maxr1 = 91, minr2 = 55, maxr2 = 73, minr3 = 60, maxr3 = 85, minr3b = 89, maxr3b = 89.5, minVoice = 76, maxVoice = 86;

//paletas de colores, el orden es segun la rueda cromatica
color[] tonoVerde = {#00E00F, #01FA10, #00AD0C, #006B07};
color[] tonoAzul = {#003EFA, #0038E0, #002BAD, #001C70};
color[] tonoMorado = {#C800FA, #B400E0, #8B00AD, #61007A};
color[] tonoRojo = {#FA0008, #E00007, #AD0006, #700105};
color[] tonoNaranja = {#FA5700, #E04F00, #AD3D00, #752800}; 
color[] tonoAmarillo = {#FAEE01, #E0D500, #ADA500, #7A7401};
color[] blancos = {#FFFFFF, #FAFAFA, #F5F5F5, #F0F0F0};
//se cambia el orden para afectar la escala de color o hacer un monocromatico
//color[] colores = tonoAzul;

//triada 
color[] triada1 = concat(concat(tonoRojo, tonoNaranja), tonoAmarillo);
color[] triada2 = concat(concat(tonoVerde, tonoAzul), tonoMorado);

//escala total
color[] colores1 = {#00E00F, #01FA10, #00AD0C, #006B07, #003EFA, #0038E0, #002BAD, #001C70, #C800FA, #B400E0, #8B00AD, #61007A, #FA0008, #E00007, #AD0006, #700105, #FA5700, #E04F00, #AD3D00, #752800, #FAEE01, #E0D500, #ADA500, #7A7401};
color[] colores2 = {#003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A};
color[] colores3 = {#FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07};
color[] colores4 = {#C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105};
color[] colores5 = {#FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800};
color[] colores6 = {#00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70};

ArrayList <color[]> paletasDeColores = new ArrayList<color[]>();

//color inicial
color[] colores;
int indexInitColor = 0;

color tono;
float amplitud;
float tonalidadInf, tonalidadSup;
float r,g,b;

//variables para el mandala
int pointCounter;
float innerRadius, outerRadius;
float innerRadiusFactos;
float innerRadiusRatio;
float outerRadiusRatio;
int steps;
float rotationRatio;
float shadeRatio;
float innerRadiusFactor;
float ellipseSize = 670;

float angle = 0.0;

//Variables background lineas
float angleBackground = 0, angleBackground2 = PI;
float angleSpeed = 0.05;
float lineLength = 40;
float lineWidth = 20;
float strokeColor = 255;
float x, y, x2, y2,x3, y3;
int count = 0;
color colorLinea = 0, colorLinea2 = 0, colorLinea3 = 0;

//variables backgroundPunteado
ArrayList <PVector> positions = new ArrayList<PVector>(); 
BackgroundPoints bg;
int bgGrid = 21;
float v = 0.0;
float noiseInc = 0.02;
float v2 = -10;
int numCancion = 0;

void setup(){
  //fullScreen(P2D);
  size(1280,1000, P2D); 
  frameRate(60);
  background(0);
  
   //adicion de paletas de colores
  paletasDeColores.add(blancos);
  
  //definir color incial
  colores = paletasDeColores.get(indexInitColor);

  // Introducimos el OSC
  OscP5 oscP5 = new OscP5(this, 11111);
  
  ////empezamos con el fondo creando una matriz, esta es util para los dos fondos
  bg = new BackgroundPoints(bgGrid);
  
}

// Eventos leídos desde PD
void oscEvent(OscMessage theOscMessage){
  println("###received an osc message");
  println(" addrpattern: " + theOscMessage.addrPattern());
  if(theOscMessage.checkAddrPattern("/ritmo1")){
    // Revisar si está activo el ritmo
    ritmo1 = constrain(theOscMessage.get(0).floatValue(),minr1, maxr1);
  
  } else if(theOscMessage.checkAddrPattern("/ritmo2")){
    ritmo2 = constrain(theOscMessage.get(0).floatValue(),minr2,maxr2);
    
  } else if(theOscMessage.checkAddrPattern("/ritmo3")){
      ritmo3 = constrain(theOscMessage.get(0).floatValue(),minr3,maxr3);
    
  } else if(theOscMessage.checkAddrPattern("/ritmo3b")){
      ritmo3b = constrain(theOscMessage.get(0).floatValue(),minr3b,maxr3b);
      
  } else if(theOscMessage.checkAddrPattern("/puntas")){
     puntas =  theOscMessage.get(0).floatValue();
  } else if(theOscMessage.checkAddrPattern("/voice")){
     voice = constrain(theOscMessage.get(0).floatValue(),minVoice,maxVoice);
     
  }
}


void draw() {

  //background de circulos llevados por el ritmo 3
  
  Hanabi hb = new Hanabi(ritmo3);
  Hanabi hb2 = new Hanabi(ritmo3);
  Hanabi hb3 = new Hanabi(ritmo3);
  
  // background de lineas activado por la señal voice
  if (voice > minVoice){
    backGroundLines();
  }

  
  //la tercera será una mezcla de ambos noise
  float hbPosX = positions.get(int(noise(v) *positions.size())).x;
  float hbPosX2 = positions.get(int(noise(v2) *positions.size())).x;
  v += noiseInc;
  v2 += noiseInc;
  float hbPosY = positions.get(int(noise(v) *positions.size())).y;
  float hbPosY2 = positions.get(int(noise(v2) *positions.size())).y;
  
  //Para que no todas vayan vertical invertimos x y y
  hb.drawHanabi(hbPosX,hbPosY, colores[int(random(colores.length))]);
  hb2.drawHanabi(hbPosY2,hbPosX2, colores[int(random(colores.length))]);
  hb3.drawHanabi(hbPosX2,hbPosY, colores[int(random(colores.length))]);
  bg.drawBg(positions);
  
  //este circulo es para dar efecto de difumninado, por eso es importante el alpha, su tamaño debe ser igual al maximo alcanzado por el mandala
  fill(0, 50);
  noStroke();
  //Para los fondos y efectos de este
  rectMode(CENTER);
  rect(width/2,height/2, width, height);
  fill(0, 25);
  circle(width/2,height/2, ellipseSize);
  
  //llevamos siempre la figura al centro
  translate(width/2, height/2);
  //rotacion de la figura
  rotate(angle);
  //velocidad de rotacion, ritmo base (ritmo1)
  angle += map(ritmo1, minr1, maxr1, 0, 0.15);
  
  // La que llevará la amplitud de la estrella es el ritmo 2 y el ritmo3b su rotación interna
  amplitud = ritmo2;
  
  //dibujo mandala
  mandala();


}
