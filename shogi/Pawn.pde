public class Pawn extends Piece{
  public Pawn(String x){
    super(x);
    role="pawn";
  }
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      if(!promoted){
        if(y!=0){
          int[] up = {x, y-1};
          ans.add(up);
        }
      }
      else{
        if(x!=0){
          int[] left={x-1, y};
          ans.add(left);
          if(y!=0){
            int[] upperLeft={x-1, y-1};
            ans.add(upperLeft);
          }
        }
        if(x!=8){
          int[] right={x+1, y};
          ans.add(right);
          if(y!=0){
            int[] upperRight={x+1, y-1};
            ans.add(upperRight);
          }
        }
        if(y!=0){
          int[] up = {x, y-1};
          ans.add(up);
        }
        if(y!=8){
          int[] down = {x, y+1};
          ans.add(down);
        }
      }
    }
    else{
      if(!promoted){
        if(y!=8){
          int[] down = {x, y+1};
          ans.add(down);
        }
      }
      else{
        if(x!=0){
          int[] left={x-1, y};
          ans.add(left);
          if(y!=8){
            int[] downLeft={x-1, y+1};
            ans.add(downLeft);
          }
        }
        if(x!=8){
          int[] right={x+1, y};
          ans.add(right);
          if(y!=8){
            int[] downRight={x+1, y+1};
            ans.add(downRight);
          }
        }
        if(y!=0){
          int[] up = {x, y-1};
          ans.add(up);
        }
        if(y!=8){
          int[] down = {x, y+1};
          ans.add(down);
        }
      }
    }
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote(){
    promoted=true;
    role="promoted\npawn";
  }
  void demote(){
    promoted=false;
    role="pawn";
  }
}
