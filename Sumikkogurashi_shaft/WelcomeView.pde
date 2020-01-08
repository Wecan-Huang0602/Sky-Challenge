import java.util.Arrays;
import java.util.List;

class WelcomeView {
  PImage bg, title; // 背景圖和標題
  PImage[] images; // 存開場動畫的陣列
  Button bt; // 按鈕
  
  Button cat, bear, dinosaur, lizard;
  
  int frameIndex = 0; // 動畫的偵號

  WelcomeView() {

    // 讀入背景和標題圖
    bg = loadImage("Asset/welcomeView/sky.jpg");
    title = loadImage("Asset/welcomeView/Sky_challenge.png");
    
    // 讀入角落小夥伴動圖的路徑
    File temp = new File(sketchPath() + "/Asset/animate/");
    File[] fs = temp.listFiles();
    ArrayList<File> fsList = new ArrayList<File>(Arrays.asList(fs));
    
    println("\n\n==============開場動畫的所有檔案==============");
    for (File f : fsList) {
      println(f);
    }

    // 移除 .DS_Store 檔案
    for (File f : fsList) {
      if (f.getName().equals(".DS_Store")) {
        fsList.remove(f);
        break;
      }
    }
    
    images = new PImage[fsList.size()];
    // 讀入角落小夥伴的動圖
    for (int i=0; i<fsList.size(); i++) {
      // 因為會有圖片順序的問題，因此暫時先寫死
      images[i]=loadImage("Asset/animate/img" + (i+1) + ".png");
    }
  }
  
  void draw() {
    frameRate(24);
    //background(#D2EDF7);
    image(bg, 0, 0);
    image(title, width/2-350, height/2-440, 640, 360);
    image(images[frameIndex], 65, 250);
    
    // 原本一秒四偵，現在一秒24偵，變六倍了，每六偵更新一次動畫
    if (frameCount % 6 == 0) {
      frameIndex ++;
      if (frameIndex >= images.length) frameIndex = 0;
    }
    
    // 畫全部的按鈕
    cat.draw();
    lizard.draw();
    bear.draw();
    dinosaur.draw();
  }
}
