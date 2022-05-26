public class Tile{
  Piece piece;
  int whiteThreatened=0;
  int blackThreatened=0;
  ArrayList<int[]> royalThreats = new ArrayList<int[]>(); // THIS SHALL BE IN ROW MAJOR ORDER
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
  void removeRoyalThreat(int[] a){
    System.out.println(a[0] + " "+ a[1]);
    royalThreats.remove(getRoyalThreatIndex(a));
  }
  void addRoyalThreat(int[] a){
    royalThreats.add(a);
  }
  int getRoyalThreatIndex(int[] a){
    int x = a[0];
    int y = a[1];
    for (int i = 0; i < royalThreats.size(); i++){
      if(royalThreats.get(i)[0] == x && royalThreats.get(i)[1] == y){
        return i;
      }
    }
    return -1;
  }
}
