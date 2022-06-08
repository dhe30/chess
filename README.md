# chess

Link to prototype/ documentaton: https://docs.google.com/document/d/1A4bUR4OBpwLU0ONEd4BxkZcPGgR9N_BF_VonWyCaxBM/edit?usp=sharing

Project description: Shogi, the most popular chess variant in Japan; shō 将, meaning general, and gi 棋, boardgame. We will simulate 2 player shogi in processing– this entails a displaying of the board and all 40 pieces, along with their unique movements. We will implement a turn system and a check and checkmate system as required in a game of chess. We will also obey the special edge cases involved with the shogi drop rule*. In acknowledgement that only 1/6th of the people in Japan know the rules of Shogi, and therefore even less in Stuyvesant, we will offer a visual tutorial in processing that can be accessed through a button.

May 18, 2022

    Daniel: discussed basic plans with Samuel, began drafting ideas 

    Samuel: discussed with Daniel
    
May 19, 2022

    Daniel: worked on development stages, descriptions, and basic outline of our prototype 

    Samuel: wrote down ideas for how to implement threatening, checkmates, and captured pieces

May 22, 2022

    Daniel : added clicking to move pieces and turns (can move anywhere for now). fixed NullPointer and OutOfBounds edge cases.
     
    Samuel: created the basic setup as well as all the chess pieces. added calcPotential to all the pieces. Had the board and pieces drawn in processing. 

May 23, 2022 

    Daniel: added royalPotential and necessary fields/ methods to make it work. Threaten and unthreaten methods are deployed but only work for royals. 

    Samuel: added highlighting and finished up calcPotential. discussed with Daniel about how to deal with royal pieces, blocking, and checks. 

May 24: 

    Samuel: added the start of the promotion concept. still need to work on making the order right. added forced promotion and optional promotion.

    Daniel: worked on threaten and potential methods and fixed bugs, they now cause no issues with 90% confidence

May 25:

    Daniel: Began method that checks for illegal moves that would put your king into check, method currently only looks at the column above the king.

    Samuel: completed promotion

May 26:
	
    Samuel: started working on drop
    
    Daniel: Finished illegal move (puts king in check) prevention and fixed edge cases

May 27: 

    Daniel: Finished some other cases of illegal moves and began the framework for checkmate

    Samuel: made it so it is easier to tell which piece is selected

May 28: 

    Daniel: finished checkmate and illegal move prevention during check  
    
May 30:
    
    Samuel: added a tutorial

May 31:

    Samuel: fixed many aesthetic and minor issues

June 1:

    Daniel: added some more kanji and fixed their position, added threaten/ unthreaten to bot
    
    Samuel: made chessBot using random moves


June 2: 

    Daniel: added lava theme 
    
June 3: 

    Samuel: Made chessBot be smart by checking every possible move and attacks most valuable piece

June 7: 

    Daniel: fixed bot to properly handle check and fixed other bot bugs

