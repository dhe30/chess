public class Lance extends Piece{
  public Lance(String x){
    super(x);
    role="lance";
    isRoyal=true;
  }
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      while(y>0){
        y--;
        int[] up = {x, y};
        ans.add(up);
      }
    }
    else{
      while(y<8){
        y++;
        int[] down = {x, y};
        ans.add(down);
      }
    }
    potentialMoves=(ArrayList)ans.clone();
  }
}
