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
      x--;
      y--;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100,100});
    x=ogX;
    y=ogY;
    while(x>0 && y<8){
      x--;
      y++;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100,100});
    x=ogX;
    y=ogY;
    while(x<8 && y>0){
      x++;
      y--;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100,100});
    x=ogX;
    y=ogY;
    while(x<8 && y<8){
      x++;
      y++;
      int[] move = {x, y};
      ans.add(move);
    }
    ans.add(new int[]{100,100});
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
    //String answ ="";
    //  for(int i = 0; i < ans.size(); i++){
    //    answ += "[" + ans.get(i)[0] + "," + ans.get(i)[1] + "], ";
    //  }
    //  System.out.println("NORM" + answ);
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote(){
    promoted=!promoted;
    role="promoted \n bishop";
  }
}
