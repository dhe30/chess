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
  void calcPotential(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    potentialMoves=(ArrayList)ans.clone();
  }
  void promote(){
    promoted=true;
  }
}
