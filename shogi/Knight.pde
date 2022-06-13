public class Knight extends Piece {
  final color One = color(0, 0, 0);
  final color Two = color(215, 22, 25);
  final color Three = color(244, 216, 36);
  final color Four = color(7, 86, 160);
  final color Five = color(255, 255, 255);
  public Knight(String x) {
    super(x);
    role="knight";
    value=5;
    display = "horse.txt";
    alienDisplay = "helloKitty.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    if (white) {
      if (!promoted) {
        if (x!=0 && y>1) {
          int[] upperLeftKnight = {x-1, y-2};
          ans.add(upperLeftKnight);
        }
        if (x!=8 && y>1) {
          int[] upperRightKnight = {x+1, y-2};
          ans.add(upperRightKnight);
        }
      } else {
        if (x!=0) {
          int[] left={x-1, y};
          ans.add(left);
          if (y!=0) {
            int[] upperLeft={x-1, y-1};
            ans.add(upperLeft);
          }
        }
        if (x!=8) {
          int[] right={x+1, y};
          ans.add(right);
          if (y!=0) {
            int[] upperRight={x+1, y-1};
            ans.add(upperRight);
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
      }
    } else {
      if (!promoted) {
        if (x!=0 && y<7) {
          int[] downLeftKnight = {x-1, y+2};
          ans.add(downLeftKnight);
        }
        if (x!=8 && y<7) {
          int[] downRightKnight = {x+1, y+2};
          ans.add(downRightKnight);
        }
      } else {
        if (x!=0) {
          int[] left={x-1, y};
          ans.add(left);
          if (y!=8) {
            int[] downLeft={x-1, y+1};
            ans.add(downLeft);
          }
        }
        if (x!=8) {
          int[] right={x+1, y};
          ans.add(right);
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
      }
    }
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote() {
    promoted=true;
    role="promoted\nknight";
    value=8;
    display = "promHorse.txt";
  }
  void demote() {
    promoted=false;
    role="knight";
    value=6;
    display = "horse.txt";
  }
  void displayPiece(int x, int y, boolean white, String line) {

    String[] lines = loadStrings(line);
    int start = 1;
    int end = 25;
    if (idleCounter <= 180) {
      start = 1;
      end = 26;
    } else {
      start = 27;
      end = 52;
    }
    if (white) {
      if (Theme.equals("Alien")) {
        x+=17;
        y+=10;
        lines = loadStrings(alienDisplay);
        int scale = 4;
        //x+=idleCounter;
        idleCounter+=1;
        if (idleCounter == 360) {
          idleCounter =0;
        }
        if (animating) {
          start = 1;
          end = 26;
          movingCounter +=1;
          scaleY+=2;
          displayX += scaleX;
          displayY += scaleY;

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
            if (lines[i].charAt(a)=='1') {
              fill(One);
            } else if (lines[i].charAt(a)=='2') {
              fill(Two);
            } else if (lines[i].charAt(a)=='3') {
              fill(Three);
            } else if (lines[i].charAt(a)=='4') {
              fill(Four);
            } else if (lines[i].charAt(a)=='5') {
              fill(Five);
            } 
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                rect(displayX + (a*(scale-0.9)), displayY+((i-start)*(scale-1.2)), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(displayX + (a*(scale-0.9)), displayY+((i-start)*(scale-1.2)), scale, scale);
                }
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + (a*(scale-0.9)), y+((i-start)*(scale-1.2)), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(x + (a*(scale-0.9)), y+((i-start)*(scale-1.2)), scale, scale);
                }
              }
            }
          }
        }
      } else {
        fill(173, 168, 164);
        rect(x+17, y+44, 60, 50);
        triangle(x +17, y +44, x +77, y +44, x +47, y +14);
        fill(255);
        if (Theme.equals("Hell")) {
          fill(255, 225, 214);
        }
        rect(x +20, y +40, 60, 50);
        triangle(x +20, y +40, x +80, y +40, x +50, y +10);
        //strokeWeight(3);
        //stroke(144,142,140);
        //line(x +21, y +40, x +21, y +90);
        //      line(x +21, y +90, x +79, y +90);

        //strokeWeight(0);
        //stroke(255, 0);
        fill(0);
        if (promoted) {

          fill(211, 4, 4);
        }
        if (English) {          
          text(role, x+30, y+55);
        } else {
          if (promoted) {
            x=x +29;
            y=y +33;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {

                  rect(x + (a*2.2), y+(i*2.25), 2.3, 3.3);
                }
              }
            }
          } else {

            x=x +33;
            y=y +38;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {

                  rect(x + (a*2.2), y+(i*2.25), 2.3, 3.3);
                }
              }
            }
          }
        }
      }
    } else {
      if (Theme.equals("Alien")) {
        x+=17;
        y+=10;
        lines = loadStrings(alienDisplay);
        int scale = 4;
        //x+=idleCounter;
        idleCounter+=1;
        if (idleCounter == 360) {
          idleCounter =0;
        }
        if (animating) {
          start = 1;
          end = 26;
          movingCounter +=1;
          scaleY+=2;
          displayX += scaleX;
          displayY += scaleY;

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
            if (lines[i].charAt(a)=='1') {
              fill(One);
            } else if (lines[i].charAt(a)=='2') {
              fill(198, 112, 232);
            } else if (lines[i].charAt(a)=='3') {
              fill(Three);
            } else if (lines[i].charAt(a)=='4') {
              fill(Four);
            } else if (lines[i].charAt(a)=='5') {
              fill(Five);
            } 
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                rect(displayX + (a*(scale-0.9)), displayY+((i-start)*(scale-1.2)), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(displayX + (a*(scale-0.9)), displayY+((i-start)*(scale-1.2)), scale, scale);
                }
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + (a*(scale-0.9)), y+((i-start)*(scale-1.2)), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(x + (a*(scale-0.9)), y+((i-start)*(scale-1.2)), scale, scale);
                }
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
        fill(0);
        if (promoted) {

          fill(211, 4, 4);
        }
        if (English) {          
          text(role, x+30, y+45);
        } else {
          if (promoted) {
            x=x +31;
            y=y +24;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {

                  rect(x + (a*2.2), y+(i*2.25), 2.3, 3.3);
                }
              }
            }
          }
          // TO FLIP THE IMAGES
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
          else {

            x=x +35;
            y=y +26;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {       
                  rect(x + (a*2), y+(i*2.05), 2.3, 3.3);
                }
              }
            }
          }
        }
      }
    }
  }
  void animate(int x, int y, int x1, int y1) {
    animating = true;
    movingCounter = 0;
    displayY = x*100 + 10;
    displayX = y*100 + 17;
    scaleY = ((((x1*100)-(x*100))-(0.5*2*20*20))/20);
    scaleX = ((y1*100)-(y*100))/Stop;
  }
}
