abstract class Button {
  PVector pos;
  float w, h;
  PImage imgHover, img;
  int value = 0;
  int state; // 紀錄畫Hover還是沒有Hover的按鈕
  boolean isChose = false; //紀錄把手有沒有選到
  //PImage pointer; // 顯示現在選到哪個角色用的
  

  Button(float x, float y, float btnW, float btnH) {
    pos = new PVector(x, y);
    w = btnW;
    h = btnH;
    //pointer = loadImage("Asset/fried_shrimp.png"); // 用炸蝦的圖片當指標
  }

  void draw() {
    checkClick();
    mouseHover();
    
    if (state == 0) {
      image (img, pos.x, pos.y, w, h);
      
    } else if (state == 1) {
      image (imgHover, pos.x, pos.y, w, h);
      //image (pointer, pos.x+(w/2)-35, pos.y+h, 70, 70);
    }
  }

  void mouseHover() {
    if (isChose) {
      state = 1;
      
    } else if (mouseX > pos.x && mouseX < pos.x+w &&
      mouseY > pos.y && mouseY < pos.y+h) {
      state = 1;
      nowCharacter = -1;
    } else {
      state = 0;
    }
  }
 
  void checkClick() {
    if (mousePressed && 
      mouseX > pos.x && mouseX < pos.x+w &&
      mouseY > pos.y && mouseY < pos.y+h) {
      onClick();
    }
  }

  public abstract void onClick();
}
