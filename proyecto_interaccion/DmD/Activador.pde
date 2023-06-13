class Activador{
  float outSize;
  float activadorSize;
  color actColor;
  float posX, posY;
  float speed = 3;
  char[] actButtons = {'A', 'W', 'D'};
  char button;
  
  Activador(float x, float y){
    outSize = 300;
    activadorSize = outSize/2;
    actColor = color(255,255,255);
    posX = x;
    posY = y;
    button = actButtons[int(random(0,3))];
  }
  
  
  void drawActivador(){
    strokeWeight(2);
    stroke(actColor);
    noFill();
    circle(posX, posY, this.outSize);
    if(outSize > 0){
      outSize -= speed;
    }
    fill(actColor,25);
    circle(posX, posY, activadorSize);
    
    // Letra del activador
    fill(255, 255, 255);
    textAlign(CENTER, CENTER);
    textSize(60);
    textFont(activatorFont);
    //text(button, posX, posY);
    text("V", posX, posY);
  }
  
  
  void active(){
    
    if(outSize > activadorSize || outSize == 0){
      actColor = color(255,0,0);
    } else {
      actColor = color(0,255,0);
    }
  }
  
  // Metodo para hacerlo con teclas
  boolean nice(char buttonPressed){ 
    // Comprobamos que el mouse entre en el circulo y sea el boton
    float d = dist(mouseX, mouseY, posX, posY);
    if (d < activadorSize && button == Character.toUpperCase(buttonPressed)){
      return true;
    } else {
      return false;
    }
  }
  
  // Metodo para hacerlo con el mouse
  boolean nice(){
    // Comprobamos que el mouse entre en el circulo
    float d = dist(mouseX, mouseY, posX, posY);
    if (d < activadorSize && outSize < activadorSize){
      return true;
    } else {
      return false;
    }
  }
  
  
  void deactive(){
    actColor = color(255,255,255);
  }
  
  boolean fail(){
    if(outSize == 0 || outSize < 0){
      return true;
    } else{
      return false;
    }
  }
}
