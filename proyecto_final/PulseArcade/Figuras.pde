class Cuadrado{
  float posx, posy;
  color figureColor1;
  color figureColor2;
  
  Cuadrado(float x, float y, color c1, color c2){
    posx = x;
    posy = y;
    figureColor1 = c1;
    figureColor2 = c2;
  }
  
  void drawCuadrado(){
    pushMatrix();
    rectMode(CENTER);
    stroke(figureColor1, 55);
    strokeWeight(4);
    noFill();
    rect(posx, posy, 25, 20);
    //stroke(figureColor2, 55);
    //rect(posx, posy, 15, 10);
    popMatrix();
  }
}

class Triangulo{
  float posx, posy;
  color figureColor1;
  color figureColor2;
  int size1 = 10;
  int size2 = 7;
  
  Triangulo(float x, float y, color c1, color c2){
    posx = x;
    posy = y;
    figureColor1 = c1;
    figureColor2 = c2;
  }
  
  void drawTriangulo(){
    pushMatrix();
    stroke(figureColor1, 55);
    strokeWeight(4);
    noFill();
    triangle(posx, posy+size1, posx+size1, posy-size1, posx-size1, posy-size1);
    //stroke(figureColor2, 55);
    //triangle(posx, posy+size2, posx+size2, posy-size2, posx-size2, posy-size2);
    popMatrix();
  }
}


class Circulo{
  float posx, posy;
  color figureColor1;
  color figureColor2;
  int size1 = 20;
  Circulo(float x, float y, color c1, color c2){
    posx = x;
    posy = y;
    figureColor1 = c1;
    figureColor2 = c2;
  }
  
  void drawCirculo(){
    pushMatrix();
    stroke(figureColor1, 55);
    strokeWeight(5);
    noFill();
    circle(posx, posy, size1);
    popMatrix();
  }
}

class Cruz{
  float posx, posy;
  color figureColor;
  int size = 10;
  
  Cruz(float x, float y, color c){
    posx = x;
    posy = y;
    figureColor = c;
  }
  
  void drawCruz(){
    pushMatrix();
    stroke(figureColor, 55);
    strokeWeight(5);
    noFill();
    line(posx-size, posy+size, posx+size, posy-size);
    line(posx+size, posy+size, posx-size, posy-size);
    popMatrix();
  }
}

class Curva{
  float posx, posy;
  color figureColor1;
  color figureColor2;
  int size = 15;
  
  Curva(float x, float y, color c1, color c2){
    posx = x;
    posy = y;
    figureColor1 = c1;
    figureColor2 = c2;
  }
  
  void drawCurva(){
    pushMatrix();
    stroke(figureColor2, 55);
    strokeWeight(5);
    noFill();
    bezier(posx-size, posy, posx-size/2, posy-size, posx+size/2, posy+size,posx+size, posy);
    stroke(figureColor1, 80);
    bezier(posx-size-3, posy-3, posx-size/2, posy-size, posx+size/2, posy+size,posx+size-3, posy-3);
    popMatrix();
  }
  
}

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
  
  public Rectangulo(float x, float y, float ancho, float alto, PImage s) {
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
    this.sprite = playerBlock;
    this.sprite = s;
  }
}

class BGStar{
  float posx, posy;
  float size;
  
  BGStar(float x, float y){
    posx = x;
    posy = y;
    size = random(-5, 6);
  }
  
  void drawBGStar(){
    if (size > 3){
      pushMatrix();
      fill(color(255, 255, 255));
      noStroke();
      circle(posx, posy, size);
      popMatrix();
    }
  }
}
