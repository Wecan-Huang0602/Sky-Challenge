import java.util.Collections;

float moveRate = 0; // 畫面滾動的速度
int score = 6; // 玩家的分數，每六朵雲上升一層樓

class GameView {
  Dinosaur dinosaur;
  Background bg;
  Bird bird;
  
  //GameView() {
  //  initView();
  //}
   
  void initView(String playerImgDir_L, String playerImgDir_R) {
    bg = new Background();
    dinosaur = new Dinosaur(bg.cloudList.get(1).locate.x, 0, 'R', playerImgDir_L, playerImgDir_R);
    dinosaur.locate.y = bg.cloudList.get(1).locate.y + 10 - dinosaur.dinosaurH;
    moveRate = 0;
    score = 6;
    
    bird = new Bird('L');
    bird.locate.x = -100;
  }
  
  void draw() {
    if (isGameOver()) return; // 如果GameOver了就不要繼續更新畫面了
    
    bg.draw();
    
    dinosaur.draw();
    if (dinosaur.touchBird) {
      dinosaur.onCloud = false;
    } else {
      dinosaurOnCloud();
    }
    
    
    drawBird();
    dinosaurTouchBird();
  }
  
  void drawBird() {
    if ((score%6 == 0 && score>6) && 
        (bird.locate.x < -500 || bird.locate.x >= width+500)) {
      float temp = random(0, 2);
      if (temp < 1) {
        bird = new Bird('R');
      } else {
        bird = new Bird('L');
      }
    }
    bird.draw();
  }
  
  void dinosaurOnCloud() {
    for (Cloud cloud : bg.cloudList) {
      if (dinosaur.locate.x >= (cloud.locate.x - dinosaur.dinosaurW + 20) &&
          dinosaur.locate.x <= (cloud.locate.x + cloud.cloudW - 20) &&
          dinosaur.locate.y + dinosaur.dinosaurH >= (cloud.locate.y) &&
          dinosaur.locate.y + dinosaur.dinosaurH <= (cloud.locate.y + cloud.cloudH) &&
          dinosaur.velocity.y >= 0) {
            dinosaur.onCloud = true;
            dinosaur.locate.y = (cloud.locate.y + 10) - dinosaur.dinosaurH;
            break;
      } else {
        dinosaur.onCloud = false;
      }
    }
  }
  
  // 看恐龍有沒有碰到鳥，碰到鳥就掛掉往下掉
  void dinosaurTouchBird() {
    if (((bird.locate.x+bird.birdW/2) >= dinosaur.locate.x && 
        (bird.locate.x+bird.birdW/2) <= (dinosaur.locate.x+dinosaur.dinosaurW)) &&
        ((bird.locate.y+bird.birdH/2) >= dinosaur.locate.y && 
        (bird.locate.y+bird.birdH/2) <= (dinosaur.locate.y+dinosaur.dinosaurH))) {
          dinosaur.touchBird = true;
    }
  }
  
  boolean isGameOver() {
    if (dinosaur.locate.y > height + 50) return true;
    else return false;
  }
}
