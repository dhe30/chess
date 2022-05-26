public class Piece {
  String role;
  boolean white;
  boolean promoted = false;
  ArrayList<int[]> potentialMoves = new ArrayList<int[]>();
  boolean isRoyal=false;
  boolean canPromote=false;
  boolean protector = false;
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
  void canPromote(){
    canPromote=!canPromote;
  }
  void setProtector(boolean a){
    protector = a;
  }
}
