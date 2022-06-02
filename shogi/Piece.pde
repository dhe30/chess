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
    rect(x*100+17, y*100+44, 60, 50);
      triangle(x*100+17, y*100+44, x*100+77, y*100+44, x*100+47, y*100+14);
      fill(255);
      rect(x*100+20, y*100+40, 60, 50);
      triangle(x*100+20, y*100+40, x*100+80, y*100+40, x*100+50, y*100+10);
      //strokeWeight(3);
      //stroke(144,142,140);
      //line(x*100+21, y*100+40, x*100+21, y*100+90);
      //      line(x*100+21, y*100+90, x*100+79, y*100+90);

      //strokeWeight(0);
      //stroke(255, 0);
      fill(0);
      if (promoted) {
        fill(211, 4, 4);
      }
      x=x*100+35;
      y=y*100+38;
      for (int i = 1; i < lines.length; i++) {
        for (int a = 0; a < lines[i].length(); a++) {
          if (lines[i].charAt(a)=='1') {

            rect(x + (a*2), y+(i*2.05), 2.3, 3.3);
          }
        }
      }
    } else {
      fill(255);

      rect(x*100+20, y*100+10, 60, 50);
      triangle(x*100+20, y*100+60, x*100+80, y*100+60, x*100+50, y*100+90);
      fill(0);
      if (promoted) {
        fill(211, 4, 4);
      }
      x=x*100+35;
      y=y*100+26;
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
