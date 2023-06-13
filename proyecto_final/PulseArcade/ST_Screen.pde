void drawSTScreen(){
  String texto1 = "PULSE";
  String texto2 = "ARCADE";
  float posT1 = -100;
  float posT2 = 50;
  
  btn1.setVisible(true);
  btn1.setLocalColor(4, d3);
  btn1.setLocalColor(2, d4);
  btn1.setLocalColor(3, d2);
  btn1.setTextBold();
  btn1.addEventHandler(this, "handleBtn1");
  btn2.setVisible(true);
  btn2.setLocalColor(4, d3);
  btn2.setLocalColor(2, d4);
  btn2.setLocalColor(3, d2);
  btn2.setTextBold();
  btn2.addEventHandler(this, "handleBtn2");
  btn3.setVisible(true);
  btn3.setLocalColor(4, d2);
  btn3.setLocalColor(2, d4);
  btn3.setLocalColor(3, d3);
  btn3.setTextBold();
  btn3.addEventHandler(this, "handleBtn3");
  
  fill(color(10,10,10));
  noStroke();
  rectMode(CENTER);
  rect(width/2, height/2, sWidth, sHeight);
  stroke(color(255,255,255));
  strokeWeight(5);
  rect(width/2, height/2, sWidth, sHeight);
  
  // Figuras de fondo
  for (int i = 0; i < fPos.size() ; i ++){
    drawRandomFigure(fPos.get(i), fType.get(i));
  }
  
  // Luces de fondo
  for(int i = 0; i < bgStars.size(); i ++){
    bgStars.get(i).drawBGStar();
  }
  
  // Letra de la pantalla
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(-4));
  textAlign(CENTER, CENTER);
  // Texto 1
  textFont(scoreFont);
  textSize(100);
  fill(d2);
  text(texto1, posT1-7, 0-70);
  fill(d1);
  text(texto1, posT1+5, 0-70);
  fill(d4);
  text(texto1, posT1, 0-70);
   
  // Texto 2
  textSize(120);
  fill(d2);
  text(texto2, posT2-7, 0);
  fill(d1);
  text(texto2, posT2+5, 0);
  fill(d4);
  text(texto2, posT2, 0);
  popMatrix();
}
