public class Rook extends Piece{
  public Rook(String x){
    super(x);
    role="rook";
    isRoyal=true;
  }
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    int ogX = x;
    int ogY = y;
    while(x<8){
      int[] right = {x+1, y};
      ans.add(right);
    }
    x=ogX;
    y=ogY;
    while(x>0){
      int[] left = {x-1, y};
      ans.add(left);
    }
    x=ogX;
    y=ogY;
    while(y<8){
      int[] down = {x, y+1};
      ans.add(down);
    }
    x=ogX;
    y=ogY;
    while(y>0){
      int[] up = {x, y-1};
      ans.add(up);
    }
    if(promoted){
      if(ogX!=0 && ogY!=0){
        int[] upperLeft = {x-1, y-1};
        ans.add(upperLeft);
      }
      if(ogX!=0 && ogY!=8){
        int[] downLeft = {x-1, y+1};
        ans.add(downLeft);
      }
      if(ogX!=8 && ogY!=0){
        int[] upperRight = {x+1, y-1};
        ans.add(upperRight);
      }
      if(ogX!=8 && ogY!=8){
        int[] downRight = {x+1, y+1};
        ans.add(downRight);
      }
    }
    potentialMoves=(ArrayList)ans.clone();
  }
}
