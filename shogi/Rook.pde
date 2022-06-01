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
    promoted=!promoted;
    role="promoted \n rook";
  }
}
