class Obstacle {

  float x;
  float y;

  Obstacle() {
    //println(cols, rows);
    x = floor(random(0, cols))*scl;
    y = floor(random(0, rows))*scl;
    //y = height-scl;
    //println (x, y);
  }

  void show() {

    fill(255, 0, 0);
    rect(x, y, scl, scl);
  }


  float getObsX() {
    return x;
  }

  float getObsY() {
    return y;
  }
}