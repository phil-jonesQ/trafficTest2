class Traffic {

  PVector TBraking;
  PVector TVelocity;
  PVector TPos;
  float TWidth;
  float THeight;

  Traffic(float x, float y) {
    TBraking = new PVector(-1, -1);  
    TVelocity = new PVector(1, 0);
    TPos = new PVector(x, y);
    TWidth = 10;
    THeight = 5;
  }

  void show(boolean r) {

    noStroke();
    fill(255);
    if (r) {
      rect(TPos.x+(scl/2), TPos.y+(scl/2), THeight, TWidth);
    } else {
      rect(TPos.x+(scl/2), TPos.y+(scl/2), TWidth, THeight);
    }
  }


  void move(float xspeed, float yspeed) {
    TVelocity = new PVector(xspeed, yspeed);
    TPos.add(TVelocity);
    //handleEdges();
  }

  void handleEdges() {

    if (TPos.x > width) {
      TPos.x = width;
      TPos.y = TPos.y +1;
    }
  }

  float trafficPosX() {
    return TPos.x+(scl/2);
  }

  float trafficPosY() {
    return TPos.y+(scl/2);
  }
}