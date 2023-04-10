class Hanabi{
  float hanabiSize; 
  
  Hanabi(float amp){
    //tamaño para estrellas
    //hanabiSize = map(amp,0,0.35, 0,60);
    
    //tamaño para circulos
    hanabiSize = map(amp,0,0.35, 0,100);
  }
  
  void drawHanabi(float posX, float posY, color hanabiCol){
    for(int i = 4; i > 0; i--){
      strokeWeight(0.5);
      stroke(hanabiCol);
      fill(hanabiCol, 80);
      //formas de circulo
      circle(posX, posY, hanabiSize/i);
      
      //formas de estrella
      //pushMatrix();
      //translate(posX,posY);
      //rotate(-0.25);
      //star(5, hanabiSize*0.5-(hanabiSize*0.7/4)*i, hanabiSize-(hanabiSize/4)*i);
      //popMatrix();
    }
  }

}
