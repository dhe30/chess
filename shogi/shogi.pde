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
  //sets all the pawns down
  for(int i = 0; i < 9; i++){
    Piece blackPawn = new Pawn("black");
    Board.board[2][i].setPiece(blackPawn);
    Piece whitePawn = new Pawn("white");
    Board.board[6][i].setPiece(whitePawn);
  }
}
void draw(){
  strokeWeight(0);
  stroke(255, 0);
  fill(255);
  for(int i = 0; i < 9; i++){
    for(int j = 0; j < 9; j++){
      if(Board.board[i][j].piece!=null){
        if(Board.board[i][j].piece.white==true){
          rect(j*100+20, i*100+40, 60, 50);
          triangle(j*100+20, i*100+40, j*100+80, i*100+40, j*100+50, i*100+10);
          fill(0);
          text(Board.board[i][j].piece.role, j*100+35, i*100+60);
          fill(255);
        }
        else{
          rect(j*100+20, i*100+10, 60, 50);
          triangle(j*100+20, i*100+60, j*100+80, i*100+60, j*100+50, i*100+90);
          fill(0);
          text(Board.board[i][j].piece.role, j*100+35, i*100+40);
          fill(255);
        }
      }
    }
  }
}
public class board{
  ArrayList<Piece> whiteCaptured = new ArrayList();
  ArrayList<Piece> blackCaptured = new ArrayList();
  Tile[][] board = new Tile[9][9];
  public board(){
  }
}
