import java.util.*;
import java.io.*;
board Board;
boolean Test = false;
ArrayList<Integer> InitialSelected = new ArrayList<Integer>();
boolean Turn = true;
boolean showPromote = false;
boolean selected = false;
boolean sameRow=false;
boolean canDrop=true;
boolean Tutorial=false;
boolean showTutorial=true;
boolean onePlayer=false;
boolean showOnePlayer=true;
int tutorialIndex=0;
ArrayList<int[]> moves = new ArrayList<int[]>();
ArrayList<String> pieceMoved = new ArrayList<String>();
int count = 0;
void setup() {
  //The board is 900 by 900, each tile is 100 by 100 
  background(252, 204, 156);
  size(1800, 900);
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
  fill(180);
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
    for (int a = 0; a < Board.board[i].length; a++) {
      if (Board.board[i][a].piece != null) {
        if (Board.board[i][a].piece.isRoyal) {

          Board.royalPotential(i, a);
        } else {
          Board.board[i][a].piece.calcPotential(a, i); // calcPotential should not be in RMO
        }
        Board.threaten(i, a);
      }
    }
  }
}
void keyPressed() {
  if(Tutorial){
    if(key== '2'){
      tutorialIndex++;
    }
    if(key== '1'){
      tutorialIndex--;
      if(tutorialIndex<0){
        tutorialIndex=0;
      }
    }
  }
  if(key=='t'){
    Tutorial=true;
    showTutorial=false;
  }
  if(key=='l'){
    onePlayer=true;
    showOnePlayer=false;
    showTutorial=false;
  }
  if (key == ' ') {
    Test = !Test;
  }
  if (InitialSelected.size()>0) {
    Piece piece = Board.board[InitialSelected.get(1)][InitialSelected.get(0)].piece;
    if (key == 'p' && piece.canPromote) {
      showPromote=false;
      piece.canPromote=false;
      Board.unthreaten(InitialSelected.get(1), InitialSelected.get(0));

      piece.promote();
      if (piece.isRoyal) {
        Board.royalPotential(InitialSelected.get(1), InitialSelected.get(0));
      } else {
        Board.board[InitialSelected.get(1)][InitialSelected.get(0)].piece.calcPotential(InitialSelected.get(0), InitialSelected.get(1));
      }
      Board.threaten(InitialSelected.get(1), InitialSelected.get(0));

      InitialSelected.clear();
      Turn=!Turn;
      Board.revertPreviousPreventCheck();
      Board.preventCheck();
      Board.checkCheck();
    } else if (key == 'x' && piece.canPromote) {
      showPromote=false;
      InitialSelected.clear();
      Turn = !Turn;
      System.out.println("PROMOTE TURN");
      Board.revertPreviousPreventCheck();
      Board.preventCheck();
      Board.checkCheck();
    }
  }
}
void mouseClicked() {
  showTutorial=false;
  showOnePlayer=false;
  // ArrayOutOfBounds if click not within 900 * 900 and system crashes
  if (Test) {
    if (Board.board[mouseY / 100][mouseX / 100].piece != null) {
      System.out.println("notNull" + " " + mouseY / 100 + " " + mouseX / 100);
    } else {    
      System.out.println("Null"  + " " + mouseY / 100 + " " + mouseX / 100);
    }
    System.out.println("WHit threats:"  + " "+ Board.board[mouseY / 100][mouseX / 100].whiteThreatened + " Black threats: " + Board.board[mouseY / 100][mouseX / 100].blackThreatened);
  } else {
    if (mouseX < 900 && mouseY < 900) {
      // ex. mouse at (456,789) refers to tile (4,7)
      if (InitialSelected.size() == 0 && Board.board[mouseY / 100][mouseX / 100].piece != null) {
        canDrop=true;
        if (Board.board[mouseY / 100][mouseX / 100].piece.white == Turn) {
          // adds coordinates to global variable (i.e. selects the piece), only occurs when no piece has been selected 
          InitialSelected.add(mouseX / 100);
          InitialSelected.add(mouseY / 100);
          selected=true;
        }
      } else if (InitialSelected.size() > 1 && selected) {
        // Only occurs when piece has been selected, row order means x and y switch positions!
        // make new tile piece disappear (it is being replaced by the selected piece)
        if (InitialSelected.get(1) == mouseY/100 && InitialSelected.get(0) == mouseX/100) {
          InitialSelected.clear();
          selected=false;
        } else {
          Piece piece = Board.board[InitialSelected.get(1)][InitialSelected.get(0)].piece;
          fill(252, 204, 156);
          strokeWeight(1);
          stroke(0);
          rect(mouseX / 100*100, mouseY / 100*100, 100, 100);
          // array logic
          boolean didMove = Board.move(InitialSelected.get(1), InitialSelected.get(0), mouseY / 100, mouseX / 100);
          if (InitialSelected.get(1)==mouseY/100) {
            sameRow=true;
          }
          selected=false;
          InitialSelected.clear();
          InitialSelected.add(mouseX / 100);
          InitialSelected.add(mouseY / 100);
          for (int i = 0; i < 9; i++) {
            if (Board.board[0][i].piece!=null) {
              if (Board.board[0][i].piece.white && (Board.board[0][i].piece.role.equals("knight") || Board.board[0][i].piece.role.equals("pawn") || Board.board[0][i].piece.role.equals("lance"))) {
                Board.board[0][i].piece.promote();
                if(Board.board[0][i].piece.canPromote){
                  Board.board[0][i].piece.canPromote();
                }
              }
              if (Board.board[0][i].piece.white && !Board.board[0][i].piece.promoted && !Board.board[0][i].piece.canPromote && (Board.board[0][i].piece.role.equals("silver\ngeneral") || Board.board[0][i].piece.role.equals("rook") || Board.board[0][i].piece.role.equals("bishop"))) {
                Board.board[0][i].piece.canPromote();
              }
            }
            if (Board.board[1][i].piece!=null) {
              if (Board.board[1][i].piece.white && Board.board[1][i].piece.role.equals("knight")) {
                Board.board[1][i].piece.promote();
              }
              if (Board.board[1][i].piece.white && !Board.board[1][i].piece.promoted && !Board.board[1][i].piece.canPromote && (Board.board[1][i].piece.role.equals("lance") || Board.board[1][i].piece.role.equals("pawn") || 
                Board.board[1][i].piece.role.equals("silver\ngeneral") || Board.board[1][i].piece.role.equals("rook") || Board.board[1][i].piece.role.equals("bishop"))) {
                Board.board[1][i].piece.canPromote();
              }
            }
            if (Board.board[2][i].piece!=null) {
              if (Board.board[2][i].piece.white && !Board.board[2][i].piece.promoted && !Board.board[2][i].piece.canPromote &&(Board.board[2][i].piece.role.equals("lance") || Board.board[2][i].piece.role.equals("pawn") || 
                Board.board[2][i].piece.role.equals("silver\ngeneral") || Board.board[2][i].piece.role.equals("knight") || Board.board[2][i].piece.role.equals("rook") || Board.board[2][i].piece.role.equals("bishop"))) {
                Board.board[2][i].piece.canPromote();
              }
            }
            if (Board.board[8][i].piece!=null) {
              if (!Board.board[8][i].piece.white && (Board.board[8][i].piece.role.equals("knight") || Board.board[8][i].piece.role.equals("pawn") || Board.board[8][i].piece.role.equals("lance"))) {
                Board.board[8][i].piece.promote();
                if(Board.board[8][i].piece.canPromote){
                  Board.board[8][i].piece.canPromote();
                }
              }
              if (!Board.board[8][i].piece.white && !Board.board[8][i].piece.promoted && !Board.board[8][i].piece.canPromote && (Board.board[8][i].piece.role.equals("silver\ngeneral")|| Board.board[8][i].piece.role.equals("rook") || Board.board[8][i].piece.role.equals("bishop"))) {
                Board.board[8][i].piece.canPromote();
              }
            }
            if (Board.board[7][i].piece!=null) {
              if (!Board.board[7][i].piece.white && Board.board[7][i].piece.role.equals("knight")) {
                Board.board[7][i].piece.promote();
              }
              if (!Board.board[7][i].piece.white && !Board.board[7][i].piece.promoted && !Board.board[7][i].piece.canPromote && (Board.board[7][i].piece.role.equals("lance") || Board.board[7][i].piece.role.equals("pawn") || 
                Board.board[7][i].piece.role.equals("silver\ngeneral") || Board.board[7][i].piece.role.equals("rook") || Board.board[7][i].piece.role.equals("bishop"))) {
                Board.board[7][i].piece.canPromote();
              }
            }
            if (Board.board[6][i].piece!=null) {
              if (!Board.board[6][i].piece.white && !Board.board[6][i].piece.promoted && !Board.board[6][i].piece.canPromote && (Board.board[6][i].piece.role.equals("lance") || Board.board[6][i].piece.role.equals("pawn") || 
                Board.board[6][i].piece.role.equals("silver\ngeneral") || Board.board[6][i].piece.role.equals("knight") || Board.board[6][i].piece.role.equals("rook") || Board.board[6][i].piece.role.equals("bishop"))) {
                Board.board[6][i].piece.canPromote();
              }
            }
            if (Board.board[4][i].piece!=null) {
              if (Board.board[4][i].piece.canPromote) {
                Board.board[4][i].piece.canPromote();
              }
            }
            if (Board.board[3][i].piece!=null) {
              if (Board.board[3][i].piece.white && Board.board[3][i].piece.canPromote && sameRow) {
                Board.board[3][i].piece.canPromote();
              }
            }
            if (Board.board[5][i].piece!=null) {
              if (!Board.board[5][i].piece.white && Board.board[5][i].piece.canPromote && sameRow) {
                Board.board[5][i].piece.canPromote();
              }
            }
          }
          if (piece.canPromote) {
            showPromote=true;
          }
          if (piece.potentialMoves.size() == 0) {
            if (piece.isRoyal) {
              Board.royalPotential(InitialSelected.get(1), InitialSelected.get(0));
            } else {
              piece.calcPotential(InitialSelected.get(0), InitialSelected.get(1));
            }
          }
          // make old tile piece disappear (because it moved to new tile)
          fill(252, 204, 156);
          strokeWeight(1);
          stroke(0);
          rect(InitialSelected.get(0)*100, InitialSelected.get(1)*100, 100, 100);
          if (!piece.canPromote) {
            InitialSelected.clear();
            if(didMove){
              Turn = !Turn;
            }
            System.out.println("Love");
            Board.revertPreviousPreventCheck();
            Board.preventCheck(); // do this at the start of a turn, it goes after turn = nextTurn because that is when the nextTurn first begins
            Board.checkCheck();
          }
        }
      }
      else if(InitialSelected.size()==1){
        canDrop=true;
        if (Board.drop(InitialSelected.get(0), mouseX/100, mouseY/100)==false) {
          canDrop=false;
          InitialSelected.clear();
        } else {
          InitialSelected.clear();
          Turn=!Turn;
          Board.revertPreviousPreventCheck();
          Board.preventCheck();
          Board.checkCheck();
        }
      }
    } else {
      canDrop=true;
      if(InitialSelected.size() == 1){
        InitialSelected.clear();
      } else {
        if(Turn){
          for (int i = 0; i < Board.whiteCaptured.size(); i++) {
            Piece piece = Board.whiteCaptured.get(i);
            if (mouseX>=piece.x && mouseX<=piece.x+60 && mouseY>=piece.y && mouseY<=piece.y+50) {
              InitialSelected.add(i);
            }
          }
        }
        else{
          for (int i = 0; i < Board.blackCaptured.size(); i++) {
            Piece piece = Board.blackCaptured.get(i);
            if (mouseX>=piece.x && mouseX<=piece.x+60 && mouseY>=piece.y && mouseY<=piece.y+50) {
              InitialSelected.add(i);
            }
          }
        }
      }
    }
  }
}
void draw() {
  if(!Tutorial){
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
    }
  }
  fill(180);
  rect(900, 0, 1500, 900);
  fill(0);
  textSize(20);
  if(!Tutorial){
    if (Turn) {
      text("white's turn", 950, 50);
    } else {
      text("black's turn", 950, 50);
    }
  }
  if (Board.checkmate) {
    text("YOU HAVE BEEN MATED!", 950, 75);
  }
  if (showPromote) {
    fill(13, 178, 46, 150);
    rect(950, 100, 160, 150);
    fill(0);
    textSize(20);
    text("press 'P'  \r\nto promote \npress 'X' \r\nto not promote", 960, 120);
  }
  if(showTutorial){
    fill(3, 186, 252, 150);
    rect(950, 100, 160, 70);
    fill(0);
    text("Press 'T' for \ntutorial", 960, 120);
  }
  if(showOnePlayer){
    fill(#6e2ad5, 150);
    rect(950, 180, 160, 100);
    fill(0);
    text("Press 'L' \nfor one \nplayer mode", 960, 200);
  }
  if (InitialSelected.size() > 1) {
    ArrayList<int [] > list = Board.legalMoves(InitialSelected.get(1), InitialSelected.get(0));
    fill(20, 50);
    for (int i = 0; i < list.size(); i++) {
      int x = list.get(i)[0];
      int y = list.get(i)[1];
      circle(x*100 + 50, y*100+50, 30);
    }
    rect(InitialSelected.get(0)*100, InitialSelected.get(1)*100, 100, 100);
  }
  textSize(12);
  int x=0;
  for (int i = 0; i < Board.whiteCaptured.size(); i++) {
    if (x==8) {
      x=0;
    }
    int j=i/8;
    fill(255);
    rect(x*100+950, j*100+640, 60, 50);
    triangle(x*100+950, j*100+640, x*100+1010, j*100+640, x*100+980, j*100+610);
    Board.whiteCaptured.get(i).x=x*100+950;
    Board.whiteCaptured.get(i).y=j*100+640;
    fill(0);
    text(Board.whiteCaptured.get(i).role, x*100+960, j*100+655);
    x++;
  }
  x=0;
  for (int i = 0; i < Board.blackCaptured.size(); i++) {
    if (x==8) {
      x=0;
    }
    int j=i/8;
    fill(255);
    rect(x*100+950, j*100+310, 60, 50);
    triangle(x*100+950, j*100+360, x*100+1010, j*100+360, x*100+980, j*100+390);
    Board.blackCaptured.get(i).x=x*100+950;
    Board.blackCaptured.get(i).y=j*100+310;
    fill(0);
    text(Board.blackCaptured.get(i).role, x*100+960, j*100+345);
    x++;
  }
  if(InitialSelected.size()==1){
    if(Turn){
      text("selected " + Board.whiteCaptured.get(InitialSelected.get(0)).role, 950, 100);
    }
    else{
      text("selected " + Board.blackCaptured.get(InitialSelected.get(0)).role, 950, 100);
    }
  }
  if(!canDrop){
    text("can't drop piece there", 950, 100);
  }
  if(onePlayer && !Turn){
    if(Board.blackCaptured.size()>2){
      if(oneDrop()){
        Turn=!Turn;
      }
      else{
        botMove();
        Turn=true;
      }
    }
      botMove();
      Turn=true;
  }
  fill(#b27e4d);
  rect(1200, 5, 430, 302);
  stroke(0);
  strokeWeight(1);
  line(1420, 5, 1420, 305);
  line(1520, 5, 1520, 305);
  for(int i = 0; i < 9; i++){
    line(1200, i*30+35, 1630, i*30+35);
  }
  if(moves.size()>10){
    moves.remove(0);
  }
  if(pieceMoved.size()>10){
    pieceMoved.remove(0);
  }
  for(int i = moves.size()-1; i >= 0; i--){
    fill(0);
    text(pieceMoved.get(i), 1210, i*30+35);
    text(moves.get(i)[0], 1430, i*30+35);
    text(moves.get(i)[1], 1530, i*30+35);
  }
  textSize(30);
  if(Tutorial){
    switch(tutorialIndex){
      case 0:
        PImage pawn = loadImage("pawn.jpg");
        image(pawn, 0, 0, 900, 900); 
        text("pawns move like normal pawns \nbut can't move two spaces on the first move \nand can't capture diagonally. \nThey can only capture what is right in front of them", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 1: 
        PImage rook = loadImage("rook.jpg");
        image(rook, 0, 0, 900, 900);
        text("rook moves like a rook...not much else to say", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 2:
        PImage bishop = loadImage("bishop.jpg");
        image(bishop, 0, 0, 900, 900);
        text("bishop moves like a bishop...what a surprise", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 3:
        PImage lance = loadImage("lance.jpg");
        image(lance, 0, 0, 900, 900);
        text("lance moves like a rook \nbut only forwards", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 4:
        PImage knight = loadImage("knight.jpg");
        image(knight, 0, 0, 900, 900);
        text("knight moves similar to a normal knight \nbut only forwards", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 5:
        PImage silverGeneral = loadImage("silverGeneral.jpg");
        image(silverGeneral, 0, 0, 900, 900);
        text("silver general can move diagonally forwards one space, \nforward one space, \nor diagonally backward once space", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 6:
        PImage goldGeneral = loadImage("goldGeneral.jpg");
        image(goldGeneral, 0, 0, 900, 900);
        text("gold generals can move diagonally forwards one space, \nforwards one space, \nsideways one space, \nor backwards one space", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 7:
        PImage king = loadImage("king.jpg");
        image(king, 0, 0, 900, 900);
        text("king is a king", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 8:
        PImage promotedPawn = loadImage("promotedPawn.jpg");
        image(promotedPawn, 0, 0, 450, 450);
        PImage promotedLance = loadImage("promotedLance.jpg");
        image(promotedLance, 450, 0, 450, 450);
        PImage promotedKnight = loadImage("promotedKnight.jpg");
        image(promotedKnight, 0, 450, 450, 450);
        PImage promotedSilverGeneral = loadImage("promotedSilverGeneral.jpg");
        image(promotedSilverGeneral, 450, 450, 450, 450);
        text("promoted pawn, lance, knight, and silver general \nall move like a gold general", 950, 50);
        textSize(14);
        text("yes i know they're not in line screenshotting is hard ok", 950, 400);
        textSize(30);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 9: 
        PImage promotedRook = loadImage("promotedRook.jpg");
        image(promotedRook, 0, 0, 900, 900);
        text("promoted rook moves like a normal rook \nbut can also move in any diagonal direction one space", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 10:
        PImage promotedBishop = loadImage("promotedBishop.jpg");
        image(promotedBishop, 0, 0, 900, 900);
        text("Similar to promoted rook, \npromoted bishop can move like a normal bishop \nbut can also move up, down, left, or right one space", 950, 50);
        text("press 1 or 2 to scroll through tutorial", 950, 600);
        break;
      case 11:
        Tutorial=false;
        break;
    }
  }
}
boolean oneDrop(){
  int index = (int)(Math.random()*Board.blackCaptured.size()-1);
  for(int i = 0; i < 9; i++){
    for(int j = 0; j < 9; j++){
      if(Board.board[i][j].piece==null){
        int rand = (int)(Math.random()*10);
        if(Board.drop(index, i, j) && rand%2==0){
          return true;
         }
      }
    }
  }
  return false;
}
boolean botMove(){
  int xCor = (int)(Math.random()*9);
  int yCor = (int)(Math.random()*9);
  if(Board.board[yCor][xCor].piece!=null){
    if(!Board.board[yCor][xCor].piece.white){
      if(Board.legalMoves(yCor, xCor).size() > 0){
        ArrayList<int[]> lMoves = Board.legalMoves(yCor, xCor);
        for(int i = 0; i < lMoves.size(); i++){
          if(Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece!=null){
            Board.move(yCor, xCor, lMoves.get(i)[1], lMoves.get(i)[0]);
            if(lMoves.get(i)[1]>=6 && (Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.role.equals("rook") || Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.role.equals("bishop") || 
            Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.role.equals("pawn") || Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.role.equals("lance") || 
            Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.role.equals("silver\ngeneral") || Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.role.equals("knight"))){
              Board.board[lMoves.get(i)[1]][lMoves.get(i)[0]].piece.promote();
            }
            return true;
          }
        }
        int r = (int)(Math.random() * lMoves.size());
        Board.move(yCor, xCor, lMoves.get(r)[1], lMoves.get(r)[0]); 
        if(lMoves.get(r)[1]>=6 && (Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.role.equals("rook") || Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.role.equals("bishop") || 
            Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.role.equals("pawn") || Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.role.equals("lance") || 
            Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.role.equals("silver\ngeneral") || Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.role.equals("knight"))){
              Board.board[lMoves.get(r)[1]][lMoves.get(r)[0]].piece.promote();
            }
        return true;
      }
      else{
        return botMove();
      }
    }
    else{
      return botMove();
    }
  }
  else{
    return botMove();
  }
}
public class board {
  boolean checkmate = false;
  int[] whiteKingLocation = new int[]{8, 4};
  int[] blackKingLocation = new int[]{0, 4};
  ArrayList<Piece> whiteCaptured = new ArrayList();
  ArrayList<Piece> blackCaptured = new ArrayList();
  ArrayList<int[]> restricted = new  ArrayList<int[]>();
  boolean whiteCheck = false;
  boolean blackCheck = false;// distinguished for testing logic
  ArrayList<int[]> blackCheckers = new ArrayList<int[]>(); // white pieces that check black king 
  ArrayList<int[]> whiteCheckers = new ArrayList<int[]>();
  ArrayList<int[]> supplementalThreats = new ArrayList<int[]>(); // king cannot move in a way that keeps it in check 
  ArrayList<int[]> saveTheKing = new ArrayList<int[]>(); // tiles that can block check 
  Tile[][] board = new Tile[9][9];
  public board() {
  }
  void checkCheck() {
    if (whiteCheck || blackCheck) {
      if (isCheckmate()) {
        System.out.println("You have been mated! (⁄ ⁄•⁄ω⁄•⁄ ⁄)⁄");
      }
    }
  }
  boolean isCheckmate() {
    boolean kill = false;
    boolean block = false;
    int x; 
    int y;
    if (saveTheKing.size() > 0) {
      System.out.println("SOMETHING IS VERY VERY WRONG!!!!!");
    }
    if (Turn) {
      x = whiteKingLocation[0];
      y = whiteKingLocation[1];
    } else {
      x = blackKingLocation[0];
      y = blackKingLocation[1];
    }
    // King cannot threaten a black threatened square while in check, out of check, kings should in order to prevent a king checking a king
    ArrayList<int[]> newKing = (ArrayList)board[x][y].piece.potentialMoves.clone();
    if (Turn) {
      for (int i = 0; i < newKing.size(); i++) {
        // may also need to remove from potential moves----- NEED TO REMOVE TO PREVENT DOUBLE UNTHREATEN 
        if (board[newKing.get(i)[1]][newKing.get(i)[0]].blackThreatened > 0) {
          board[newKing.get(i)[1]][newKing.get(i)[0]].setWhiteThreats(-1);
          newKing.remove(i);
          i--;
        }
      }
    } else {
      for (int i = 0; i < newKing.size(); i++) {
        // may also need to remove from potential moves----- NEED TO REMOVE TO PREVENT DOUBLE UNTHREATEN 
        if (board[newKing.get(i)[1]][newKing.get(i)[0]].whiteThreatened > 0) {
          board[newKing.get(i)[1]][newKing.get(i)[0]].setBlackThreats(-1);
          newKing.remove(i);
          i--;
        }
      }
    }
    board[x][y].piece.setPotential(newKing);
    // if cannot kill, nor block, then lastly check size of King's legal moves
    if (whiteCheckers.size() == 1) { // if there are two killers checking the king, your only choice is to move the king
      System.out.println("One killer checking");
      // check if killer can either be killed or blocked
      if (board[whiteCheckers.get(0)[0]][whiteCheckers.get(0)[1]].whiteThreatened > 0) {
        System.out.println("The killer can be killed!");
        saveTheKing.add(new int[]{whiteCheckers.get(0)[1], whiteCheckers.get(0)[0]}); // save the king is not in row major order 
        kill = true;
      }
      if (board[whiteCheckers.get(0)[0]][whiteCheckers.get(0)[1]].piece.isRoyal) {// can only "block" pieces that move more than 2 spaces
        //loop through potential keeping track of 100s until you hit the king, nothing should be blocking it in theory, cut out and add that to saveking array
        board[whiteCheckers.get(0)[0]][whiteCheckers.get(0)[1]].piece.calcPotential(whiteCheckers.get(0)[1], whiteCheckers.get(0)[0]);
        ArrayList<int[]> targets = (ArrayList)board[whiteCheckers.get(0)[0]][whiteCheckers.get(0)[1]].piece.potentialMoves.clone();
        royalPotential(whiteCheckers.get(0)[0], whiteCheckers.get(0)[1]);
        int oneHundred = -1;
        int index = -1;
        boolean notFound = true;
        for (int i = 0; i < targets.size() && notFound; i++) {
          if (targets.get(i)[0] == 100) {
            oneHundred = i;
          } else if (targets.get(i)[1] == x && targets.get(i)[0] == y) {
            index = i;
            notFound = false;
          }
        }
        if (index == -1) {
          System.out.println("INDEX IS STILL -1");
        } else {
          System.out.println("TARGETS BEING PROCESSED");
          for (int i = oneHundred + 1; i < index; i++) { // not index + 1 because king's tile should not be processed 
            System.out.println("PLEASE: " + targets.get(i)[1] + " " + targets.get(i)[0] + "WHITE THREATENED: " + board[targets.get(i)[1]][targets.get(i)[0]].whiteThreatened);
            if (board[targets.get(i)[1]][targets.get(i)[0]].whiteThreatened > 0) { // king still threatens tiles in front of it, fix king threaten

              block = true;
              saveTheKing.add(new int[]{targets.get(i)[0], targets.get(i)[1]});
            }
          }
        }
      }
    } else if (blackCheckers.size() == 1) {
      System.out.println("One killer checking");
      // check if killer can either be killed or blocked
      if (board[blackCheckers.get(0)[0]][blackCheckers.get(0)[1]].blackThreatened > 0) {
        System.out.println("The killer can be killed!");
        saveTheKing.add(new int[]{blackCheckers.get(0)[1], blackCheckers.get(0)[0]}); // save the king is not in row major order 
        kill = true;
      }
      if (board[blackCheckers.get(0)[0]][blackCheckers.get(0)[1]].piece.isRoyal) {// can only "block" pieces that move more than 2 spaces
        //loop through potential keeping track of 100s until you hit the king, nothing should be blocking it in theory, cut out and add that to saveking array
        board[blackCheckers.get(0)[0]][blackCheckers.get(0)[1]].piece.calcPotential(blackCheckers.get(0)[1], blackCheckers.get(0)[0]); // change to form with 100s
        ArrayList<int[]> targets = (ArrayList)board[blackCheckers.get(0)[0]][blackCheckers.get(0)[1]].piece.potentialMoves.clone(); // change back to royalPotential
        royalPotential(blackCheckers.get(0)[0], blackCheckers.get(0)[1]);
        int oneHundred = -1;
        int index = -1;
        boolean notFound = true;
        for (int i = 0; i < targets.size() && notFound; i++) {
          if (targets.get(i)[0] == 100) {
            oneHundred = i;
          } else if (targets.get(i)[1] == x && targets.get(i)[0] == y) {
            index = i;
            notFound = false;
          }
        }
        if (index == -1) {
          System.out.println("INDEX IS STILL -1");
        } else {
          System.out.println("TARGETS BEING PROCESSED");
          for (int i = oneHundred + 1; i < index; i++) { // not index + 1 because king's tile should not be processed 
            System.out.println("PLEASE: " + targets.get(i)[1] + " " + targets.get(i)[0] + "black THREATENED: " + board[targets.get(i)[1]][targets.get(i)[0]].blackThreatened);
            if (board[targets.get(i)[1]][targets.get(i)[0]].blackThreatened > 0) { // king still threatens tiles in front of it, fix king threaten

              block = true;
              saveTheKing.add(new int[]{targets.get(i)[0], targets.get(i)[1]});
            }
          }
        }
      }
    }
    if (kill || block) {
      System.out.println("KILL: " + kill + " BLOCK: " + block);
      for (int i = 0; i < saveTheKing.size(); i++) {
        System.out.println("TARGETS: " + saveTheKing.get(i)[0] + " " + saveTheKing.get(i)[1]);
      }
      return false;
    }

    if (legalMoves(x, y).size() > 0) {
      System.out.println("KING CAN STILL MOVE");
      return false;
    }
    checkmate = true;
    return true;

    // default, change later
  }
  int restrictedIndex(int x, int y) {
    for (int i = 0; i < restricted.size(); i++) {
      if (restricted.get(i)[0] == x && restricted.get(i)[1] == y) {
        System.out.println("YOU MOVED: " + restricted.get(i)[0] + " " + restricted.get(i)[1]);
        return i;
      }
    }
    return -1;
  }
  boolean drop(int x, int x1, int y1) { // x1 and y1 are not row major order
    if (board[y1][x1].piece!=null) {
      return false;
    } else {
      if (Turn) {
        for(int i = 0; i < 9; i++){
          if(board[i][x1].piece!=null){
            if(board[i][x1].piece.role.equals("pawn") && board[i][x1].piece.white){
              return false;
            }
          }
        }
        board[y1][x1].setPiece(whiteCaptured.get(x));
        whiteCaptured.remove(x);
        board[y1][x1].piece.switchSides();
        int[] move = {y1, x1};
        moves.add(move);
        String r = board[y1][x1].piece.role.replace("\n", " ");
        pieceMoved.add("white " + r);
        if (board[y1][x1].piece.isRoyal) {
          royalPotential(y1, x1);
          threaten(y1, x1);
        } else {
          board[y1][x1].piece.calcPotential(x1, y1);
        }
        if (board[y1][x1].royalThreats.size() > 0) {
          ArrayList<int[]> temp = (ArrayList)board[y1][x1].royalThreats.clone();
          for (int i = 0; i < temp.size(); i++) {           
            unthreaten(temp.get(i)[0], temp.get(i)[1]);
            royalPotential(temp.get(i)[0], temp.get(i)[1]);
            threaten(temp.get(i)[0], temp.get(i)[1]);
          }
        }  
        return true;
      }
      else{
        for(int i = 0; i < 9; i++){
          if(board[i][x1].piece!=null){
            if(board[i][x1].piece.role.equals("pawn") && !board[i][x1].piece.white){
              return false;
            }
          }
        }
        board[y1][x1].setPiece(blackCaptured.get(x));
        blackCaptured.remove(x);
        board[y1][x1].piece.switchSides();
        int[] move = {y1, x1};
        moves.add(move);
        String r = board[y1][x1].piece.role.replace("\n", " ");
        pieceMoved.add("black " + r);
        if (board[y1][x1].piece.isRoyal) {
          royalPotential(y1, x1);
          threaten(y1, x1);
        } else {
          board[y1][x1].piece.calcPotential(x1, y1);
        }
        if (board[y1][x1].royalThreats.size() > 0) {
          ArrayList<int[]> temp = (ArrayList)board[y1][x1].royalThreats.clone();
          for (int i = 0; i < temp.size(); i++) {           
            unthreaten(temp.get(i)[0], temp.get(i)[1]);
            royalPotential(temp.get(i)[0], temp.get(i)[1]);
            threaten(temp.get(i)[0], temp.get(i)[1]);
          }
        }
        return true;
      }
    }
  }
  boolean move(int x, int y, int x1, int y1) {
    // update restricted if x y is found inside 
    // MOVE this if statement when x1 and y1 are passed through unchecked and are potentially illegal
    if (restricted.size() > 0) {
      int index = restrictedIndex(x, y);
      if (index != -1) {
        restricted.remove(index);
        restricted.add(new int[]{x1, y1});
        String answ ="";
      for(int i = 0; i < restricted.size(); i++){
        answ += "[" + restricted.get(i)[0] + "," + restricted.get(i)[1] + "], ";
      }
      System.out.println("NEW RESTRICTED" + answ);
      }
    }
    boolean isLegal=false;
    ArrayList<int[]> lMoves = legalMoves(x, y);
    for(int i = 0; i < lMoves.size(); i++){
      int[] abc = {y1, x1};
      if(Arrays.equals(lMoves.get(i), abc)){
        isLegal=true;
      }
    }
    if(isLegal){
      // if there is a piece on other tile, move to Captured array 
      if (board[x1][y1].piece!=null) {
        if (board[x1][y1].piece.white==true) {
          board[x1][y1].piece.demote();
          blackCaptured.add(board[x1][y1].piece);
        } else {
          board[x1][y1].piece.demote();
          whiteCaptured.add(board[x1][y1].piece);
        }
      }
      // UNTHREATEN BOTH 
      // NEED TO UNTHREATEN other tile
      unthreaten(x, y);
      if (board[x1][y1].piece != null) {
  
        unthreaten(x1, y1);
      }
      // move current piece to other tile, set current tile's piece to null
      board[x1][y1].setPiece(board[x][y].piece);
      board[x][y].setPiece(null);
      int[] move = {x1, y1};
      moves.add(move);
      if(board[x1][y1].piece.white){
        String r = board[x1][y1].piece.role.replace("\n", " ");
        pieceMoved.add("white " + r);
      }
      else{
        String r = board[x1][y1].piece.role.replace("\n", " ");
        pieceMoved.add("black " + r);
      }
      // recalculate royal pieces' moves only if current piece had been blocking them 
      if (board[x][y].royalThreats.size() > 0) {
        ArrayList<int[]> temp = (ArrayList)board[x][y].royalThreats.clone();
        for (int i = 0; i < temp.size(); i++) {
  
          unthreaten(temp.get(i)[0], temp.get(i)[1]);
          royalPotential(temp.get(i)[0], temp.get(i)[1]);
          threaten(temp.get(i)[0], temp.get(i)[1]);
        }
      }
      // if current is royal, recalculate moves
      if (board[x1][y1].piece.isRoyal) {
        royalPotential(x1, y1); // x then y because move parameters are given in row major order
        // MOVE OUT OF IF STATEMENT when threaten is generalized
      } else {
        board[x1][y1].piece.calcPotential(y1, x1);
      }
      threaten(x1, y1);
      // current is now moved and may be blocking royals, recalculate royals' moves if so  
      if (board[x1][y1].royalThreats.size() > 0) {
        ArrayList<int[]> temp = (ArrayList)board[x1][y1].royalThreats.clone();
        for (int i = 0; i < temp.size(); i++) {
          //coordinate pair [0],[1] because r.T is in RMO
  
          unthreaten(temp.get(i)[0], temp.get(i)[1]);
          royalPotential(temp.get(i)[0], temp.get(i)[1]);
          threaten(temp.get(i)[0], temp.get(i)[1]);
        }
      }
      // check if orginal coors were king's Location 
      if (board[x1][y1].piece.white && x == whiteKingLocation[0] && y == whiteKingLocation[1]) {
        whiteKingLocation[0] = x1;
        whiteKingLocation[1] = y1;
        whiteCheck = false; 
        System.out.println("White King moved, not in check");
        saveTheKing.clear();
        whiteCheckers.clear(); // white should only be able to move in directions that are never threatened
      } else if (x == blackKingLocation[0] && y == blackKingLocation[1]) {
        blackKingLocation[0] = x1;
        blackKingLocation[1] = y1;
        blackCheck = false; 
        System.out.println("Black King moved, not in check");
        saveTheKing.clear();
        blackCheckers.clear();
      }
      return true;
    }
    else{
      return false;
    }
    // check if enemy king is in check
    //if (Turn) {
    //  if (board[blackKingLocation[0]][blackKingLocation[1]].whiteThreatened > 0) {
    //    blackCheck = true;
    //  } else {
    //    blackCheck = false;
    //  }
    //  System.out.println("You have just moved a white piece and black is in check: " + blackCheck);
    //} else {
    //  if (board[whiteKingLocation[0]][whiteKingLocation[1]].blackThreatened > 0) {
    //    whiteCheck = true;
    //  } else {
    //    whiteCheck = false;
    //  }
    //  System.out.println("You have just moved a black piece and white is in check: " + whiteCheck);
    //}
  }
  //ROYAL POTENTIAL IS ALWAYS CALLED IN ROW MAJOR ORDER 
  void royalPotential(int x, int y) {
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
          royalMoves.add(coors);
          crashed = true;
        } else {
          royalMoves.add(coors);
        }
      }
    }
    //String ans ="";
    //for (int i = 0; i < royalMoves.size(); i++) {
    //  ans += "[" + royalMoves.get(i)[0] + "," + royalMoves.get(i)[1] + "], ";

    //  System.out.println("ROYAL" + ans);
    //}
    board[x][y].piece.setPotential((ArrayList)royalMoves.clone());
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
        if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece != null) {
          if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.role.equals("king") && !board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.white) {
            blackCheckers.add(new int[] {x, y});
            blackCheck = true;
            System.out.println("Checking black in threaten");
          }
        }
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setWhiteThreats(1);
      } else {
        if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece != null) {
          if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.role.equals("king") && board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.white) {
            whiteCheckers.add(new int[] {x, y});
            whiteCheck = true;
            System.out.println("Checking white in threaten");
          }
        }
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
        if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece != null) {
          if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.role.equals("king") && !board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.white) {
            int index = -1;
            for (int a = 0; a < blackCheckers.size(); a++) {
              if (x == blackCheckers.get(a)[0] && y == blackCheckers.get(a)[1]) {
                index = a;
              }
            }
            if (index == -1) { 
              System.out.println("PLEASE FIX!");
            } else {
              blackCheckers.remove(index);
              if (blackCheckers.size() == 0) {
                blackCheck = false;
                saveTheKing.clear(); // MAY BE BUGGY 
                System.out.println("NO more black check");
                board[blackKingLocation[0]][blackKingLocation[1]].piece.calcPotential(blackKingLocation[1], blackKingLocation[0]);
              }
            }
          }
        }
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setWhiteThreats(-1);
      } else {
        if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece != null) {
          if (board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.role.equals("king") && board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].piece.white) {
            int index = -1;
            for (int a = 0; a < whiteCheckers.size(); a++) {
              if (x == whiteCheckers.get(a)[0] && y == whiteCheckers.get(a)[1]) {
                index = a;
              }
            }
            if (index == -1) { 
              System.out.println("PLEASE FIX!");
            } else {
              System.out.println("REMOVE FROM WHITE CHECKERS");
              whiteCheckers.remove(index);
              if (whiteCheckers.size() == 0) {
                whiteCheck = false;
                saveTheKing.clear(); // MAY BE BUGGY 
                System.out.println("NO more white check");
                board[whiteKingLocation[0]][whiteKingLocation[1]].piece.calcPotential(whiteKingLocation[1], whiteKingLocation[0]); // DO NEXT: UNTHREATEN AND THEN THREATEN 
              }
            }
          }
        }
        board[board[x][y].piece.potentialMoves.get(i)[1]][board[x][y].piece.potentialMoves.get(i)[0]].setBlackThreats(-1);
      }
    }
  }
  ArrayList<int[]> legalMoves(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    Piece piece = board[x][y].piece;
    ans=(ArrayList)piece.potentialMoves.clone();
    if (piece.role.equals("king")) {
      if (piece.white) {
        for (int i = 0; i < ans.size(); i++) {
          Tile tile = board[ans.get(i)[1]][ans.get(i)[0]];
          if (tile.blackThreatened > 0 || (tile.piece != null && tile.piece.white)) {
            ans.remove(i);
            i--;
          }
        }
      } else {
        for (int i = 0; i < ans.size(); i++) {
          Tile tile = board[ans.get(i)[1]][ans.get(i)[0]];
          System.out.println("King at: " + x + " " + y + " Move " + i + ": " + ans.get(i)[1] + " " + ans.get(i)[0] + " white threats: " + board[ans.get(i)[1]][ans.get(i)[0]].whiteThreatened );
          System.out.println(tile.whiteThreatened);
          if (tile.whiteThreatened > 0 || (tile.piece != null && !tile.piece.white)) {
            ans.remove(i);
            i--;
          }
        }
      }
    } else if (whiteCheck || blackCheck) {
      System.out.println("SHOULD NOT BE ZERO, UNLESS CHECKMATED: " + saveTheKing.size());
      System.out.println("white check: " + whiteCheck + " black check: " + blackCheck);
      for (int i = 0; i < ans.size(); i++) {
        boolean found = false;
        for (int a = 0; a < saveTheKing.size() && !found; a++) {
          if (ans.get(i)[1] == saveTheKing.get(a)[1] && ans.get(i)[0] == saveTheKing.get(a)[0]) {
            found = true;
          }
        }
        if (!found) {
          ans.remove(i);
          i--;
        }
      }
    } else {
      for (int i = 0; i < ans.size(); i++) {
        Tile tile = board[ans.get(i)[1]][ans.get(i)[0]];
        if (tile.piece != null) {
          if ((tile.piece.white && piece.white) || (!tile.piece.white && !piece.white)) {
            ans.remove(i);
            i--;
          }
        }
      }
    }
    return ans;
  }
  // prevent check should be called at the beginning of a turn
  void topColumn(int ogX, int ogY) {
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (x > 0 && look) {
      x-=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
          //
        } else if (board[x][y].piece.white == Turn) {
          // System.out.println("hitted and ally and then hitted an ally");
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook") || board[x][y].piece.role.equals("lance"))) { // no ally hit and piece hit is not an ally 
          System.out.println("IN CHECK!");
          // DO QUICK: THREATEN tile below the king in the same row based on TURN , add to supplement threats, REMOVE IN revert method opposite of turn 
          // because revert happens after the turn changes 
          if (ogX + 1 <= 8) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX+1][ogY].setBlackThreats(1);
            } else {
              board[ogX+1][ogY].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX+1, ogY});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook") || board[x][y].piece.role.equals("lance")) {
          //  System.out.println("hitted an ally and then hitted an Enemy on the horizon!");
          if (board[x][y].piece.role.equals("lance") && x <= ogX) {
            look = false;
          } else {
            int pX = protector.get(0); 
            int pY = protector.get(1);
            ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
            for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
              if (y != restriction.get(i)[0]) { // unthreaten then remove
                if (board[pX][pY].piece.isRoyal) {
                  board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
                } 

                if (Turn) {
                  board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
                } else {
                  board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
                }
                restriction.remove(i);
                i--;
                // set new Potential
              }
            }
            restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
          }
        } else {
          //System.out.println("Enemy on the horizon! BUT THEY DONT HIT");
          look = false;
        }
      }
    }
  }
  void bottomColumn(int ogX, int ogY) {
    // System.out.println("Bottom COLUMN PREVENTION");
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (x < 8 && look) {
      x+=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
          //
        } else if (board[x][y].piece.white == Turn) {
          //   System.out.println("hitted and ally and then hitted an ally");
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook") || board[x][y].piece.role.equals("lance"))) { // no ally hit and piece hit is not an ally 
          //   System.out.println("IN CHECK!");
          if (ogX - 1 >=0) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX-1][ogY].setBlackThreats(1);
            } else {
              board[ogX-1][ogY].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX-1, ogY});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook") || board[x][y].piece.role.equals("lance")) {
          //  System.out.println("hitted an ally and then hitted an Enemy on the horizon!");
          if (board[x][y].piece.role.equals("lance") && x >= ogX) {
            look = false;
          } else {
            // Juicy code: if potentialMoves of protector is NOT in the SAME VERTICAL ROW, remove from potential, unthreaten 
            int pX = protector.get(0); 
            int pY = protector.get(1);
            ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
            for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
              if (y != restriction.get(i)[0]) { // unthreaten then remove
                if (board[pX][pY].piece.isRoyal) {
                  board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
                } 

                if (Turn) {
                  board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
                } else {
                  board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
                }
                restriction.remove(i);
                i--;
                // set new Potential
              }

              
            }
            restricted.add(new int[]{pX, pY});
              board[pX][pY].piece.setPotential(restriction);
              look = false;
          }
        } else {
          //  System.out.println("Enemy on the horizon! BUT THEY DONT HIT");
          look = false;
        }
      }
    }
  }
  void leftRow(int ogX, int ogY) {
    // System.out.println("left ROW PREVENTION");
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (y > 0 && look) {
      y-=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
          //
        } else if (board[x][y].piece.white == Turn) {
          //    System.out.println("hitted and ally and then hitted an ally");
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook"))) { // no ally hit and piece hit is not an ally 
          //   System.out.println("IN CHECK!");
          if (ogY + 1 <=8) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX][ogY +1].setBlackThreats(1);
            } else {
              board[ogX][ogY +1].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX, ogY +1});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook")) {
          //   System.out.println("hitted an ally and then hitted an Enemy on the horizon!");

          // Juicy code: if potentialMoves of protector is NOT in the SAME ROW, remove from potential, unthreaten 
          int pX = protector.get(0); 
          int pY = protector.get(1);
          ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
          for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
            if (x != restriction.get(i)[1]) { // unthreaten then remove
              if (board[pX][pY].piece.isRoyal) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
              } 

              if (Turn) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
              } else {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
              }
              restriction.remove(i);
              i--;
              // set new Potential
            }

           
          }
           restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
        } else {
          //  System.out.println("Enemy on the horizon! BUT THEY DONT HIT");
          look = false;
        }
      }
    }
  }
  void rightRow(int ogX, int ogY) {
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (y < 8 && look) {
      y+=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
        } else if (board[x][y].piece.white == Turn) {
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook"))) { // no ally hit and piece hit is not an ally 
          if (ogY - 1 >= 0) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX][ogY -1].setBlackThreats(1);
            } else {
              board[ogX][ogY -1].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX, ogY -1});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("rook") || board[x][y].piece.role.equals("promoted \n rook")) {
          int pX = protector.get(0); 
          int pY = protector.get(1);
          ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
          for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
            if (x != restriction.get(i)[1]) { // unthreaten then remove
              if (board[pX][pY].piece.isRoyal) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
              } 

              if (Turn) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
              } else {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
              }
              restriction.remove(i);
              i--;
              // set new Potential
            }
           
          }
           restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
        } else {
          look = false;
        }
      }
    }
  }
  void rightTopDiagonal(int ogX, int ogY) {
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (y < 8 && x > 0 && look) {
      y+=1;
      x-=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
        } else if (board[x][y].piece.white == Turn) {
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop"))) { // no ally hit and piece hit is not an ally 
          if (ogY - 1 >= 0 && ogX +1 <= 8) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX + 1][ogY -1].setBlackThreats(1);
            } else {
              board[ogX + 1][ogY -1].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX + 1, ogY -1});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop")) {
          int pX = protector.get(0); 
          int pY = protector.get(1);
          ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
          for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
            if (ogX - restriction.get(i)[1] != restriction.get(i)[0] - ogY) { // unthreaten then remove
              if (board[pX][pY].piece.isRoyal) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
              } 
              if (Turn) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
              } else {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
              }
              restriction.remove(i);
              i--;
              // set new Potential
            }
           
          }
           restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
        } else {
          look = false;
        }
      }
    }
  }
  void leftTopDiagonal(int ogX, int ogY) {
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (y > 0 && x > 0 && look) {
      y-=1;
      x-=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
        } else if (board[x][y].piece.white == Turn) {
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop"))) { // no ally hit and piece hit is not an ally 
          if (ogY + 1 <= 8 && ogX +1 <= 8) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX + 1][ogY +1].setBlackThreats(1);
            } else {
              board[ogX + 1][ogY +1].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX + 1, ogY +1});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop")) {
          int pX = protector.get(0); 
          int pY = protector.get(1);
          ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
          for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
            if (ogX - restriction.get(i)[1] != ogY - restriction.get(i)[0]) { // unthreaten then remove
              if (board[pX][pY].piece.isRoyal) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
              } 
              if (Turn) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
              } else {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
              }
              restriction.remove(i);
              i--;
              // set new Potential
            }
            
          }
          restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
        } else {
          look = false;
        }
      }
    }
  }
  void rightBottomDiagonal(int ogX, int ogY) {
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (y < 8 && x < 8 && look) {
      y+=1;
      x+=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
        } else if (board[x][y].piece.white == Turn) {
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop"))) { // no ally hit and piece hit is not an ally 
          if (ogY - 1 >= 0 && ogX -1 >= 0) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX - 1][ogY -1].setBlackThreats(1);
            } else {
              board[ogX - 1][ogY -1].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX - 1, ogY -1});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop")) {
          // Juicy code: if potentialMoves of protector is NOT in the SAME ROW, remove from potential, unthreaten 
          int pX = protector.get(0); 
          int pY = protector.get(1);
          ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
          for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
            if (restriction.get(i)[1] - ogX != restriction.get(i)[0] - ogY) { // unthreaten then remove
              if (board[pX][pY].piece.isRoyal) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
              } 
              if (Turn) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
              } else {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
              }
              restriction.remove(i);
              i--;
              // set new Potential
            }
            
          }
          restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
        } else {
          look = false;
        }
      }
    }
  }
  void leftBottomDiagonal(int ogX, int ogY) {
    boolean look = true;
    int x = ogX; 
    int y = ogY;
    ArrayList<Integer> protector = new ArrayList<Integer>(); 
    // white king checking 
    // check vertical
    while (y > 0 && x < 8 && look) {
      y-=1;
      x+=1;
      if (board[x][y].piece != null) {
        if (protector.size() == 0 && board[x][y].piece.white == Turn) {
          protector.add(x);
          protector.add(y);
        } else if (board[x][y].piece.white == Turn) {
          look = false;
        } else if (protector.size() == 0 && (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop"))) { // no ally hit and piece hit is not an ally 
          if (ogY + 1 <= 8 && ogX -1 >= 0) {
            if (Turn) {
              //System.out.println("SUPPLEMENTAL WHITE: " + (ogX+1) + " " + ogY);

              board[ogX - 1][ogY +1].setBlackThreats(1);
            } else {
              board[ogX - 1][ogY +1].setWhiteThreats(1);
            }
            supplementalThreats.add(new int[]{ogX - 1, ogY +1});
            //System.out.println("SUPPLEMENTAL");
          }
          look = false;
        } else if (board[x][y].piece.role.equals("bishop") || board[x][y].piece.role.equals("promoted \n bishop")) {
          // Juicy code: if potentialMoves of protector is NOT in the SAME ROW, remove from potential, unthreaten 
          int pX = protector.get(0); 
          int pY = protector.get(1);
          ArrayList<int[]> restriction = (ArrayList)board[pX][pY].piece.potentialMoves.clone();
          for (int i = 0; i < restriction.size(); i++) { // REMEMBER TO i-- when removing
            if (restriction.get(i)[1] - ogX != ogY - restriction.get(i)[0]) { // unthreaten then remove
              if (board[pX][pY].piece.isRoyal) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].removeRoyalThreat(new int[]{pX, pY}); //LOOKY FOR BUG
              }
              if (Turn) {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setWhiteThreats(-1);
              } else {
                board[restriction.get(i)[1]][restriction.get(i)[0]].setBlackThreats(-1);
              }
              restriction.remove(i);
              i--;
              // set new Potential
            }
          }
          restricted.add(new int[]{pX, pY});
            board[pX][pY].piece.setPotential(restriction);
            look = false;
        } else {
          look = false;
        }
      }
    }
  }
  void preventCheck() {
    int ogX; 
    int ogY;
    if (Turn) {
      System.out.println("TURNED PASS " + Turn);
      ogX = whiteKingLocation[0];
      ogY = whiteKingLocation[1];
    } else {
      ogX = blackKingLocation[0];
      ogY = blackKingLocation[1];
    }
    topColumn(ogX, ogY);
    bottomColumn(ogX, ogY);
    leftRow(ogX, ogY);
    rightRow(ogX, ogY);
    rightTopDiagonal(ogX, ogY);
    leftTopDiagonal(ogX, ogY);
    rightBottomDiagonal(ogX, ogY);
    leftBottomDiagonal(ogX, ogY);
  }

  void revertPreviousPreventCheck() {
    if (Turn) {
      for (int i = 0; i < whiteCheckers.size(); i++) {
        System.out.println("WHITE KILLER: " + whiteCheckers.get(i)[0] + " " +  whiteCheckers.get(i)[1]);
      } 
      System.out.println("ANYTHING ABOVE?");
    }
    if (saveTheKing.size() > 0) {
      saveTheKing.clear();
    }
    if (restricted.size() > 0) {
      String answ ="";
      for(int i = 0; i < restricted.size(); i++){
        answ += "[" + restricted.get(i)[0] + "," + restricted.get(i)[1] + "], ";
      }
      System.out.println("RESTRICTED BEING PROCESSED: " + answ);
      for (int i = 0; i < restricted.size(); i++) {
        System.out.println("BUGG: "+restricted.get(i)[0] + " " + restricted.get(i)[1] );
        unthreaten(restricted.get(i)[0], restricted.get(i)[1]);
        if (board[restricted.get(i)[0]][restricted.get(i)[1]].piece.isRoyal) {
          royalPotential(restricted.get(i)[0], restricted.get(i)[1]);
        } else {
          board[restricted.get(i)[0]][restricted.get(i)[1]].piece.calcPotential(restricted.get(i)[1], restricted.get(i)[0]);
        }
        threaten(restricted.get(i)[0], restricted.get(i)[1]);
      }
      restricted.clear();
    }
    if (supplementalThreats.size() > 0) {
      for (int i = 0; i < supplementalThreats.size(); i++) {
        System.out.println(Turn + " Supplements in threat: " + supplementalThreats.get(i)[0] + " " + supplementalThreats.get(i)[1]);
        if (Turn) {
          board[supplementalThreats.get(i)[0]][supplementalThreats.get(i)[1]].setWhiteThreats(-1);
        } else {
          board[supplementalThreats.get(i)[0]][supplementalThreats.get(i)[1]].setBlackThreats(-1);
        }
      }
      supplementalThreats.clear();
    }
  }
}
