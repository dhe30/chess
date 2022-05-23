public class Knight extends Piece{
  public Knight(String x){
    super(x);
    role="knight";
  }
  ArrayList<int[]> calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      if(x!=0 && y>1){
        int[] upperLeftKnight = {x-1, y-2};
        ans.add(upperLeftKnight);
      }
      if(x!=8 && y>1){
        int[] upperRightKnight = {x+1, y-2};
        ans.add(upperRightKnight);
      }
    }
    else{
      if(x!=0 && y<7){
        int[] downLeftKnight = {x-1, y+2};
        ans.add(downLeftKnight);
      }
      if(x!=8 && y<7){
        int[] downRightKnight = {x+1, y+2};
        ans.add(downRightKnight);
      }
    }
    return ans;
  }
}
