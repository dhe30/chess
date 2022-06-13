public class Bishop extends Piece {
  final color One = color(71, 51, 33);
  final color Two = color(158, 121, 82);
  final color Three = color(236, 228, 187);
  final color Four = color(100, 76, 52);
  final color Five = color(83, 61, 40);
  final color Six = color(193, 181, 135);
  final color Seven = color(255, 255, 255);
  int upDown = 1;
  int upDownInt = 0;
  public Bishop(String x) {
    super(x);
    role="bishop";
    isRoyal=true;
    value=10;
    display = "bishop.txt";
    alienDisplay = "theWord.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    int ogX = x;
    int ogY = y;
    while (x>0 && y>0) {
      x--;
      y--;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100, 100});
    x=ogX;
    y=ogY;
    while (x>0 && y<8) {
      x--;
      y++;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100, 100});
    x=ogX;
    y=ogY;
    while (x<8 && y>0) {
      x++;
      y--;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100, 100});
    x=ogX;
    y=ogY;
    while (x<8 && y<8) {
      x++;
      y++;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100, 100});
    if (promoted) {
      if (ogX!=8) {
        int[] right = {ogX +1, ogY};
        ans.add(right);
      }
      ans.add(new int[]{100, 100});
      if (ogX!=0) {
        int[] left = {ogX -1, ogY};
        ans.add(left);
      }
      ans.add(new int[]{100, 100});
      if (ogY!=0) {
        int[] up = {ogX, ogY-1};
        ans.add(up);
      }
      ans.add(new int[]{100, 100});
      if (ogY!=8) {
        int[] down = {ogX, ogY+1};
        ans.add(down);
      }
      ans.add(new int[]{100, 100});
    }
    //String answ ="";
    //  for(int i = 0; i < ans.size(); i++){
    //    answ += "[" + ans.get(i)[0] + "," + ans.get(i)[1] + "], ";
    //  }
    //  System.out.println("NORM" + answ);
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote() {
    promoted=true;
    role="promoted\nbishop";
    value=20;
  }
  void demote() {
    promoted=false;
    role="bishop";
    value=10;
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    int start = 1;
    int end = 27;
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
    if (Theme.equals("Alien")) {
      float scale = 3.5;
      //x+=idleCounter;
      idleCounter+=1;
      if (idleCounter == 360) {
        idleCounter =0;
      }
      if (upDownInt == 0) {
        upDown = -2;
      } else if (upDownInt == -22) {
        upDown = 2;
      }
      upDownInt += upDown;
      //if (animating) {
      //  start = 35;
      //  end = 51;
      //  movingCounter +=1;
      //  scaleY+=2;
      //  displayX += scaleX;
      //  displayY += scaleY;
      //}
      if (white) {
        for (int i = start; i < end; i++) {
          for (int a = lines[i].length() - 1; a >= 0; a--) {
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
            } 

            if (lines[i].charAt(a)!='0') {
              if (animating) {
                System.out.println(displayX+ " " +displayY);
                rect(displayX + ((lines[i].length() - a)*(scale-1.3)), displayY+((i-start)*(scale-1.3)), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(displayX + ((lines[i].length() - a)*(scale-1.3)), displayY+((i-start)*(scale-1.3)), scale, scale);
                }
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + ((lines[i].length() - a)*(scale - 1.3)), y+((i-start)*(scale-1.3))+ upDownInt, scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(x + ((lines[i].length() - a)*scale), y+((i-start)*scale) + upDownInt, scale, scale);
                }
              }
            }
          }
        }
      } else {
        for (int i = start; i < end; i++) {
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
            } 
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                System.out.println(displayX+ " " +displayY);
                rect(displayX + (a*(scale-1.3)), displayY+((i-start)*(scale-1.3)), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(displayX + (a*(scale-1.3)), displayY+((i-start)*(scale-1.3)), scale, scale);
                }
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + (a*(scale-1.3)), y+((i-start)*(scale-1.3)) + upDownInt, scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(x + (a*(scale-1.3)), y+((i-start)*(scale-1.3)) + upDownInt, scale, scale);
                }
              }
            }
          }
        }
      }
    } else {
      super.displayPiece(x, y, white, "bishop.txt");
    }
  }
  void animate(int x, int y, int x1, int y1) {
    animating = true;
    movingCounter = 0;
    displayY = x*100;
    displayX = y*100;
    scaleY = ((((x1*100)-(x*100))-(0.5*2*20*20))/20);
    scaleX = ((y1*100)-(y*100))/Stop;
    System.out.println(displayX + " " + displayY + " " + scaleX + " " + scaleY);
  }
}
