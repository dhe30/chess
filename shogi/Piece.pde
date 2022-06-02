public class Piece {
  int x, y;
  String role;
  boolean white;
  boolean promoted = false;
  ArrayList<int[]> potentialMoves = new ArrayList<int[]>();
  boolean isRoyal=false;
  boolean canPromote=false;
  String display = "pawn.txt";
  public Piece(String x) {
    if (x.equals("white")) {
      white = true;
    } else {
      white=false;
    }
  }
  void switchSides() {
    white=!white;
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote() {
    promoted=true;
  }
  void demote() {
    promoted=false;
  }
  void setPotential(ArrayList<int[]> newMoves) {
    potentialMoves = newMoves;
  }
  void canPromote() {
    canPromote=!canPromote;
  }
  void displayPiece(int x, int y, boolean white, String line) {
    
    String[] lines = loadStrings(line);
    if (white) {
      fill(173,168,164);
    rect(x+17, y+44, 60, 50);
      triangle(x +17, y +44, x +77, y +44, x +47, y +14);
      fill(255);
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
      x=x +35;
      y=y +38;
      for (int i = 1; i < lines.length; i++) {
        for (int a = 0; a < lines[i].length(); a++) {
          if (lines[i].charAt(a)=='1') {

            rect(x + (a*2), y+(i*2.05), 2.3, 3.3);
          }
        }
      }
    } else {
      fill(173,168,164);
      rect(x +17, y +13, 60, 50);
      triangle(x +17, y +63, x +77, y +63, x +47, y +93);
      fill(255);

      rect(x +20, y +10, 60, 50);
      triangle(x +20, y +60, x +80, y +60, x +50, y +90);
      fill(0);
      if (promoted) {
        fill(211, 4, 4);
      }
      x=x +35;
      y=y +26;
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
      //}
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
