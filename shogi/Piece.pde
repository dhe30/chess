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
  void setPotential(ArrayList<int[]> newMoves) {
    potentialMoves = newMoves;
  }
  void canPromote() {
    canPromote=!canPromote;
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    if (white) {
      fill(255);
      rect(x*100+20, y*100+36, 60, 50);
      triangle(x*100+20, y*100+36, x*100+80, y*100+36, x*100+50, y*100+6);
      fill(0);
      if(promoted){
        fill(211,4,4);
      }
      x=x*100+32;
      y=y*100+33;
      for (int i = 1; i < lines.length; i++) {
        for (int a = 0; a < lines[i].length(); a++) {
          if (lines[i].charAt(a)=='1') {
            
            rect(x + (a*2.5), y+(i*2.55), 2.6, 3.6);
          
          }
        }
      }
    } else {
      fill(255);

      rect(x*100+20, y*100+14, 60, 50);
      triangle(x*100+20, y*100+64, x*100+80, y*100+64, x*100+50, y*100+94);
      fill(0);
if(promoted){
        fill(211,4,4);
      }
      x=x*100+32;
      y=y*100+27;
      int newRow = 0;
      String store1 = "";
      String store2= "";
      for (int i = 1; i <= lines.length / 2; i++) {
        newRow = lines.length - i;
        for (int a = lines[i].length() - 1; a >= 0; a--) {
          store1 += lines[i].substring(a, a+1);
          store2 += lines[newRow].substring(a, a+1);
        }
        lines[i] = store2;
        lines[newRow] = store1;
        store1="";
        store2="";
      }
      for (int i = 1; i < lines.length; i++) {
        for (int a = 0; a < lines[i].length(); a++) {
          if (lines[i].charAt(a)=='1') {       
            rect(x + (a*2.5), y+(i*2.55), 2.6, 3.6);
          }
        }
      }
    }
  }
}
