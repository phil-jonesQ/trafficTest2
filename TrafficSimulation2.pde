//Over head view of city traffic
//Traffic are simple rect objects

ArrayList<Traffic> t;
ArrayList<Obstacle> o;
ArrayList<PVector> b = new ArrayList<PVector>();
int scl=20;
int cols;
int rows;
int Tamount=1;
int myTrafficIndex;
boolean right;
boolean down;
boolean up;
boolean left;
boolean topBound;
boolean bottomBound;
boolean rightBound;
boolean leftBound;
boolean debug;
float velocity;
float speed;


void setup() {
  size(600, 600);
  cols=width/scl;
  rows=height/scl;
  smooth();
  frameRate(10);
  t = new ArrayList<Traffic>();
  o = new ArrayList<Obstacle>();
  //b = new ArrayList<Block>();
  addBlock();
  debug=false;
  right=true;
  down=false;
  up=false;
  left=false;
  topBound=false;
  bottomBound=false;
  rightBound=false;
  //Need to set this as we start going right
  leftBound=true;
  velocity=1.4;
  speed=0.01;
  myTrafficIndex=t.size()-1;
  generateObstacle();
}

void mouseClicked() {
  if (!debug) {
    generateObstacle();
  }
  if (debug) {
    removeLastBlock();
    addNewBlock();
  }
  //down=true;
  //up=false;
  //right=false;
  //left=false;
  //addBlock();
}

void draw() {
  background(0);
  drawGrid();
  drawBlocks();
  drawObstacles();
  if (!debug) {
    removeLastBlock();
    addNewBlock();
  }
  getKeys();
  edges();
  divert();

  //println("Go Right = " + right + " Go Left = " + left + " Go Down " + down + " Go Up " + up);
  //println("Right Bound = " + rightBound + " Left Bound = " + leftBound + " Down bound = " + bottomBound + " Up bound = " + topBound);
}


void drawTraffic(int chosen) {

  if (down || up) {
    //rotate
    t.get(chosen).show(true);
  } else {
    t.get(chosen).show(false);
  }
}

void drawGrid() {
  for (int r=0; r < height; r=r+scl) {
    for (int c =0; c < width; c=c+scl) {
      noFill();
      stroke(255);
      rect (c, r, scl, scl);
    }
  }
}

void addBlock() {
  for (int i=0; i < 10; i++) {
    //b.add(new Block (scl*i, scl));
    b.add(new PVector(scl*i, scl*5));
  }
}

void removeBlock() {
  for (int i=b.size()-1; i >=0; i--)
    b.remove(i);
}

void removeLastBlock() {
  b.remove(0);
}

void addNewBlock() {
  int last=b.size()-1;
  //println("Current last block = " + last);
  float x = b.get(last).x;
  float y = b.get(last).y;
  //println(x,y);
  //if (right && leftBound || topBound) {
  if (right && !rightBound) {
    b.add(new PVector(x+scl, y));
  }
  //if (up && bottomBound || leftBound) {
  if (up && !topBound) {
    b.add(new PVector(x, y-scl));
  }

  //if (left && rightBound || bottomBound) {
  if (left && bottomBound) {
    b.add(new PVector(x-scl, y));
  }
  //if (down && topBound || rightBound) {
  if (down && rightBound) {
    b.add(new PVector(x, y+scl));
  }
}

void drawBlocks() {
  for (PVector v : b) {
    stroke(0);
    fill(255);
    rect(v.x, v.y, scl, scl);
  }
}

void edges() {
  int last=b.size()-1;
  float x = b.get(last).x;
  float y = b.get(last).y;
  //println("x value.." + x, y);
  if (x > width-scl*2 && !bottomBound) {
    println("In right boundary");
    rightBound=true;
    down=true;
    right=false;
    left=false;
    up=false;
    leftBound=false;
    bottomBound=false;
    topBound=false;
  }

  if (x < scl && !topBound) {
    println("In left boundary");
    leftBound=true;
    up=true;
    right=false;
    down=false;
    left=false;
    rightBound=false;
    bottomBound=false;
    topBound=false;
  }

  if (y > height-scl*2 && !leftBound) {
    println("In bottom boundary");
    bottomBound=true;
    right=false;
    down=false;
    left=true;
    up=false;
    rightBound=false;
    leftBound=false;
    topBound=false;
  }

  if (y < scl && !rightBound) {
    println("In top boundary");
    topBound=true;
    right=true;
    down=false;
    left=false;
    up=false;
    rightBound=false;
    leftBound=false;
    bottomBound=false;
    //print("RIGHT!!");
  }
}

void generateObstacle() {

  //o = new Obstacle();
  for (int i=0; i < 10; i++) {
    o.add(new Obstacle());
  }
}

void clearObstacles() {

  for (int i=o.size()-1; i >0; --i) {
    o.remove(i);
  }
}

void drawObstacles() {

  for (int i=0; i < o.size(); i++)
    o.get(i).show();
}

void getKeys() {
  if (keyCode == DOWN) {
    down=true;
    up=false;
    right=false;
    left=false;
  }

  if (keyCode == UP) {
    up=true;
    down=false;
    right=false;
    left=false;
  }

  if (keyCode == RIGHT) {
    println("in right");
    right=true;
    up=false;
    down=false; 
    left=false;
  }

  if (keyCode == LEFT) {
    right=false;
    up=false;
    down=false; 
    left=true;
  }

  if (key == 'g' && keyPressed) {
    clearObstacles();
    generateObstacle();
  }
}

void divert() {
  int last=b.size()-1;
  int first=0;
  float x = b.get(last).x;
  float y = b.get(last).y;
  float x1 = b.get(first).x;
  float y1 = b.get(first).y;
  for (int i=0; i < o.size(); i++) {
    float obsX = o.get(i).getObsX();
    float obsY = o.get(i).getObsY();
    float d = dist(x+scl/2, y+scl/2, obsX+scl/2, obsY+scl/2);
    float d1 = dist(x1+scl/2, y1+scl/2, obsX+scl/2, obsY+scl/2);
    if (d < 32) {
      println("distance = " + d);
    }
    if (d1 <= scl/2 || d <= scl/2 && right && topBound) {
      //if (d <= scl && right) {
      clearObstacles();
      generateObstacle();
      println("distanceD = " + d);
      down=true;
      up=false;
      right=false;
      left=false;
    } 
    if (d1 <= scl/2 || d <= scl/2 && left && bottomBound) {
      //if ( d <= scl && left) {
      clearObstacles();
      generateObstacle();
      println("distanceU = " + d);
      down=false;
      up=true;
      right=false;
      left=false;
    }
    if (d1 <= scl/2 || d <= scl/2 && down && rightBound) {
      //if (d <= scl && down) {
      clearObstacles();
      generateObstacle();
      println("distanceL = " + d);
      down=false;
      up=false;
      right=false;
      left=true;
    } 
    if (d1 <= scl/2 || d <= scl/2 && up && leftBound) {
      //if ( d <= scl && up) {
      clearObstacles();
      generateObstacle();
      println("distanceR = " + d);
      down=false;
      up=false;
      right=true;
      left=false;
    }
  }
}