board Board;
void setup(){
  background(252,204,156);
  size(1500, 900);
  Board = new board();
  for(int i = 0; i < 9; i++){
    for(int j = 0; j < 9; j++){
      Tile tile = new Tile();
      Board.board[i][j]=tile;
    }
  }
  for(int i = 0; i <=9; i++){
    line(100*i, 0, 100*i, 900);
    line(0, 100*i, 900, 100*i);
  }
  fill(255);
  rect(900, 0, 1500, 900);
  
}
public class board{
  ArrayList<Piece> whiteCaptured = new ArrayList();
  ArrayList<Piece> blackCaptured = new ArrayList();
  Tile[][] board = new Tile[9][9];
  public board(){
  }
}
