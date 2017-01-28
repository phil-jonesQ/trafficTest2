//Over head view of city traffic
//Traffic are simple rect objects


ArrayList<Traffic> t;
//ArrayList<Block> b;
ArrayList<PVector> b = new ArrayList<PVector>();
int scl=30;
int cols=width/scl;
int rows=height/scl;
int Tamount=1;
int myTrafficIndex;
boolean right;
boolean down;
boolean up;
boolean left;
float velocity;
float speed;


void setup() {
  size(600, 600);
  smooth();
  frameRate(50);
  t = new ArrayList<Traffic>();
  //b = new ArrayList<Block>();
  addBlock();
  right=true;
  down=false;
  up=false;
  left=false;
  velocity=1.4;
  speed=0.01;
  myTrafficIndex=t.size()-1;
}

void mouseClicked() {
  removeLastBlock();
  addNewBlock();
  //addBlock();
}

void draw() {
  background(0);
  drawGrid();
  drawBlocks();
  removeLastBlock();
  addNewBlock();
  edges();

  //println("Right = " + right + "Left = " + left + "down " + down + "Up" + up);
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
    b.add(new PVector(scl*i, scl));
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
  println(x,y);
  if (right) {
    b.add(new PVector(x+scl, y));  
  }
  if (up) {
    b.add(new PVector(x, y-scl));
  }

  if (left) {
    b.add(new PVector(x-scl, y));
  }
  if (down) {   
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
  if (x > width-scl*2 && right) {
    right=false;
    down=true;
    left=false;
    up=false;
  }
  if (x < scl && left) {
    right=false;
    down=false;
    left=false;
    up=true;
  }

  if (y > height-scl*2 && down) {
    right=false;
    down=false;
    left=true;
    up=false;
  }

  if (y < scl && up) {
    right=true;
    down=false;
    left=false;
    up=false;
    //print("RIGHT!!");
  }
}