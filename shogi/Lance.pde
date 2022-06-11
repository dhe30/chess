public class Lance extends Piece {
  final color One = color(92, 83, 84);
  final color Two = color(207, 197, 185);
  final color Three = color(56,49,75);
  final color Four = color(158,150,139);
  final color Five = color(222,221,217);
  final color Six = color(61,90,85);
  final color Seven = color(59,122,69);
  final color Eight = color(113,171,54);
  final color Nine = color(130,121,150);
  final color Ten = color(87,65,101);
  final color Eleven = color(142,71,138);
  final color Twelve = color(231,67,45);

  public Lance(String x) {
    super(x);
    role="lance";
    isRoyal=true;
    value=3;
    display = "lance.txt";
    alienDisplay = "lanceBot.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    if (white) {
      if (!promoted) {
        while (y>0) {
          y--;
          int[] up = {x, y};
          ans.add(up);
        }
        ans.add(new int[]{100, 100});
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
        while (y<8) {
          y++;
          int[] down = {x, y};
          ans.add(down);
        }
        ans.add(new int[]{100, 100});
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
    //String answ ="";
    //  for(int i = 0; i < ans.size(); i++){
    //    answ += "[" + ans.get(i)[0] + "," + ans.get(i)[1] + "], ";
    //  }
    //  System.out.println("NORM" + answ);
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote() {
    promoted=true;
    isRoyal = true;
    role="promoted\nlance";
    value=8;
  }
  void demote() {
    promoted=false;
    isRoyal=true;
    role="lance";
    value=3;
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    int start = 0;
    int end = 0;
    if (idleCounter <= 180) {
      start = 1;
      end = 17;
    } else if (idleCounter > 180) {
      start = 35;
      end = 51;
    } else {
      start = 35;
      end = 51;
    }
    if (Theme.equals("Alien")) {
      int scale = 4;
      //x+=idleCounter;
      idleCounter+=1;
      if (idleCounter == 360) {
        idleCounter =0;
      }
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
          else if (lines[i].charAt(a)=='c') {
            fill(Twelve);
          }
          else if (lines[i].charAt(a)=='8') {
            fill(Eight);
          }
          else if (lines[i].charAt(a)=='9') {
            fill(Nine);
          }
          else if (lines[i].charAt(a)=='a') {
            fill(Ten);
          }
          else if (lines[i].charAt(a)=='b') {
            fill(Eleven);
          }
          if (lines[i].charAt(a)!='0')
            rect(x + (a*scale), y+((i-start)*scale), scale, scale);
        }
      }
    } else {
      super.displayPiece(x, y, white, "lance.txt");
    }
  }
}
