public class GoldGeneral extends Piece {
  final color One = color(27, 27, 27);
  final color Two = color(93, 93, 93);
  final color Three = color(59, 59, 59);
  final color Four = color(39, 39, 39);
  final color Five = color(19, 19, 19);
  final color Six = color(254, 237, 86);
  final color Seven = color(31, 75, 99);
  boolean switcher = false;
  public GoldGeneral(String x) {
    super(x);
    role="gold\nGeneral";
    value=8;
    display = "gold.txt";
    alienDisplay="goldBot.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    if (white) {
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
    potentialMoves=(ArrayList)ans.clone();
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    int start = 1;
    int end = 17;
    if (!animating) {
      if (idleCounter <= 180) {
        start = 1;
        end = 17;
      } else if (idleCounter > 180) {
        start = 35;
        end = 50;
      } else {
        start = 35;
        end = 51;
      }
    }
    if (Theme.equals("Alien")) {
      int scale =4;
      //x+=idleCounter;
      idleCounter+=1;
      if (idleCounter == 360) {
        idleCounter=0;
      }
      if (animating) {
        movingCounter +=1;
        if (movingCounter % 2 == 0) {
          if (!switcher) {
            start = 1;
            end = 17;
            switcher = !switcher;
          } else {
            start = 18;
            end = 34;
            // switcher = !switcher;
          }
        }
        displayX += scaleX;
        displayY += scaleY;
        //if (movingCounter >20) {
        //  scaleX= 0;
        //  scaleY= 0;
        //  start = 35;
        //  end = 51;
        //}
      }
      if (!white) {
        x+=10;
        y+=15;
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
                rect(displayX + ((lines[i].length()-a)*scale), displayY+((i-start)*scale), scale, scale);
                if (movingCounter >= Stop) {
                  animating = false;
                }
              } else {
                rect(x + ((lines[i].length()-a)*scale), y+((i-start)*scale), scale, scale);
              }
            }
          }
        }
      } else {
        x+=20;
        y+=15;
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
      }
    } else {
      super.displayPiece(x, y, white, "gold.txt");
    }
  }
  void animate(int x, int y, int x1, int y1) {
    switcher = false;
    animating = true;
    movingCounter = 0;
    displayY = x*100 + 15;
    displayX = y*100 + 10;
    if(white){
      displayX+=10;
    }
    scaleY = ((x1*100)-(x*100))/Stop;
    scaleX = ((y1*100)-(y*100))/Stop;
  }
}
