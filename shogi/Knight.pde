public class Knight extends Piece {

  public Knight(String x) {
    super(x);
    role="knight";
    display = "horse.txt";
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
    display = "promHorse.txt";
  }
  void demote() {
    promoted=false;
    role="knight";
    display = "horse.txt";
  }
  void displayPiece(int x, int y, boolean white, String line) {

    String[] lines = loadStrings(line);
    if (white) {
      fill(173, 168, 164);
      rect(x+17, y+44, 60, 50);
      triangle(x +17, y +44, x +77, y +44, x +47, y +14);
      fill(255);
      if(Theme.equals("Hell")){
        fill(255,225,214);
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
        x=x +29;
        y=y +33;
        fill(211, 4, 4);
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
    } else {
      fill(173,168,164);
      rect(x +17, y +13, 60, 50);
      triangle(x +17, y +63, x +77, y +63, x +47, y +93);
      fill(255);
      if(Theme.equals("Hell")){
        fill(255,225,214);
      }
      rect(x +20, y +10, 60, 50);
      triangle(x +20, y +60, x +80, y +60, x +50, y +90);
      fill(0);
      if (promoted) {
        x=x +31;
        y=y +24;
        fill(211, 4, 4);
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
