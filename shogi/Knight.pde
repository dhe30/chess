public class Knight extends Piece{
  public Knight(String x){
    super(x);
    role="knight";
  }
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    if(white){
      if(!promoted){
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
        if(x!=0 && y<7){
          int[] downLeftKnight = {x-1, y+2};
          ans.add(downLeftKnight);
        }
        if(x!=8 && y<7){
          int[] downRightKnight = {x+1, y+2};
          ans.add(downRightKnight);
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
    promoted=!promoted;
    role="promoted \n knight";
  }
}
