public class Piece{
  String role;
  boolean white;
  boolean promoted = false;
  ArrayList<int[]> potentialMoves = new ArrayList();
  boolean isRoyal;
  public Piece(String x){
    if(x.equals("white")){
      white = true;
    }
    else{
      white=false;
    }
  }
}
