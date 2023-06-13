class Snake{
  // Puntos para la linea serpiente
  ArrayList<PVector> points = new ArrayList<PVector>(); // arreglo de vectores para almacenar los puntos
  boolean isActive;
  
  Snake(){
    points = new ArrayList<PVector>();
    isActive = true;
    
    // Calcular los puntos para formar una curva de bezier aleatoria
    // Punto x
    float curvax1 = random(300, width-300);
    float curvax2 = random(300, width-300);
    
    float controlx1 = random(width);
    float controly1 = random(height);
    float controlx2 = random(width);
    float controly2 = random(height);
    
    // Punto y
    float curvay1 = random(300, height-300);
    float curvay2 = random(300, height-300);
    
    //Distancia entre dos puntos
    float dx = curvax1 - curvay1;
    float dy = curvay1 - curvay2;
    float distance = (float)Math.sqrt(dx*dx + dy*dy);
    
    // Calcular puntos segun distancia
    int n = int(map(distance, 0, width-300, 5, 25));
    
      for(int i = 0; i < n; i++){
        float t = map(i, 0, n-1, 0, 1);
        float x = bezierPoint(curvax1, controlx1, controlx2, curvax2, t);
        float y = bezierPoint(curvay1, controly1, controly2, curvay2, t);
        points.add(new PVector(x, y));
    }
  }
  
  public ArrayList<PVector> getPoints(){
    return points;
  }
  
  public boolean getIsActive(){
    return isActive;
  }
  
  public void setIsActive(boolean value){
    isActive = value;
  }
}
