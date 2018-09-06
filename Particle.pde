class Particle {

  PVector velocity;
  float lifespan = 255;
  
  PShape part;
  float partSize;
  color partColor;

  
  
  PVector gravity = new PVector(0,0.1);


  Particle(int x, int y, int c) {
    //partColor = color(random(0,255),random(0,255),random(0,255));
    partSize = random(5,12);
    //part=createShape(RECT, 0, 0, partSize, partSize);
    part=createShape(ELLIPSE, -15, 0, partSize, partSize);
    
 
    part.setFill(c);
    
    //rebirth(width/2,height/2);
    rebirth(x,y, c);
    lifespan = random(255);
    //lifespan = 0;
  }

  PShape getShape() {
    return part;
  }
  
  void rebirth(float x, float y, color c) {
    float a = random(TWO_PI);
    float speed = random(0.5,4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.setFill(c);
    part.resetMatrix();
    part.translate(x, y); 
  }
  
  boolean isDead() {
    if (lifespan < 0) {
     return true;
    } else {
     return false;
    } 
  }
  

  public void update() {
    lifespan = lifespan - 1;
    velocity.add(gravity);
    
    //part.setTint(color(255,lifespan));
    part.translate(velocity.x, velocity.y);
  }
}
