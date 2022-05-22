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
  //sets down the rooks
  Piece blackRook = new Rook("black");
  Piece whiteRook = new Rook("white");
  Board.board[1][1].setPiece(blackRook);
  Board.board[7][7].setPiece(whiteRook);
  //sets down bishops
  Piece blackBishop = new Bishop("black");
  Piece whiteBishop = new Bishop("white");
  Board.board[1][7].setPiece(blackBishop);
  Board.board[7][1].setPiece(whiteBishop);
  for(int i = 0; i < 9; i++){
    //sets all the pawns down
    Piece blackPawn = new Pawn("black");
    Board.board[2][i].setPiece(blackPawn);
    Piece whitePawn = new Pawn("white");
    Board.board[6][i].setPiece(whitePawn);
    //sets down lances
    if(i==0 || i==8){
      Piece blackLance = new Lance("black");
      Board.board[0][i].setPiece(blackLance);
      Piece whiteLance = new Lance("white");
      Board.board[8][i].setPiece(whiteLance);
    }
    //sets down knights
    if(i==1 || i==7){
      Piece blackKnight = new Knight("black");
      Board.board[0][i].setPiece(blackKnight);
      Piece whiteKnight = new Lance("white");
      Board.board[8][i].setPiece(whiteKnight);
    }
    //sets down silver generals
    if(i==2 || i==6){
      Piece blackSilverGeneral = new SilverGeneral("black");
      Board.board[0][i].setPiece(blackSilverGeneral);
      Piece whiteSilverGeneral = new SilverGeneral("white");
      Board.board[8][i].setPiece(whiteSilverGeneral);
    }
    //sets down gold generals
    if(i==3 || i==5){
      Piece blackGoldGeneral = new GoldGeneral("black");
      Board.board[0][i].setPiece(blackGoldGeneral);
      Piece whiteGoldGeneral = new GoldGeneral("white");
      Board.board[8][i].setPiece(whiteGoldGeneral);
    }
    //sets down kings
    if(i==4){
      Piece blackKing = new King("black");
      Board.board[0][i].setPiece(blackKing);
      Piece whiteKing = new King("white");
      Board.board[8][i].setPiece(whiteKing);
    }
  }
}
void draw(){
  strokeWeight(0);
  stroke(255, 0);
  fill(255);
  textSize(12);
  for(int i = 0; i < 9; i++){
    for(int j = 0; j < 9; j++){
      if(Board.board[i][j].piece!=null){
        if(Board.board[i][j].piece.white==true){
          rect(j*100+20, i*100+40, 60, 50);
          triangle(j*100+20, i*100+40, j*100+80, i*100+40, j*100+50, i*100+10);
          fill(0);
          text(Board.board[i][j].piece.role, j*100+30, i*100+55);
          fill(255);
        }
        else{
          rect(j*100+20, i*100+10, 60, 50);
          triangle(j*100+20, i*100+60, j*100+80, i*100+60, j*100+50, i*100+90);
          fill(0);
          text(Board.board[i][j].piece.role, j*100+30, i*100+45);
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
