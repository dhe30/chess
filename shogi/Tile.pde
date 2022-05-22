public class Tile{
  Piece piece;
  int whiteThreatened=0;
  int blackThreatened=0;
  ArrayList<int[]> royalThreats = new ArrayList();
  public Tile(){
  }
  void setPiece(Piece other){
    piece=other;
  }
  void setWhiteThreats(int a){
    whiteThreatened+=a;
    if(whiteThreatened<0){
      whiteThreatened=0;
    }
  }
  void setBlackThreats(int a){
    blackThreatened+=a;
    if(blackThreatened<0){
      blackThreatened=0;
    }
  }
}
