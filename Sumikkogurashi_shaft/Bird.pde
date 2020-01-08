class Bird {
  PVector locate; // 鳥的位置
  PVector velocity; // 鳥移動的速度
  float birdW = 60, birdH = 60; // 鳥的長寬
  PImage birdRight;
  PImage birdLeft;
  char facing; // 鳥的面向
  
  Bird(char facingROL) {
    birdRight = loadImage("Asset/bird_right.png");
    birdLeft = loadImage("Asset/bird_left.png");
    
    facing = facingROL;
    
    switch (facing) {
      case 'R':
        velocity = new PVector(round(random(3, 6)), 0);
        locate = new PVector(0, round(random(0, height/2)));
        break;
      
      case 'L':
        velocity = new PVector(-round(random(3, 6)), 0);
        locate = new PVector(width, round(random(0, height/2)));
        break;
    }
  }
  
  void draw() {
    switch (facing) {
      case 'R':
        image(birdRight, locate.x, locate.y, birdW, birdH);
        break;
      
      case 'L':
        image(birdLeft, locate.x, locate.y, birdW, birdH);
        break;
    }
    
    
    // 把小鳥的位置加上在XY軸方向的加速度
    locate.add(velocity);
  }
}
