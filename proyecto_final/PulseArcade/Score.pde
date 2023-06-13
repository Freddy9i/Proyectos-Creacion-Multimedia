class Score{
  int puntos;
  float posX, posY;
  
  Score(float x, float y){
    puntos = 0;
    posX = x;
    posY = y;
  }
  
  void drawScore(){
    // Letra del activador
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(120);
    textFont(scoreFont);
    text(puntos, posX, posY + 50);
  }
  
  void acierto(){
    puntos += 1;
  }
  
  void setPuntos(int p){
    puntos = p;
  }
}
