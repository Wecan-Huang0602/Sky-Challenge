class Cloud {
  PImage cloud;
  PVector locate; // 雲朵的位置
  int cloudW=200, cloudH=50; // 雲朵的寬度跟高度
  int moveDirection; // 雲的移動方向
  
  Cloud(float x, float y) {
    cloud = loadImage("Asset/cloud.png");
    locate = new PVector(x, y);
     
    moveDirection = round(random(-2, 2)); // 隨機移動雲的方向
    cloudW = round(random(150, 200)); // 隨機初始化雲的大小
  }
  
  void draw() {
    
    if (score/6 >= 5) {
      // 當雲撞到邊界就反彈
      if (locate.x > width-cloudW) moveDirection = round(random(-2, 0));
      if (locate.x < 0) moveDirection = round(random(0, 2));
      locate.x += moveDirection; // 移動雲
    }
    
    image(cloud, locate.x, locate.y, cloudW, cloudH);
  }
}
