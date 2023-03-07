import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Global variables
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
int indexInitColor = 8;


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
  fullScreen(P2D);
  //size(width,height, P2D); 
  frameRate(60);
  background(0);
  
  //adicion de paletas de colores
  paletasDeColores.add(tonoAmarillo);
  paletasDeColores.add(tonoNaranja);
  paletasDeColores.add(tonoRojo);
  paletasDeColores.add(tonoMorado);
  paletasDeColores.add(tonoAzul);
  paletasDeColores.add(tonoVerde);
  paletasDeColores.add(triada1);
  paletasDeColores.add(triada2);
  paletasDeColores.add(colores1);
  paletasDeColores.add(colores2);
  paletasDeColores.add(colores3);
  paletasDeColores.add(colores4);
  paletasDeColores.add(colores5);
  paletasDeColores.add(colores6);

  //definir color incial
  colores = paletasDeColores.get(indexInitColor);
  
  //Aqui se cambia la pista
  minim = new Minim(this);
  player = minim.loadFile("song4.mp3");
  player.play();
  
  ////empezamos con el fondo creando una matriz, esta es util para los dos fondos
  bg = new BackgroundPoints(bgGrid);
  
}

void draw() {
  
  //dibujamos el background
  backGroundLines();
  
  //este circulo es para dar efecto de difumninado, por eso es importante el alpha, su tamaño debe ser igual al maximo alcanzado por el mandala
  fill(0, 50);
  noStroke();
  //Para el fondo y efectos
  rectMode(CENTER);
  rect(width/2,height/2, width, height);
  fill(0);
  circle(width/2,height/2, ellipseSize);
  
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

void keyReleased() {
  //Cambio de color

  if (key == CODED){
    if (keyCode == LEFT){
      if (indexInitColor > 0)
      {
        indexInitColor -= 1;
      } else
      {
        indexInitColor = paletasDeColores.size() - 1;
      }
    }else if (keyCode == RIGHT){
      if (indexInitColor < paletasDeColores.size() - 1)
      {
        indexInitColor += 1;
      } else
      {
        indexInitColor = 0;
      }
    }
  }
  
  //definir color
  colores = paletasDeColores.get(indexInitColor);

}
