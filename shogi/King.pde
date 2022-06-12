public class King extends Piece {
  final color One = color(0, 209, 122);
  final color Two = color(82, 239, 184);
  final color Three = color(158, 255, 223);
  final color Four = color(180, 224, 200);
  final color Five = color(2, 130, 98);
  final color Six = color(83, 113, 157);
  final color Seven = color(65, 87, 121);
  final color Eight = color(52, 70, 96);
  final color Nine = color(18, 36, 67);
  final color Ten = color(115, 104, 159);
  final color Eleven = color(86, 76, 116);
  int upDown = 1;
  int upDownInt = 0;
  public King(String x) {
    super(x);
    role="king";
    value=50;
    display = "king.txt";
    alienDisplay = "kingBot.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    if (x!=0) {
      int[] left={x-1, y};
      ans.add(left);
      if (y!=0) {
        int[] upperLeft={x-1, y-1};
        ans.add(upperLeft);
      }
      if (y!=8) {
        int[] downLeft={x-1, y+1};
        ans.add(downLeft);
      }
    }
    if (x!=8) {
      int[] right={x+1, y};
      ans.add(right);
      if (y!=0) {
        int[] upperRight={x+1, y-1};
        ans.add(upperRight);
      }
      if (y!=8) {
        int[] downRight={x+1, y+1};
        ans.add(downRight);
      }
    }
    if (y!=0) {
      int[] up = {x, y-1};
      ans.add(up);
    }
    if (y!=8) {
      int[] down = {x, y+1};
      ans.add(down);
    }
    potentialMoves=(ArrayList)ans.clone();
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    int start = 1;
    int end = 13;
    if (upDownInt == 0) {
      upDown = -2;
    } else if(upDownInt == -22){
      upDown = 2;
    }
    upDownInt += upDown;
    //if (idleCounter <= 180) {
    //  start = 1;
    //  end = 17;
    //} else if (idleCounter > 180) {
    //  start = 35;
    //  end = 51;
    //} else {
    //  start = 35;
    //  end = 51;
    //}
    if (white) {
      if (Theme.equals("Alien")) {
        lines = loadStrings(alienDisplay);
        int scale = 4;
        //x+=idleCounter;
        idleCounter+=1;
        if (idleCounter == 360) {
          idleCounter =0;
        }
        if (animating) {
          //start = 1;
          //end = 17;
          //movingCounter +=1;
          //scaleY+=0.5;
          //displayX += scaleX;
          //displayY += scaleY;

          //if (movingCounter > 20) {
          //  scaleX= 0;
          //  scaleY= 0;
          //  start = 35;
          //  end = 51;
          //}
        }
        for (int i = start; i < end; i++) {
          //System.out.println(i);
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='7') {
              fill(Seven);
            } else if (lines[i].charAt(a)=='1') {
              fill(One);
            } else if (lines[i].charAt(a)=='2') {
              fill(Two);
            } else if (lines[i].charAt(a)=='3') {
              fill(Three);
            } else if (lines[i].charAt(a)=='4') {
              fill(Four);
            } else if (lines[i].charAt(a)=='5') {
              fill(Five);
            } else if (lines[i].charAt(a)=='6') {
              fill(Six);
            } else if (lines[i].charAt(a)=='8') {
              fill(Eight);
            } else if (lines[i].charAt(a)=='9') {
              fill(Nine);
            } else if (lines[i].charAt(a)=='a') {
              fill(Ten);
            } else if (lines[i].charAt(a)=='b') {
              fill(Eleven);
            }
            if (lines[i].charAt(a)!='0') {
              //if (animating) {
              //  System.out.println(displayX+ " " +displayY);
              //  rect(displayX + (a*scale), displayY+((i-start)*scale), scale, scale);
              //  if (movingCounter >= Stop) {
              //    animating = false;
              //  }
              //} else {
              rect(x + (a*scale), y+((i-start)*scale) + upDownInt, scale, scale);
              //}
            }
          }
        }
      } else {
        fill(173, 168, 164);
        rect(x +17, y +44, 60, 50);
        triangle(x +17, y +44, x +77, y +44, x +47, y +14);
        fill(255);
        if (Theme.equals("Hell")) {
          fill(255, 225, 214);
        }
        rect(x +20, y +40, 60, 50);
        triangle(x +20, y +40, x +80, y +40, x +50, y +10);
        x=x +34;
        y=y +40;
        fill(0);

        for (int i = 1; i < lines.length; i++) {
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='1') {  
              rect(x + (a*2), y+(i*1.9), 2.8, 3.8);
            }
          }
        }
      }
    } else {
      fill(173, 168, 164);
      rect(x +17, y +13, 60, 50);
      triangle(x +17, y +63, x +77, y +63, x +47, y +93);
      fill(255);
      if (Theme.equals("Hell")) {
        fill(255, 225, 214);
      }
      rect(x +20, y +10, 60, 50);
      triangle(x +20, y +60, x +80, y +60, x +50, y +90);
      x=x +35;
      y=y +27;
      //int newRow = 0;
      //String store1 = "";
      //String store2= "";
      //for (int i = 1; i <= lines.length / 2; i++) {
      //  newRow = lines.length - i;
      //  for (int a = lines[i].length() - 1; a >= 0; a--) {
      //    store1 += lines[i].substring(a, a+1);
      //    store2 += lines[newRow].substring(a, a+1);
      //  }
      //  lines[i] = store2;
      //  lines[newRow] = store1;
      //  store1="";
      //  store2="";
      //}

      for (int i = 1; i < lines.length; i++) {
        for (int a = 0; a < lines[i].length(); a++) {
          if (lines[i].charAt(a)=='1') {  
            fill(0);
            rect(x + (a*2), y+(i*1.9), 2.8, 3.8);
          }
        }
      }
    }
  }
}
