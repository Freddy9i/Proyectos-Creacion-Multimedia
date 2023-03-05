import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Global variables
FFT fft;
Minim minim;  
AudioPlayer player;

//paletas de colores, el orden es segun la rueda cromatica
color[] tonoVerde = {#00E00F, #01FA10, #00AD0C, #006B07};
color[] tonoAzul = {#003EFA, #0038E0, #002BAD, #001C70};
color[] tonoMorado = {#C800FA, #B400E0, #8B00AD, #61007A};
color[] tonoRojo = {#FA0008, #E00007, #AD0006, #700105};
color[] tonoNaranja = {#FA5700, #E04F00, #AD3D00, #752800}; 
color[] tonoAmarillo = {#FAEE01, #E0D500, #ADA500, #7A7401};
//se cambia el orden para afectar la escala de color o hacer un monocromatico
//color[] colores = tonoRojo;

//triada 
//color[] colores = concat(concat(tonoRojo, tonoNaranja), tonoAmarillo);
//color[] colores = concat(concat(tonoVerde, tonoAzul), tonoMorado);

//escala total
color[] colores = {#00E00F, #01FA10, #00AD0C, #006B07, #003EFA, #0038E0, #002BAD, #001C70, #C800FA, #B400E0, #8B00AD, #61007A, #FA0008, #E00007, #AD0006, #700105, #FA5700, #E04F00, #AD3D00, #752800, #FAEE01, #E0D500, #ADA500, #7A7401};
//color[] colores = {#003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A};
//color[] colores = {#FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07};
//color[] colores = {#C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105};
//color[] colores = {#FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70, #00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800};
//color[] colores = {#00E00F, #01FA10, #00AD0C, #006B07, #FAEE01, #E0D500, #ADA500, #7A7401, #FA5700, #E04F00, #AD3D00, #752800, #FA0008, #E00007, #AD0006, #700105, #C800FA, #B400E0, #8B00AD, #61007A, #003EFA, #0038E0, #002BAD, #001C70};
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
int bgGrid = 20;
float v = 0.0;
float noiseInc = 0.02;
float v2 = -10;


void setup(){
  size(1080,1080, P2D); 
  frameRate(60);
  background(0);

  //Aqui se cambia la pista
  minim = new Minim(this);
  player = minim.loadFile("song3.mp3");
  player.play();
  
  ////empezamos con el fondo creando una matriz, esta es util para los dos fondos
  bg = new BackgroundPoints(bgGrid);
  
}

void draw() {
  
  //dibujamos el background
  //backGroundLines(amplitud);
  
  //background de circulos
  
  Hanabi hb = new Hanabi(amplitud);
  Hanabi hb2 = new Hanabi(amplitud);
  Hanabi hb3 = new Hanabi(amplitud);
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
  //Para el fondo hanabi
  rectMode(CENTER);
  rect(width/2,height/2, width, height);
  //Para el fondo lineas
  //circle(width/2,height/2, ellipseSize);
  
  //llevamos siempre la figura al centro
  translate(width/2, height/2);
  //rotacion de la figura
  rotate(angle);
  //velocidad de rotacion
  angle += map(amplitud, 0,0.35, 0,0.15);
  
  //Principal imput de música, nos aseguramos que no pase de 0.35, jugar entre 0.0 y 0.35 para variar
  amplitud = constrain(player.mix.level(),0.0,0.35);
  
  //dibujo mandala
  mandala();
}
