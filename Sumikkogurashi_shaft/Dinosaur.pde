class Dinosaur {
  PImage dinosaurLeft, dinosaurRight;
  float dinosaurW=70, dinosaurH=70; // 恐龍的大小
  PVector locate; // 恐龍的位置
  PVector velocity; // 恐龍移動的速度
  char facing; // 恐龍的面向
  boolean onCloud = true; // 紀錄恐龍有沒有在雲上
  boolean isjump = false; // 紀錄恐龍有沒有正在跳耀
  boolean touchBird = false; // 紀錄恐龍有沒有碰到鳥
  
  Dinosaur(float x, float y, char facingROL, String playerImgDir_L, String playerImgDir_R) {
    dinosaurLeft = loadImage(playerImgDir_L);
    dinosaurRight = loadImage(playerImgDir_R);
    locate = new PVector(x, y);
    velocity = new PVector(0, 0);
    facing = facingROL;
  }
  
  void draw() {
    
    // 讓小恐龍在橫向的方向移動時不會超出畫面
    if (locate.x > width-dinosaurW) locate.x = width-dinosaurW;
    if (locate.x < 0) locate.x = 0; 
    
    switch (facing) {
      case 'R':
        image(dinosaurRight, locate.x, locate.y, dinosaurW, dinosaurH);
        break;
      
      case 'L':
        image(dinosaurLeft, locate.x, locate.y, dinosaurW, dinosaurH);
        break;
    }
    
    // 把小恐龍的位置加上在XY軸方向的加速度
    locate.add(velocity);
    
    if (!onCloud) {
      // 如果恐龍沒有在雲上就往下掉，給恐龍向下的加速度
      if (velocity.y <= 30) velocity.y += 0.98;
    } else {
      locate.y += 1+moveRate; // 如果恐龍在雲上就要隨著雲向下移動
      if (velocity.y >= 0) velocity.y = 0; // 如果恐龍在雲上就可以不用給他向下的加速度
    }
  }
  
  void jump() {
    // 如果小恐龍在雲上且沒有正在跳耀才可以做跳的動作(避免連環跳的情況發生)
    if (onCloud && !isjump) {
      isjump = true;
      velocity.y = -20+moveRate;
    }
  }
}
