public class Lance extends Piece{
  public Lance(String x){
    super(x);
    role="lance";
    isRoyal=true;
  }
  ArrayList<int[]> calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      while(y>0){
        int[] up = {x, y-1};
        ans.add(up);
      }
    }
    else{
      while(y<8){
        int[] down = {x, y+1};
        ans.add(down);
      }
    }
    return ans;
  }
}
