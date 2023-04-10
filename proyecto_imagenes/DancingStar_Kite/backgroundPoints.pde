
class BackgroundPoints{
  
  BackgroundPoints(int grid){
    float ang = 0;
    float angRot = TWO_PI/grid;
    for (int i = grid; i < width; i += width/grid){
      for (int j = grid; j < height; j += height/grid){
        //averiguo si el cuadro hace parte del circulo con la distancia euclidiana
        float d2 = (i - width/2)*(i - width/2) + (j - height/2)*(j - height/2);
        if (sqrt(d2) > ellipseSize/2){
          positions.add(new PVector(i, j));
        } 
      }
      ang += angRot;
    }
  }
  
  void drawBg(ArrayList<PVector> pos){
    for (int i = 0; i < pos.size(); i++){
      noFill();
      stroke(255,100);
      strokeWeight(2);
      rectMode(CENTER);
      square(pos.get(i).x,pos.get(i).y ,5);
    }
  }
  

}
