public class Pawn extends Piece{
  public Pawn(String x){
    super(x);
    role="pawn";
  }
  ArrayList<int[]> calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      if(y!=0){
        int[] up = {x, y-1};
        ans.add(up);
      }
    }
    else{
      if(y!=8){
        int[] down = {x, y+1};
        ans.add(down);
      }
    }
    return ans;
  }
}
