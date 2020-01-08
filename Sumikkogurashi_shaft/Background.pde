class Background {
  ArrayList<Cloud> cloudList;
  float y = -150;
  PImage bg; // 背景圖
  
  Background() {
    cloudList = new ArrayList<Cloud>();
    bg = loadImage("Asset/sky.jpg"); // 讀入背景圖
    
    // 初始化所有的雲朵
    for (int i=0; i<6; i++) {
      cloudList.add(new Cloud((int)random(0, width-200), y+=150));
    }
  }
  
  void drawCloud() {
    // 滾動畫面上的雲朵
    for (int i=0; i<6; i++) {
      // 如果雲朵滾超出畫面就再畫一個新的雲朵
      if (cloudList.get(i).locate.y >= height) {
        cloudList.remove(i);
        cloudList.add(new Cloud((int)random(0, width-200), -100));
        score ++; // 分數加1
        moveRate += 0.01; // 速度加0.01
      }
      cloudList.get(i).locate.y += 1+moveRate;
      cloudList.get(i).draw();
    }
  }
  
  void draw() {
    //background(128, 170, 217);
    image(bg, 0, 0); // 畫背景圖
    showScore();
    drawCloud();
  }
  
  void showScore() {
    // 顯示文字
    fill(#EEFFEE); // 文字顏色
    textSize(175); // 文字大小
    textAlign(CENTER, CENTER); // 文字置中對齊
    text((score/6)+"F", width/2, height/2-50); // 寫文字
  }
}
