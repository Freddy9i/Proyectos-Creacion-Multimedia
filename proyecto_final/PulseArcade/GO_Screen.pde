void drawGOScreen(){
  String texto = "GAME OVER";
  String puntos = "SCORE: " + score.puntos;
  
  // Botones de la pantalla
  btn0.setVisible(true);
  btn0.setLocalColor(4, d5);
  btn0.setLocalColor(2, d4);
  btn0.setLocalColor(3, d5);
  btn0.setTextBold();
  btn0.addEventHandler(this, "handleBtn0");
  
  setGradient(int(offsetw), int(offseth), sWidth, sHeight, d1, d2, Y_AXIS);
  noFill();
  stroke(color(0,0,0));
  strokeWeight(5);
  rectMode(CENTER);
  rect(width/2, height/2, sWidth, sHeight);
  
  // Figuras de fondo
  for (int i = 0; i < fPos.size() ; i ++){
    drawRandomFigure(fPos.get(i), fType.get(i));
  }
  
  // Letra de la pantalla
  textAlign(CENTER, CENTER);
  textSize(240);
  textFont(scoreFont);
  fill(d2);
  text(texto, width/2-7, height/2-7);
  fill(d1);
  text(texto, width/2+5, height/2);
  fill(d4);
  text(texto, width/2, height/2);
  fill(d1);
  textSize(60);
  text(puntos, width/2, height/2 + 100);
  

  
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

void drawRandomFigure(PVector pos, int r){
  color figureC1;
  color figureC2;
  if (r == 1){
    figureC1 = d[0];
    figureC2 = d[5];
    Cuadrado cuadrado = new Cuadrado(pos.x, pos.y, figureC1, figureC2);
    cuadrado.drawCuadrado();
  } else if(r == 2){
    figureC1 = d[4];
    figureC2 = d[3];
    Triangulo triangulo = new Triangulo(pos.x, pos.y, figureC1, figureC2);
    triangulo.drawTriangulo();
  } else if(r == 3){
    figureC1 = d[2];
    figureC2 = d[1];
    Circulo circulo = new Circulo(pos.x, pos.y, figureC1, figureC2);
    circulo.drawCirculo();
  } else if(r == 4){
    figureC1 = d[3];
    figureC2 = d[1];
    Cruz cruz = new Cruz(pos.x, pos.y, figureC1);
    cruz.drawCruz();
  } else {
    figureC1 = d[2];
    figureC2 = d[5];
    Curva curva = new Curva(pos.x, pos.y, figureC1, figureC2);
    curva.drawCurva();
  }
}
