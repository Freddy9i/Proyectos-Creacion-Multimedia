
void mandala(){
  
  //cantidad de estrellas del mandala
  steps = int(map(amplitud, minr2,maxr2,10,50));
  shadeRatio = 255 / steps;
  //este angulo de rotacion para el dibujo del mandala tambien puede variar con la amplitud
  rotationRatio = map(ritmo3b, minr3b,maxr3b, 0,90)/ steps;
  
  
  //variables de la forma de la estrella según el sonido
  pointCounter = int(puntas);
  outerRadius = map(amplitud, minr2,maxr2,300,350);
  innerRadiusFactor=  map(amplitud, minr2,maxr2,0.5, 0.8);
  //innerRadius = map(amplitud,0,0.35,150,width/3);
  innerRadius = outerRadius * innerRadiusFactor;
  
  //Las radiusRatio son para lograr el efecto espiral del mandalas, encogen los tamaños
  innerRadiusRatio = innerRadius / steps;
  outerRadiusRatio = outerRadius / steps;
  
  tono = int(map(amplitud,minr2,maxr2,20,40));
  
  //se dibuja el mandala
  for(int i = 0; i < steps; i++){
    stroke(0 + shadeRatio * i, 100);
    strokeWeight(5);
    //amplia la gama de colores en base a la amplitud, a mas ampliud más gama, la gama se reduce si nos acercamos a la longitud de la lista, por eso es inverso
    // float ampGama = int(map(amplitud,minr2,minr2,colores.length-1,1));
    // color colorStar = colores[int(map(i,0,steps,ampGama, colores.length-1))]; 
    
    fill(blancos[0], tono);
    pushMatrix();
    rotate(rotationRatio * i * PI / 90);
    //de grande a pequeña
    star(pointCounter, innerRadius-innerRadiusRatio*(i), outerRadius-outerRadiusRatio*(i));
    //de pequeña a grande
    //star(pointCounter, innerRadius-innerRadiusRatio*(steps-i), outerRadius-outerRadiusRatio*(steps-i));
    popMatrix();
  }
}
