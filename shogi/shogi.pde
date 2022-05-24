board Board;
boolean Test = false;
ArrayList<Integer> InitialSelected = new ArrayList<Integer>();
boolean Turn = true;
void setup() {
  //The board is 900 by 900, each tile is 100 by 100 
  background(252, 204, 156);
  size(1500, 900);
  Board = new board();
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      Tile tile = new Tile();
      Board.board[i][j]=tile;
    }
  }
  for (int i = 0; i <=9; i++) {
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
  for (int i = 0; i < 9; i++) {
    //sets all the pawns down
    Piece blackPawn = new Pawn("black");
    Board.board[2][i].setPiece(blackPawn);
    Piece whitePawn = new Pawn("white");
    Board.board[6][i].setPiece(whitePawn);
    //sets down lances
    if (i==0 || i==8) {
      Piece blackLance = new Lance("black");
      Board.board[0][i].setPiece(blackLance);
      Piece whiteLance = new Lance("white");
      Board.board[8][i].setPiece(whiteLance);
    }
    //sets down knights
    if (i==1 || i==7) {
      Piece blackKnight = new Knight("black");
      Board.board[0][i].setPiece(blackKnight);
      Piece whiteKnight = new Knight("white");
      Board.board[8][i].setPiece(whiteKnight);
    }
    //sets down silver generals
    if (i==2 || i==6) {
      Piece blackSilverGeneral = new SilverGeneral("black");
      Board.board[0][i].setPiece(blackSilverGeneral);
      Piece whiteSilverGeneral = new SilverGeneral("white");
      Board.board[8][i].setPiece(whiteSilverGeneral);
    }
    //sets down gold generals
    if (i==3 || i==5) {
      Piece blackGoldGeneral = new GoldGeneral("black");
      Board.board[0][i].setPiece(blackGoldGeneral);
      Piece whiteGoldGeneral = new GoldGeneral("white");
      Board.board[8][i].setPiece(whiteGoldGeneral);
    }
    //sets down kings
    if (i==4) {
      Piece blackKing = new King("black");
      Board.board[0][i].setPiece(blackKing);
      Piece whiteKing = new King("white");
      Board.board[8][i].setPiece(whiteKing);
    }
  }
  for (int i = 0; i < Board.board.length; i++) {
    for (int a = 0; a < Board.board[i].length; i++) {
      if (Board.board[i][a].piece != null) {
        if (Board.board[i][a].piece.isRoyal) {
          Board.royalPotential(i, a);
        } else {
          Board.board[i][a].piece.calcPotential(a, i); // calcPotential should not be in RMO
        }
      }
    }
  }
}
void keyPressed() {
  if (key == ' ') {
    Test = !Test;
  }
  if(InitialSelected.size()>0){
    Piece piece = Board.board[InitialSelected.get(1)][InitialSelected.get(0)].piece;
    if(key == 'p' && piece.canPromote){
      piece.promote();
    }
  }
}
void mouseClicked() {
  // ArrayOutOfBounds if click not within 900 * 900 and system crashes
  if (Test) {
    if (Board.board[mouseY / 100][mouseX / 100].piece != null) {
      System.out.println("notNull" + " " + mouseY / 100 + " " + mouseX / 100);
    } else {    
      System.out.println("Null"  + " " + mouseY / 100 + " " + mouseX / 100);
    }
  } else {
    if (mouseX < 900 && mouseY < 900) {
      // ex. mouse at (456,789) refers to tile (4,7)
      if (InitialSelected.size() == 0 && Board.board[mouseY / 100][mouseX / 100].piece != null) {
        if (Board.board[mouseY / 100][mouseX / 100].piece.white == Turn) {
          // adds coordinates to global variable (i.e. selects the piece), only occurs when no piece has been selected 
          InitialSelected.add(mouseX / 100);
          InitialSelected.add(mouseY / 100);
        }
      } else if (InitialSelected.size() > 0) {
        // Only occurs when piece has been selected, row order means x and y switch positions!
        // make new tile piece disappear (it is being replaced by the selected piece)
        if (InitialSelected.get(1) == mouseY/100 && InitialSelected.get(0) == mouseX/100) {
          InitialSelected.clear();
        } else {
          fill(252, 204, 156);
          strokeWeight(1);
          stroke(0);
          rect(mouseX / 100*100, mouseY / 100*100, 100, 100);
          // array logic
          Board.move(InitialSelected.get(1), InitialSelected.get(0), mouseY / 100, mouseX / 100);
          // make old tile piece disappear (because it moved to new tile)
          fill(252, 204, 156);
          strokeWeight(1);
          stroke(0);
          rect(InitialSelected.get(0)*100, InitialSelected.get(1)*100, 100, 100);
          InitialSelected.clear();
          Turn = !Turn;
        }
      }
    }
  }
}
void draw() {
  fill(252, 204, 156);
  rect(0, 0, 900, 900);
  strokeWeight(1);
  stroke(0);
  for (int i = 0; i <=9; i++) {
    line(100*i, 0, 100*i, 900);
    line(0, 100*i, 900, 100*i);
  }
  strokeWeight(0);
  stroke(255, 0);
  textSize(12);
  fill(255);
  /*
  rect(1000, 50, 200, 200);
   fill(0);
   text(xcoor + "", 1100, 100);
   text(ycoor + "", 1150, 100);
   fill(255);
   */
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (Board.board[i][j].piece!=null) {
        if (Board.board[i][j].piece.white==true) {
          rect(j*100+20, i*100+40, 60, 50);
          triangle(j*100+20, i*100+40, j*100+80, i*100+40, j*100+50, i*100+10);
          fill(0);
          text(Board.board[i][j].piece.role, j*100+30, i*100+55);
          fill(255);
        } else {
          rect(j*100+20, i*100+10, 60, 50);
          triangle(j*100+20, i*100+60, j*100+80, i*100+60, j*100+50, i*100+90);
          fill(0);
          text(Board.board[i][j].piece.role, j*100+30, i*100+45);
          fill(255);
        }
      }
    }
    if(Board.board[0][i].piece!=null){
      if(Board.board[0][i].piece.white && (Board.board[0][i].piece.role.equals("knight") || Board.board[0][i].piece.role.equals("pawn") || Board.board[0][i].piece.role.equals("lance"))){
        Board.board[0][i].piece.promote();
      }
      if(Board.board[0][i].piece.white && !Board.board[0][i].piece.promoted && (Board.board[0][i].piece.role.equals("silver\nGeneral") || Board.board[0][i].piece.role.equals("rook") || Board.board[0][i].piece.role.equals("bishop"))){
        Board.board[0][i].piece.canPromote();
      }
    }
    if(Board.board[1][i].piece!=null){
      if(Board.board[1][i].piece.white && Board.board[1][i].piece.role.equals("knight")){
        Board.board[1][i].piece.promote();
      }
      if(Board.board[1][i].piece.white && !Board.board[1][i].piece.promoted && (Board.board[1][i].piece.role.equals("lance") || Board.board[1][i].piece.role.equals("pawn") || 
         Board.board[1][i].piece.role.equals("silver\nGeneral") || Board.board[1][i].piece.role.equals("rook") || Board.board[1][i].piece.role.equals("bishop"))){
        Board.board[1][i].piece.canPromote();
      }
    }
    if(Board.board[2][i].piece!=null){
      if(Board.board[2][i].piece.white && !Board.board[2][i].piece.promoted &&(Board.board[2][i].piece.role.equals("lance") || Board.board[2][i].piece.role.equals("pawn") || 
         Board.board[2][i].piece.role.equals("silver\nGeneral") || Board.board[2][i].piece.role.equals("knight") || Board.board[2][i].piece.role.equals("rook") || Board.board[2][i].piece.role.equals("bishop"))){
        Board.board[2][i].piece.canPromote();
      }
    }
    if(Board.board[8][i].piece!=null){
      if(!Board.board[8][i].piece.white && (Board.board[8][i].piece.role.equals("knight") || Board.board[8][i].piece.role.equals("pawn") || Board.board[8][i].piece.role.equals("lance"))){
        Board.board[8][i].piece.promote();
      }
      if(!Board.board[8][i].piece.white && !Board.board[8][i].piece.promoted && (Board.board[8][i].piece.role.equals("silver\nGeneral")|| Board.board[8][i].piece.role.equals("rook") || Board.board[8][i].piece.role.equals("bishop"))){
        Board.board[8][i].piece.canPromote();
      }
    }
    if(Board.board[7][i].piece!=null){
      if(!Board.board[7][i].piece.white && Board.board[7][i].piece.role.equals("knight")){
        Board.board[7][i].piece.promote();
      }
      if(!Board.board[7][i].piece.white && !Board.board[7][i].piece.promoted && (Board.board[7][i].piece.role.equals("lance") || Board.board[7][i].piece.role.equals("pawn") || 
          Board.board[7][i].piece.role.equals("silver\nGeneral") || Board.board[7][i].piece.role.equals("rook") || Board.board[7][i].piece.role.equals("bishop"))){
        Board.board[7][i].piece.canPromote();
      }
    }
    if(Board.board[6][i].piece!=null){
      if(!Board.board[6][i].piece.white && !Board.board[8][i].piece.promoted && (Board.board[6][i].piece.role.equals("lance") || Board.board[6][i].piece.role.equals("pawn") || 
          Board.board[6][i].piece.role.equals("silver\nGeneral") || Board.board[6][i].piece.role.equals("knight") || Board.board[6][i].piece.role.equals("rook") || Board.board[6][i].piece.role.equals("bishop"))){
        Board.board[6][i].piece.canPromote();
      }
    }
  }
  fill(255);
  rect(900, 0, 1500, 900);
  fill(0);
  textSize(20);
  if(Turn){
    text("white's turn", 950, 50);
  }
  else{
    text("black's turn", 950, 50);
  }
  if (InitialSelected.size() > 0) {
    Piece piece = Board.board[InitialSelected.get(1)][InitialSelected.get(0)].piece;
    if(piece.canPromote){
      fill(13, 178, 46, 150);
      rect(950, 100, 150, 80);
      fill(0);
      text("press 'P'  \n to promote", 960, 120);
    }
    if (piece.potentialMoves.size() == 0) {
      if (piece.isRoyal) {
        Board.royalPotential(InitialSelected.get(1), InitialSelected.get(0));
      } else {
        piece.calcPotential(InitialSelected.get(0), InitialSelected.get(1));
      }
    }
    ArrayList<int [] > list = Board.legalMoves(InitialSelected.get(1), InitialSelected.get(0));
    fill(20, 50);
    for (int i = 0; i < list.size(); i++) {
      int x = list.get(i)[0];
      int y = list.get(i)[1];
      circle(x*100 + 50, y*100+50, 30);
    }
  }
}
public class board {
  ArrayList<Piece> whiteCaptured = new ArrayList();
  ArrayList<Piece> blackCaptured = new ArrayList();
  Tile[][] board = new Tile[9][9];
  public board() {
  }
  void move(int x, int y, int x1, int y1) {
    // if there is a piece on other tile, move to Captured array 
    if (board[x1][y1].piece!=null) {
      if (board[x1][y1].piece.white==true) {
        blackCaptured.add(board[x1][y1].piece);
      } else {
        whiteCaptured.add(board[x1][y1].piece);
      }
    }
    // UNTHREATEN BOTH 
    // NEED TO UNTHREATEN other tile
    if (board[x][y].piece.isRoyal) {
      threaten(x, y); // initially, all threatens are 0, check for that 
      unthreaten(x, y);
    }
    // move current piece to other tile, set current tile's piece to null
    board[x1][y1].setPiece(board[x][y].piece);
    board[x][y].setPiece(null);
    // recalculate royal pieces' moves only if current piece had been blocking them 
    if (board[x][y].royalThreats.size() > 0) {
      for (int i = 0; i < board[x][y].royalThreats.size(); i++) {
        //coordinate pair [0],[1] because r.T is in RMO
        royalPotential(board[x][y].royalThreats.get(i)[0], board[x][y].royalThreats.get(i)[1]);
      }
    }
    // if current is royal, recalculate moves
    if (board[x1][y1].piece.isRoyal) {
      royalPotential(x1, y1); // x then y because move parameters are given in row major order
      threaten(x1, y1); // MOVE OUT OF IF STATEMENT when threaten is generalized
    } else {
      board[x1][y1].piece.calcPotential(y1, x1);
    }
    // current is now moved and may be blocking royals, recalculate royals' moves if so  
    if (board[x1][y1].royalThreats.size() > 0) {
      for (int i = 0; i < board[x1][y1].royalThreats.size(); i++) {
        //coordinate pair [0],[1] because r.T is in RMO
        royalPotential(board[x1][y1].royalThreats.get(i)[0], board[x1][y1].royalThreats.get(i)[1]);
      }
    }
  }
  //ROYAL POTENTIAL IS ALWAYS CALLED IN ROW MAJOR ORDER 
  void royalPotential(int x, int y) {
    System.out.println(x +", " + y);
    ArrayList<int[]> royalMoves = new ArrayList<int[]>();
    boolean crashed = false; // if it hit a piece

    board[x][y].piece.calcPotential(y, x); // separated each direction calculation with an array of {100,100}
    for (int i = 0; i < board[x][y].piece.potentialMoves.size(); i++) {
      int[] coors = board[x][y].piece.potentialMoves.get(i);
      if (coors[0] == 100 && crashed) {
        crashed = false; // hit the end of direction and can continue 
        // next line below: checks if there is a piece and sets crashed to true, does not add anymore until end of direction is hit
      } else if (!crashed && coors[0] != 100) {
        if (board[coors[1]][coors[0]].piece != null) {
          System.out.println(coors[1] + " " + coors[0] + " " + board[coors[1]][coors[0]].piece.role);
          royalMoves.add(coors);
          crashed = true;
        } else {
          System.out.println(coors[1] + " " + coors[0]);
          royalMoves.add(coors);
        }
      }
    }
    String ans ="";
    for (int i = 0; i < royalMoves.size(); i++) {
      ans += "[" + royalMoves.get(i)[0] + "," + royalMoves.get(i)[1] + "], ";

      System.out.println("ROYAL" + ans);
      board[x][y].piece.setPotential((ArrayList)royalMoves.clone());
    }
  }
  // CALL THREATEN and UNTHREATEN IN ROW MAJOR ORDER 
  // THREATEN THREATENS all potentialMoves of piece at x, y (assume row major order), 
  void threaten(int x, int y) {

    for (int i = 0; i < board[x][y].piece.potentialMoves.size(); i++) {
      if (board[x][y].piece.isRoyal) {
        // POTENTIAL MOVES NOT IN ROW MAJOR, SO X AND Y are SWITCHED ------- adding x and y to ROYALTHREATS, x and y are given in row major
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].addRoyalThreat(new int[] {x, y});
      }
      if (board[x][y].piece.white) {
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setWhiteThreats(1);
      } else {
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setBlackThreats(1);
      }
    }
  }
  void unthreaten(int x, int y) {
    for (int i = 0; i < board[x][y].piece.potentialMoves.size(); i++) {
      if (board[x][y].piece.isRoyal) {
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].removeRoyalThreat(new int[] {x, y});
      }
      if (board[x][y].piece.white) {
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setWhiteThreats(-1);
      } else {
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setBlackThreats(-1);
      }
    }
  }
  ArrayList<int[]> legalMoves(int x, int y){
    ArrayList<int[]> ans = new ArrayList();
    Piece piece = board[x][y].piece;
    if(!piece.isRoyal){
      piece.calcPotential(y, x);
    }
    else{
      royalPotential(x,y);
    }
    ans=piece.potentialMoves;
    for(int i = 0; i < ans.size(); i++){
      Tile tile = board[ans.get(i)[1]][ans.get(i)[0]];
      if(tile.piece != null){
        if((tile.piece.white && piece.white) || (!tile.piece.white && !piece.white)){
          ans.remove(i);
          i--;
        }
      }
    }
    return ans;
  }
}
