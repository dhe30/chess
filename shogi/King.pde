public class King extends Piece {

  public King(String x) {
    super(x);
    role="king";
        display = "pawn.txt";

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
 
}
