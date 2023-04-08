void backGroundLines(){
  stroke(colorLinea);
  strokeJoin(BEVEL);
  strokeWeight(lineWidth);
  line(x, y, x + cos(angleBackground) * lineLength, y + sin(angleBackground) * lineLength);
  stroke(colorLinea2);
  line(x2, y2, x2 - cos(angleBackground) * lineLength, y2 - sin(angleBackground) * lineLength);
  stroke(colorLinea3);
  line(x3, y3, x3 + cos(angleBackground2) * lineLength, y3 + sin(angleBackground2) * lineLength);
  
  
  if (count %30 == 0){
    //para aclarar un poco el fondo fondo
    fill(0, 80);
    noStroke();
    rect(0,0, width, height);
  }
  
  x += cos(angleBackground) * lineLength;
  y += sin(angleBackground) * lineLength;
  x2 -= cos(angleBackground) * lineLength;
  y2 -= sin(angleBackground) * lineLength;
  x3 += cos(angleBackground2) * lineLength;
  y3 += sin(angleBackground2) * lineLength;
  angleBackground += random(0.03, 0.08);
  angleBackground2 += random(0.03, 0.08);
  
  

  if (x < 0 || x > width || y < 0 || y > height) {
    //x = random(width/3,2*width/3);
    //y = random(height/3,2*height/3);
    x = positions.get(int(random(positions.size()))).x;
    y = positions.get(int(random(positions.size()))).y;
    angleBackground = random(TWO_PI);
    colorLinea = colores[int(random(colores.length))];
    //colorLinea = 125;
  }
  
  if (x2 < 0 || x2 > width || y2 < 0 || y2 > height) {
    x2 = random(width/3,2*width/3);
    y2 = random(height/3,2*height/3);
    //angleBackground2 = random(TWO_PI);
    colorLinea2 = colores[int(random(colores.length))];
    //colorLinea2 = 125;
  }
  if (x3 < 0 || x3 > width || y3 < 0 || y3 > height) {
    x3 = random(width/3,2*width/3);
    y3 = random(height/3,2*height/3);
    angleBackground2 = random(TWO_PI);
    colorLinea3 = colores[int(random(colores.length))];
    //colorLinea2 = 125;
  }
  count++;
  
  if (lineWidth <= 0){
    lineWidth = 6;
  }
  if (count >= 500) {
    count = 0;
  }
}
