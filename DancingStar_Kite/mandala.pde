
void mandala(){
  
  //cantidad de estrellas del mandala
  steps = int(map(amplitud, 0,0.35,10,60));
  shadeRatio = 255 / steps;
  //este angulo de rotacion para el dibujo del mandala tambien puede variar con la amplitud
  rotationRatio = map(amplitud, 0,0.35, 0,90)/ steps;
  
  
  //variables de la forma de la estrella según el sonido
  pointCounter = 8;
  outerRadius = map(amplitud,0,0.35,300,350);
  innerRadiusFactor=  map(amplitud,0,0.35,0.5, 0.8);
  //innerRadius = map(amplitud,0,0.35,150,width/3);
  innerRadius = outerRadius * innerRadiusFactor;
  
  //Las radiusRatio son para lograr el efecto espiral del mandalas, encogen los tamaños
  innerRadiusRatio = innerRadius / steps;
  outerRadiusRatio = outerRadius / steps;
  
  tono = int(map(amplitud,0,0.35,20,40));
  
  //se dibuja el mandala
  for(int i = 0; i < steps; i++){
    stroke(0 + shadeRatio * i, 100);
    strokeWeight(5);
    //amplia la gama de colores en base a la amplitud, a mas ampliud más gama, la gama se reduce si nos acercamos a la longitud de la lista, por eso es inverso
    float ampGama = int(map(amplitud,0,0.35,colores.length-1,1));
    
    color colorStar = colores[int(map(i,0,steps,ampGama, colores.length-1))];
    fill(colorStar, tono);
    pushMatrix();
    rotate(rotationRatio * i * PI / 90);
    //de grande a pequeña
    star(pointCounter, innerRadius-innerRadiusRatio*(i), outerRadius-outerRadiusRatio*(i));
    //de pequeña a grande
    //star(pointCounter, innerRadius-innerRadiusRatio*(steps-i), outerRadius-outerRadiusRatio*(steps-i));
    popMatrix();
  }
}
