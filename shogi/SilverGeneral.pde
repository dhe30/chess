public class SilverGeneral extends Piece {
  final color One = color(146, 156, 173);
  final color Two = color(103, 115, 141);
  final color Three = color(178, 184, 194);
  final color Four = color(72, 76, 99);
  final color Five = color(50, 52, 71);
  final color Six = color(224, 50, 91);
  final color Seven = color(181, 41, 85);
  final color Eight = color(0, 0, 0);
  public SilverGeneral(String x) {
    super(x);
    role="silver\ngeneral";
    value=7;
    display = "silver.txt";
    alienDisplay = "silverBot.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    if (white) {
      if (!promoted) {
        if (y!=0) {
          int[] up = {x, y-1};
          ans.add(up);
          if (x!=0) {
            int[] upperLeft = {x-1, y-1};
            ans.add(upperLeft);
          }
          if (x!=8) {
            int[] upperRight = {x+1, y-1};
            ans.add(upperRight);
          }
        }
        if (y!=8 && x!=0) {
          int[] downLeft = {x-1, y+1};
          ans.add(downLeft);
        }
        if (y!=8 && x!=8) {
          int[] downRight = {x+1, y+1};
          ans.add(downRight);
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
        if (y!=8) {
          int[] down = {x, y+1};
          ans.add(down);
          if (x!=0) {
            int[] downLeft = {x-1, y+1};
            ans.add(downLeft);
          }
          if (x!=8) {
            int[] downRight = {x+1, y+1};
            ans.add(downRight);
          }
        }
        if (x!=0 && y!=0) {
          int[] upperLeft = {x-1, y-1};
          ans.add(upperLeft);
        }
        if (x!=8 && y!=0) {
          int[] upperRight = {x+1, y-1};
          ans.add(upperRight);
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
    value=8;
    role="promoted\nsilver\ngeneral";
  }

  void demote() {
    promoted=false;
    role="silver\ngeneral";
    value=7;
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    int start = 1;
    int end = 18;
    if (idleCounter <= 180) {
      start = 1;
      end = 18;
    } else if (idleCounter > 180) {
      start = 19;
      end = 36;
    } else {
      start = 35;
      end = 51;
    }
    if (Theme.equals("Alien")) {
      x+=10;
      y+=10;
      int scale = 4;
      //x+=idleCounter;
      idleCounter+=1;
      if (idleCounter == 360) {
        idleCounter =0;
      }
      if (animating) {
        start = 1;
        end = 18;
        movingCounter +=1;
        scaleY+=0.5;
        displayX += scaleX;
        displayY += scaleY;
        //if (movingCounter >20) {
        //  scaleX= 0;
        //  scaleY= 0;
        //  start = 35;
        //  end = 51;
        //}
      }
      if (white) {
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
            } else if (lines[i].charAt(a)=='8') {
              fill(Eight);
            }
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                rect(displayX + (a*scale), displayY+((i-start)*scale), scale, scale);
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + (a*scale), y+((i-start)*scale), scale, scale);
              }
            }
          }
        }
      } else {
        for (int i = start; i < end; i++) {
          for (int a = lines[i].length() - 1; a >=0; a--) {
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
            }
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                rect(displayX + ((lines[i].length() - a)*scale), displayY+((i-start)*scale), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(displayX + ((lines[i].length() - a)*scale), displayY+((i-start)*scale), scale, scale);
                }
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + ((lines[i].length() - a)*scale), y+((i-start)*scale), scale, scale);
                if (promoted) {
                  fill(225, 225, 36, 70);
                  rect(x + ((lines[i].length() - a)*scale), y+((i-start)*scale), scale, scale);
                }
              }
            }
          }
        }
      }
    } else {
      super.displayPiece(x, y, white, "silver.txt");
    }
  }
  void animate(int x, int y, int x1, int y1) {
    animating = true;
    movingCounter = 0;
    displayY = x*100 + 10;
    displayX = y*100 + 10;
    scaleY = ((((x1*100)-(x*100))-(0.5*0.55*20*20))/20);
    scaleX = ((y1*100)-(y*100))/Stop;
  }
}
