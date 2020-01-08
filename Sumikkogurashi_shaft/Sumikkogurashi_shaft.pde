import processing.sound.*; // 匯入音樂播放的套件
import processing.serial.*; // 與Arduino連接的套件

GameView gv; // 遊戲畫面
WelcomeView wv; // 歡迎畫面
LoadingView lv; // loading畫面

boolean isGameStart = false; // 紀錄遊戲開始了沒
boolean isLoadingFinsh = false; // 紀錄Loading完了沒

SoundFile player; // 宣告音樂播放器

Serial serial; // 與Arduino連接的東西

String[] characters = {"cat", "dinosaur", "bear", "lizard"};
int nowCharacter = 0; // 紀錄現在選的是哪個角色

void setup() {
  size(500, 800);
  
  lv = new LoadingView();
  
  // 在子線程載入進行遊戲初始化，未初始化前會先顯示載入動畫
  thread("initGame");
}

void initGame() {
  // 初始化與Arduino連接的東西
  serial = new Serial(this, "/dev/cu.wchusbserial1420", 9600); 
  
  // 初始化音樂播放器，並傳入音檔檔名
  player = new SoundFile(this, "Asset/角落.mp3");
  
  gv = new GameView();
  wv = new WelcomeView();
  
  initAllButton();
  
  isLoadingFinsh = true;
}

void initAllButton() {
  
  // 初始化貓咪按鈕
  wv.cat = new Button(5, height/2+200, 120, 120) {
    @Override
      public void onClick() {
        // 按下按鈕開始遊戲
        nowCharacter = 0;
        startGame();
      }
  };
  wv.cat.img = loadImage("Asset/cat.png");
  wv.cat.imgHover = loadImage("Asset/cat_left.png");
  
  // 初始化恐龍按鈕
  wv.dinosaur = new Button(125, height/2+200, 120, 120) {
    @Override
      public void onClick() {
        // 按下按鈕開始遊戲
        nowCharacter = 1;
        startGame();
      }
  };
  wv.dinosaur.img = loadImage("Asset/dinosaur.png");
  wv.dinosaur.imgHover = loadImage("Asset/dinosaur_left.png");
  
  // 初始化白熊按鈕
  wv.bear = new Button(245, height/2+200, 120, 120) {
    @Override
      public void onClick() {
        // 按下按鈕開始遊戲
        nowCharacter = 2;
        startGame();
      }
  };
  wv.bear.img = loadImage("Asset/bear.png");
  wv.bear.imgHover = loadImage("Asset//bear_left.png");
  
  // 初始化蜥蜴按鈕
  wv.lizard = new Button(365, height/2+200, 120, 120) {
    @Override
      public void onClick() {
        // 按下按鈕開始遊戲
        nowCharacter = 3;
        startGame();
      }
  };
  wv.lizard.img = loadImage("Asset/lizard.png");
  wv.lizard.imgHover = loadImage("Asset/lizard_left.png");
}

void startGame() {
  // 按下按鈕開始遊戲
  isGameStart = true;
  gv.initView(
    "Asset/"+characters[nowCharacter]+"_left.png", 
    "Asset/"+characters[nowCharacter]+"_right.png");
  player.loop(); // 播放音檔
  frameRate(75);
}

void draw() {
  if (!isLoadingFinsh) {
    lv.draw();
    return;
  }
  
  //  如果還沒開始遊戲就顯示主畫面
  if (!isGameStart) {
    wv.draw();
    handleChoseCharacters();
    return;
  }
  
  
  if (!gv.isGameOver()) {
    // 如果玩家還沒掛掉就繼續更新遊戲畫面
    gv.draw();
    //joyStickContorl(); // 搖桿操作
    handleContorl(); // 把手操作
    
  } else {
    // 如果GameOver就不要繼續顯示遊戲畫面和播音樂了
    isGameStart = false;
    player.stop();
  }
}



void keyPressed() {
  switch(keyCode) {
    case LEFT:
      gv.dinosaur.facing = 'L';
      gv.dinosaur.velocity.x = -5f;
      break;
      
    case RIGHT:
      gv.dinosaur.facing = 'R';
      gv.dinosaur.velocity.x = 5f;
      break;  
      
    case UP:
      gv.dinosaur.jump();
      break; 
  }
}

void keyReleased() {
  // 放開鍵盤就煞車
  if (keyCode == RIGHT) {
    gv.dinosaur.velocity.x = 0f;
  }
  if (keyCode == LEFT) {
    gv.dinosaur.velocity.x = 0f;
  }
  if (keyCode == UP) {
    // 放開上鍵後，要記得把isjump設定為false，這樣下次按上鍵時，小恐龍才可以跳耀
    gv.dinosaur.isjump = false;
  }
}

// 搖桿操作
void joyStickContorl() {
  
  float x=0, y=0;
  
  if(serial.available()>0){
    String now= serial.readString();
    String[] xy= splitTokens(now);
    
    x = float(xy[0]);
    y = float(xy[1]);
    
    println("==================");
    println("x: " + x + "   y: " + y);
    
    if (x > 550) {
      gv.dinosaur.facing = 'R';
      gv.dinosaur.velocity.x = 5f;
        
    } else if (x < 500) {
      gv.dinosaur.facing = 'L';
      gv.dinosaur.velocity.x = -5f;
      
    } else {
      gv.dinosaur.velocity.x = 0f;
    }
    
    if (y < 500) {
      gv.dinosaur.jump();
    } else {
      // 放開上鍵後，要記得把isjump設定為false，這樣下次按上鍵時，小恐龍才可以跳耀
      gv.dinosaur.isjump = false;  
    }
  }
}

//  把手操作
void handleContorl() {
  
  if(serial.available()>0){
    float now = float(serial.readString());
    //println(now);
    
    if (now >= 160 && now <= 170) {
      gv.dinosaur.facing = 'R';
      gv.dinosaur.velocity.x = 5f;
        
    } else if (now >= 0 && now <= 10) {
      gv.dinosaur.facing = 'L';
      gv.dinosaur.velocity.x = -5f;
      
    } else if (now >= 30 && now <= 40) {
      gv.dinosaur.jump();
      
    } else {
      gv.dinosaur.velocity.x = 0f;
      // 放開上鍵後，要記得把isjump設定為false，這樣下次按上鍵時，小恐龍才可以跳耀
      gv.dinosaur.isjump = false; 
    }
    
    //if (now >= 30 && now <= 40) {
    //  gv.dinosaur.jump();
    //} else {
    //  // 放開上鍵後，要記得把isjump設定為false，這樣下次按上鍵時，小恐龍才可以跳耀
    //  gv.dinosaur.isjump = false;  
    //}
  }
}

//  用把手選角色 
void handleChoseCharacters() {
    
  if(serial.available()>0){
    float now = float(serial.readString());
    //println("-----------");
    //println(now);
    
    
    if (now >= 160 && now <= 170) {
      nowCharacter ++;
      if (nowCharacter >= characters.length) nowCharacter=0;
        
    } else if (now >= 0 && now <= 10) {
      nowCharacter --;
      if (nowCharacter < 0) nowCharacter=characters.length-1;
    }
    
    //println(nowCharacter);
    
    clearButtonChose();
    // 如果按鈕isChose==true就會顯示面向右邊的圖樣
    switch(nowCharacter) {
      case 0:
        wv.cat.isChose = true;
        break;
      case 1:
        wv.dinosaur.isChose = true;
        break;
      case 2:
        wv.bear.isChose = true;
        break;
      case 3:
        wv.lizard.isChose = true;
        break;
    }
    
    // 按下最右邊的按鈕開始遊戲
    if (now >= 350 && now <= 360) {
      startGame();
    }
  }
}

// 把每個按鈕的isChose清除掉，這樣一次才會顯示一隻被選擇
void clearButtonChose() {
  wv.cat.isChose = false;
  wv.dinosaur.isChose = false;
  wv.bear.isChose = false;
  wv.lizard.isChose = false;
}
