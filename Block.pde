class Block {

  float Bx;
  float By;
  //PVector BBraking;
  PVector BVelocity;
  PVector BPos;
  Block(float x, float y) {
    Bx=x;
    By=y;
    BPos=new PVector(x,y);
    //BVelocity = new PVector(0,0);
  }


  void show() {
    stroke(0);
    fill(255);
    rect(BPos.x, BPos.y, scl, scl);
  }
  
  float getBlockX() {
   
    return BPos.x;
  }
  
   float getBlockY() {
   
    return BPos.y;
  }
  
  void move(float xspeed, float yspeed) {
    
    BVelocity = new PVector(xspeed, yspeed);
    BPos.add(BVelocity);

  }
}