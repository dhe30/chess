public class Bishop extends Piece{
  public Bishop(String x){
    super(x);
    role="bishop";
    isRoyal=true;
  }
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    int ogX = x;
    int ogY = y;
    while(x>0 && y>0){
      int[] move = {x-1, y-1};
      ans.add(move);
    }
    x=ogX;
    y=ogY;
    while(x>0 && y<8){
      int[] move = {x-1, y+1};
      ans.add(move);
    }
    x=ogX;
    y=ogY;
    while(x<8 && y>0){
      int[] move = {x+1, y+1};
      ans.add(move);
    }
    x=ogX;
    y=ogY;
    while(x<8 && y<8){
      int[] move = {x+1, y+1};
      ans.add(move);
    }
    if(promoted){
      if(ogX!=8){
        int[] right = {ogX +1, ogY};
        ans.add(right);
      }
      if(ogX!=0){
        int[] left = {ogX -1, ogY};
        ans.add(left);
      }
      if(ogY!=0){
      int[] up = {ogX, ogY-1};
      ans.add(up);
      }
      if(ogY!=8){
        int[] down = {ogX, ogY+1};
        ans.add(down);
      }
    }
    potentialMoves=(ArrayList)ans.clone();
  }
}
