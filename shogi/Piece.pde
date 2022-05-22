public class Piece{
  String role;
  boolean white;
  boolean promoted = false;
  ArrayList<int[]> potentialMoves = new ArrayList();
  boolean isRoyal=false;
  public Piece(String x){
    if(x.equals("white")){
      white = true;
    }
    else{
      white=false;
    }
  }
  void switchSides(){
    white=!white;
  }
  ArrayList<int[]> calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    return ans;
  }
  void setMoves(ArrayList<int[]> x){
    potentialMoves=(ArrayList)x.clone();
  }
  void promote(){
    promoted=true;
  }
}
