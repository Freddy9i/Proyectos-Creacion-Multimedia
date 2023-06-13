class Score{
  int puntos;
  float posX, posY;
  int puntosRacha;
  int racha;
  int rachaMax = 5;
  char rachaTexto;
  color[] tonosRacha;
  
  Score(float x, float y){
    puntos = 0;
    puntosRacha = 0;
    racha = 1;
    posX = x;
    posY = y;
    rachaTexto = 'D';
    tonosRacha = tonoAzul;
  }
  
  void drawScore(){
    // Letra del activador
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(120);
    textFont(scoreFont);
    
  // Crea el gradiente lineal
  //fill(tonoMorado[int(map(puntosRacha, 0, rachaMax, 0, 4))]);
  text(rachaTexto, posX, posY);
  text(puntosRacha, posX, posY+100);
  }
  
  void acierto(){
    puntos += racha;
    if(puntosRacha == rachaMax){
      subirRacha();
    } else{
      puntosRacha += 1;
    }
  }
  
  void perderRacha(){
    rachaTexto = 'D';
    puntosRacha = 0;
  }
  
  void subirRacha(){
    if(rachaTexto != 'S'){
      switch(rachaTexto){
        case 'D':
          rachaTexto = 'C';
          racha = 2;
          break;
        case 'C':
          rachaTexto = 'B';
          racha = 3;
          break;
        case 'B':
          rachaTexto = 'A';
          racha = 4;
          break;
        case 'A':
          rachaTexto = 'S';
          racha = 5;
          break;
        default:
          rachaTexto = 'S';
      }
        puntosRacha = 0;
    }
  }
}
