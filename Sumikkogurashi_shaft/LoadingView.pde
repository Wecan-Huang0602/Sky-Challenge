import java.util.Arrays;
import java.util.List;

class LoadingView {
  PImage[] images; // 存開場動畫的陣列

  LoadingView() {
    
    // 讀入角落小夥伴動圖的路徑
    File temp = new File(sketchPath() + "/Asset/loading_animate/");
    File[] fs = temp.listFiles();
    ArrayList<File> fsList = new ArrayList<File>(Arrays.asList(fs));
    
    
    println("\n\n==============Loading動畫的所有檔案==============");
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
      images[i]=loadImage("Asset/loading_animate/img" + (i+1) + ".png");
    }
  }
  
  void draw() {
    frameRate(7);
    background(#555555);
    showText("Loading...");
    image(images[frameCount%images.length], 65, 250);
  }
  
  void showText(String text) {
    // 顯示文字
    fill(#EEFFEE); // 文字顏色
    textSize(50); // 文字大小
    textAlign(CENTER, CENTER); // 文字置中對齊
    text(text, width/2, height/2 + 150); // 寫文字
  }
}
