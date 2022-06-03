public class Rook extends Piece {

  public Rook(String x) {
    super(x);
    role="rook";
    isRoyal=true;
    display = "rook.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    int ogX = x;
    int ogY = y;
    while (x<8) {
      x++;
      int[] right = {x, y};
      ans.add(right);
    }     
    ans.add(new int[]{100, 100});

    x=ogX;
    y=ogY;
    while (x>0) {
      x--;
      int[] left = {x, y};
      ans.add(left);
    }    
    ans.add(new int[]{100, 100});

    x=ogX;
    y=ogY;
    while (y<8) {
      y++;
      int[] down = {x, y};
      ans.add(down);
    }    
    ans.add(new int[]{100, 100});

    x=ogX;
    y=ogY;
    while (y>0) {
      y--;
      int[] up = {x, y};
      ans.add(up);
    }    
    ans.add(new int[]{100, 100});

    if (promoted) {
      if (ogX!=0 && ogY!=0) {
        int[] upperLeft = {ogX-1, ogY-1};
        ans.add(upperLeft);
      }    
      ans.add(new int[]{100, 100});

      if (ogX!=0 && ogY!=8) {
        int[] downLeft = {ogX-1, ogY+1};
        ans.add(downLeft);
      }    
      ans.add(new int[]{100, 100});

      if (ogX!=8 && ogY!=0) {
        int[] upperRight = {ogX+1, ogY-1};
        ans.add(upperRight);
      }    
      ans.add(new int[]{100, 100});

      if (ogX!=8 && ogY!=8) {
        int[] downRight = {ogX+1, ogY+1};
        ans.add(downRight);
      }    
      ans.add(new int[]{100, 100});
    }
    potentialMoves=(ArrayList)ans.clone();
  }

  void promote() {
    promoted=true;
    role="promoted\nrook";
    display = "promRook.txt";
  }
  void demote() {
    promoted=false;
    role="rook";
    display = "rook.txt";
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    if (white) {
      fill(173, 168, 164);
      rect(x +17, y +44, 60, 50);
      triangle(x +17, y +44, x +77, y +44, x +47, y +14);
      fill(255);
      if(Theme.equals("Hell")){
        fill(255,225,214);
      }
      rect(x +20, y +40, 60, 50);
      triangle(x +20, y +40, x +80, y +40, x +50, y +10);
      fill(0);
      if (promoted) {
        fill(211, 4, 4);
        x=x +30;
        y=y +38;
        for (int i = 1; i < lines.length; i++) {
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='1') {
              rect(x + (a*2.6), y+(i*2.4), 2.6, 2.5);
            }
          }
        }
      } else {
        x=x +35;
        y=y +38;
        for (int i = 1; i < lines.length; i++) {
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='1') {
              rect(x + (a*2.2), y+(i*1.9), 2.2, 3.6);
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

      if (promoted) {
        fill(211, 4, 4);
        x=x +30;
        y=y +27;
        for (int i = 1; i < lines.length; i++) {
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='1') {
              rect(x + (a*2.6), y+(i*2.4), 2.6, 2.5);
            }
          }
        }
      } else {
      x=x +35;
      y=y +30;
        for (int i = 1; i < lines.length; i++) {
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='1') {
              rect(x + (a*2.2), y+(i*1.9), 2.2, 3.6);
            }
          }
        }
      }
    }
  }
}
