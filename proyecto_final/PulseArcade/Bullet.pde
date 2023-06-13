class Bullet{
  float posx, posy;
  PImage sprite;
  
  Bullet(float x, float y, PImage s){
    posx = x;
    posy = y;
    sprite = s;
  }
  
  void drawBullet(){
    imageMode(CENTER);
    image(sprite, posx, posy);
  }
}

class BulletEnemy extends Bullet{
  
  PImage sprite = enemyBullet;
  
  BulletEnemy(float x, float y, PImage s){
    super(x, y, s);
  }
}

void drawBullets(){
  for (int i = 0; i < proyectiles.size(); i++) {
    Bullet proyectil = proyectiles.get(i);
    proyectil.drawBullet();
    proyectil.posx += 20; // Mueve el proyectil hacia la derecha
    
    // Verifica si el proyectil llega al final de la pantalla
    if (proyectil.posx > width) {
      proyectiles.remove(i); // Elimina el proyectil de la lista si llega al final
    }
    
    // Verificar si el proyectil impactó con algun enemigo
    if(bulletCollision(proyectil, enemyShip1, proyectil.posx, proyectil.posy, enemyShip1.x, enemyShip1.y) && enemyShip1.alive){
      proyectiles.remove(i);
      enemyShip1.impact();
    }
    
    if(bulletCollision(proyectil, enemyShip2, proyectil.posx, proyectil.posy, enemyShip2.x, enemyShip2.y) && enemyShip2.alive){
      proyectiles.remove(i);
      enemyShip2.impact();
    }
    
    if(bulletCollision(proyectil, enemyShip3, proyectil.posx, proyectil.posy, enemyShip3.x, enemyShip3.y) && enemyShip3.alive){
      proyectiles.remove(i);
      enemyShip3.impact();
    }
  }
}

void drawEnemyBullets(){
  for (int i = 0; i < enemyProyectiles.size(); i++) {
    BulletEnemy proyectil = enemyProyectiles.get(i);
    proyectil.drawBullet();
    proyectil.posx -= 20; // Mueve el proyectil hacia la derecha
    
    // Verifica si el proyectil llega al final de la pantalla
    if (proyectil.posx < 0) {
      enemyProyectiles.remove(i); // Elimina el proyectil de la lista si llega al final
    }
    
    // Verificar su el proyectil impacta en el player
    
    if(bulletCollision(proyectil, nave, proyectil.posx, proyectil.posy, nave.x, nave.y)){
      nave.impact();
      enemyProyectiles.remove(i);
    }
  }
}

boolean bulletCollision(Bullet bullet, EnemyShip target, float bulletX, float bulletY, float targetX, float targetY) {
  // Obtener las coordenadas y dimensiones de los objetos
  float bulletx = bulletX;
  float bullety = bulletY;
  float bulletRadio = bullet.sprite.width-40;
  
  float targetx = targetX;
  float targety = targetY;
  float targetRadio = target.sprite.width - 20;
  
  // Visualización del collider
  //pushMatrix();
  //strokeWeight(3);
  //noFill();
  //rectMode(CENTER);
  //rect(x1, y1, obj1Ancho, obj1Alto);
  //rect(x2, y2, obj2Ancho, obj2Alto);
  //popMatrix();
  
  // Verificar si los circulos delimitadores se superponen con la distancia, NO CAMBIAR ESTE CONDICIONAL 
  if (dist(bulletx, bullety, targetx, targety) <= targetRadio/2) {
    return true; // Hay colisión
  } else {
    return false; // No hay colisión
  }
}

boolean bulletCollision(Bullet bullet, Ship target, float bulletX, float bulletY, float targetX, float targetY) {
  // Obtener las coordenadas y dimensiones de los objetos
  float bulletx = bulletX;
  float bullety = bulletY;
  float bulletRadio = bullet.sprite.width-40;
  
  float targetx = targetX;
  float targety = targetY;
  float targetRadio = target.sprite.width - 20;
  
  // Visualización del collider
  //pushMatrix();
  //strokeWeight(3);
  //noFill();
  //rectMode(CENTER);
  //rect(x1, y1, obj1Ancho, obj1Alto);
  //rect(x2, y2, obj2Ancho, obj2Alto);
  //popMatrix();
  
  // Verificar si los circulos delimitadores se superponen con la distancia, NO CAMBIAR ESTE CONDICIONAL 
  if (dist(bulletx, bullety, targetx, targety) <= targetRadio/2) {
    return true; // Hay colisión
  } else {
    return false; // No hay colisión
  }
}
