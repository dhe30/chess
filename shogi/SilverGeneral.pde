public class SilverGeneral extends Piece{
  public SilverGeneral(String x){
    super(x);
    role="silver\nGeneral";
  }
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      if(y!=0){
        int[] up = {x, y-1};
        ans.add(up);
        if(x!=0){
          int[] upperLeft = {x-1, y-1};
          ans.add(upperLeft);
        }
        if(x!=8){
          int[] upperRight = {x+1, y-1};
          ans.add(upperRight);
        }
      }
      if(y!=8 && x!=0){
        int[] downLeft = {x-1, y+1};
        ans.add(downLeft);
      }
      if(y!=8 && x!=8){
        int[] downRight = {x+1, y+1};
        ans.add(downRight);
      }
    }
    else{
      if(y!=8){
        int[] down = {x, y+1};
        ans.add(down);
        if(x!=0){
          int[] downLeft = {x-1, y+1};
          ans.add(downLeft);
        }
        if(x!=8){
          int[] downRight = {x+1, y+1};
          ans.add(downRight);
        }
      }
      if(x!=0 && y!=0){
        int[] upperLeft = {x-1, y-1};
        ans.add(upperLeft);
      }
      if(x!=8 && y!=0){
        int[] upperRight = {x+1, y-1};
        ans.add(upperRight);
      }
    }
    potentialMoves=(ArrayList)ans.clone();
  }
}
