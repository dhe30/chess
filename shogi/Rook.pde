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
      x++;
      int[] right = {x, y};
      ans.add(right);
    }
    x=ogX;
    y=ogY;
    while(x>0){
      x--;
      int[] left = {x, y};
      ans.add(left);
    }
    x=ogX;
    y=ogY;
    while(y<8){
      y++;
      int[] down = {x, y};
      ans.add(down);
    }
    x=ogX;
    y=ogY;
    while(y>0){
      y--;
      int[] up = {x, y};
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
  void promote(){
    promoted=!promoted;
    role="promoted \n rook";
  }
}
