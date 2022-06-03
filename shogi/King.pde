public class King extends Piece {

  public King(String x) {
    super(x);
    role="king";
    display = "king.txt";
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
    if (white) {
      fill(173,168,164);
   rect(x +17, y +44, 60, 50);
      triangle(x +17, y +44, x +77, y +44, x +47, y +14);
      fill(255);
      if(Theme.equals("Hell")){
        fill(255,225,214);
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
