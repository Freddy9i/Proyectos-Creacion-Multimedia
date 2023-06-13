PVector[] points;
int numPoints = 500;

void setup() {
  size(400, 400);
  stroke(0);
  noFill();
  
  points = new PVector[numPoints];
  for (int i = 0; i < numPoints; i++) {
    float t = map(i, 0, numPoints-1, 0, 1);
    float x = bezierPoint(50, 100, 300, 350, t);
    float y = (100, 50, 300, 250, t);
    points[i] = new PVector(x, y);
  }
}

void draw() {
  background(255);
  
  beginShape();
  for (PVector p : points) {
    vertex(p.x, p.y);
  }
  endShape();
}
