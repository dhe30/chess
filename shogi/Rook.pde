public class Rook extends Piece {
  final color One = color(65, 65, 65);
  final color Two = color(98, 98, 90);
  final color Three = color(346, 147, 41);
  final color Four = color(213, 97, 65);
  final color Five = color(246, 246, 41);
  final color Six = color(98, 74, 205);
  final color Seven = color(189, 164, 65);
  final color Eight = color(255, 255, 255);
  float accelerationX = 0;
  float accelerationY = 0;
  boolean fly = false;
  public Rook(String x) {
    super(x);
    role="rook";
    isRoyal=true;
    value=10;
    display = "rook.txt";
    alienDisplay = "char.txt";
  }
  void calcPotential(int x, int y) {
    ArrayList<int[]> ans = new ArrayList();
    int ogX = x;
    int ogY = y;
    while (x<8) {
      x++;
      int[] right = {x, y};
      ans.add(right);
    }     
    ans.add(new int[]{100, 100});

    x=ogX;
    y=ogY;
    while (x>0) {
      x--;
      int[] left = {x, y};
      ans.add(left);
    }    
    ans.add(new int[]{100, 100});

    x=ogX;
    y=ogY;
    while (y<8) {
      y++;
      int[] down = {x, y};
      ans.add(down);
    }    
    ans.add(new int[]{100, 100});

    x=ogX;
    y=ogY;
    while (y>0) {
      y--;
      int[] up = {x, y};
      ans.add(up);
    }    
    ans.add(new int[]{100, 100});

    if (promoted) {
      if (ogX!=0 && ogY!=0) {
        int[] upperLeft = {ogX-1, ogY-1};
        ans.add(upperLeft);
      }    
      ans.add(new int[]{100, 100});

      if (ogX!=0 && ogY!=8) {
        int[] downLeft = {ogX-1, ogY+1};
        ans.add(downLeft);
      }    
      ans.add(new int[]{100, 100});

      if (ogX!=8 && ogY!=0) {
        int[] upperRight = {ogX+1, ogY-1};
        ans.add(upperRight);
      }    
      ans.add(new int[]{100, 100});

      if (ogX!=8 && ogY!=8) {
        int[] downRight = {ogX+1, ogY+1};
        ans.add(downRight);
      }    
      ans.add(new int[]{100, 100});
    }
    potentialMoves=(ArrayList)ans.clone();
  }

  void promote() {
    promoted=true;
    role="promoted\nrook";
    value=20;
    display = "promRook.txt";
  }
  void demote() {
    promoted=false;
    role="rook";
    value=10;
    display = "rook.txt";
  }
  void displayPiece(int x, int y, boolean white, String line) {
    String[] lines = loadStrings(line);
    int start = 1;
    int end = 25;
    if (idleCounter <= 180) {
      start = 1;
      end = 25;
    } else if (idleCounter > 180) {
      start = 26;
      end = 50;
    } else {
      start = 0;
      end = 0;
    }
    if (white) {
      if (Theme.equals("Alien")) {
      x-=10;

        lines = loadStrings(alienDisplay);
        float scale = 3.4;
        //x+=idleCounter;
        idleCounter+=1;
        if (idleCounter == 360) {
          idleCounter =0;
        }
        if (animating) {
          if (!fly) {
            if (movingCounter % 3 == 0) {
              start = 1;
              end = 25;
            } else {
              start = 51;
              end = 75;
              // switcher = !switcher;
            }
          } else {
            if (Math.abs(accelerationX) > 0) {
              scaleX += accelerationX;
            } else {
              scaleY += accelerationY;
            }
            start = 76;
            end = 100;
          }
          movingCounter +=1;
          displayX += scaleX;
          displayY += scaleY;
          //if (movingCounter >20) {
          //  scaleX= 0;
          //  scaleY= 0;
          //  start = 35;
          //  end = 51;
          //}
        }
        for (int i = start; i < end; i++) {
          //System.out.println(i);
          for (int a = lines[i].length() - 1; a >= 0; a--) {
            if (lines[i].charAt(a)=='7') {
              fill(Seven);
            } else if (lines[i].charAt(a)=='1') {
              fill(One);
            } else if (lines[i].charAt(a)=='2') {
              fill(Two);
            } else if (lines[i].charAt(a)=='3') {
              fill(Three);
            } else if (lines[i].charAt(a)=='4') {
              fill(Four);
            } else if (lines[i].charAt(a)=='5') {
              fill(Five);
            } else if (lines[i].charAt(a)=='6') {
              fill(Six);
            } else if (lines[i].charAt(a)=='8') {
              fill(Eight);
            }
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                if (fly) {
                  rect(displayX + ((lines[i].length() - a)*scale), displayY+((i-start)*scale)-8, scale+0.5, scale+0.5);
                  if (promoted) {
                  fill(#F965FA, 100);
                                    rect(displayX + ((lines[i].length() - a)*scale), displayY+((i-start)*scale)-8, scale+0.5, scale+0.5);

                  }
                } else {
                  rect(displayX + ((lines[i].length() - a)*scale), displayY+((i-start)*scale), scale+0.5, scale+0.5);
                  if (promoted) {
                  fill(#F965FA, 100);
                                    rect(displayX + ((lines[i].length() - a)*scale), displayY+((i-start)*scale), scale+0.5, scale+0.5);

                  }
                }
                if (movingCounter >= Stop) {
                  animating = false;
                  //System.out.println(movingCounter);
                }
              } else {
                rect(x + ((lines[i].length() - a)*scale), y+((i-start)*scale), scale+0.5, scale+0.5);
                if (promoted) {
                  fill(#F965FA, 100);
                                  rect(x + ((lines[i].length() - a)*scale), y+((i-start)*scale), scale+0.5, scale+0.5);

                }
              }
            }
          }
        }
      } else {
        fill(173, 168, 164);
        rect(x +17, y +44, 60, 50);
        triangle(x +17, y +44, x +77, y +44, x +47, y +14);
        fill(255);
        if (Theme.equals("Hell")) {
          fill(255, 225, 214);
        }
        rect(x +20, y +40, 60, 50);
        triangle(x +20, y +40, x +80, y +40, x +50, y +10);
        fill(0);
        if (promoted) {
          fill(211, 4, 4);
        }
        if (English) {          
          text(role, x+30, y+55);
        } else {
          if (promoted) {
            x=x +30;
            y=y +38;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {
                  rect(x + (a*2.6), y+(i*2.4), 2.6, 2.5);
                }
              }
            }
          } else {
            x=x +35;
            y=y +38;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {
                  rect(x + (a*2.2), y+(i*1.9), 2.2, 3.6);
                }
              }
            }
          }
        }
      }
    } else {
      if (Theme.equals("Alien")) {

        lines = loadStrings(alienDisplay);
        float scale = 3.4;
        //x+=idleCounter;
        idleCounter+=1;
        if (idleCounter == 360) {
          idleCounter =0;
        }
        if (animating) {
          if (!fly) {
            if (movingCounter % 3 == 0) {
              start = 1;
              end = 25;
            } else {
              start = 51;
              end = 75;
              // switcher = !switcher;
            }
          } else {
            if (Math.abs(accelerationX) > 0) {
              scaleX += accelerationX;
            } else {
              scaleY += accelerationY;
            }
            start = 76;
            end = 100;
          }
          movingCounter +=1;
          displayX += scaleX;
          displayY += scaleY;
          //if (movingCounter >20) {
          //  scaleX= 0;
          //  scaleY= 0;
          //  start = 35;
          //  end = 51;
          //}
        }
        for (int i = start; i < end; i++) {
          //System.out.println(i);
          for (int a = 0; a < lines[i].length(); a++) {
            if (lines[i].charAt(a)=='7') {
              fill(Seven);
            } else if (lines[i].charAt(a)=='1') {
              fill(One);
            } else if (lines[i].charAt(a)=='2') {
              fill(Two);
            } else if (lines[i].charAt(a)=='3') {
              fill(Three);
            } else if (lines[i].charAt(a)=='4') {
              fill(Four);
            } else if (lines[i].charAt(a)=='5') {
              fill(Five);
            } else if (lines[i].charAt(a)=='6') {
              fill(Six);
            } else if (lines[i].charAt(a)=='8') {
              fill(Eight);
            }
            if (lines[i].charAt(a)!='0') {
              if (animating) {
                System.out.println(displayX+ " " +displayY + " " + scaleX);
                if (fly) {
                  rect(displayX + (a*scale), displayY+((i-start)*scale)-8, scale+0.5, scale+0.5);
                  if (promoted) {
                  fill(#F965FA, 100);
                                    rect(displayX + (a*scale), displayY+((i-start)*scale)-8, scale+0.5, scale+0.5);

                  }
                } else {
                  rect(displayX + (a*scale), displayY+((i-start)*scale), scale+0.5, scale+0.5);
                  if (promoted) {
                  fill(#F965FA, 100);
                                    rect(displayX + (a*scale), displayY+((i-start)*scale), scale+0.5, scale+0.5);

                  }
                }
                if (movingCounter >= Stop) {
                  animating = false;
                  //System.out.println(movingCounter);
                }
              } else {
                rect(x + (a*scale), y+((i-start)*scale), scale+0.5, scale+0.5);
                if (promoted) {
                  fill(#F965FA, 100);
                                  rect(x + (a*scale), y+((i-start)*scale), scale+0.5, scale+0.5);

                }
              }
            }
          }
        }
      } else {
        fill(173, 168, 164);
        rect(x +17, y +13, 60, 50);
        triangle(x +17, y +63, x +77, y +63, x +47, y +93);
        fill(255);
        if (Theme.equals("Hell")) {
          fill(255, 225, 214);
        }
        rect(x +20, y +10, 60, 50);
        triangle(x +20, y +60, x +80, y +60, x +50, y +90);
        fill(0);

        //int newRow = 0;
        //String store1 = "";
        //String store2= "";
        //for (int i = 1; i <= lines.length / 2; i++) {
        //  newRow = lines.length - i;
        //  for (int a = lines[i].length() - 1; a >= 0; a--) {
        //    store1 += lines[i].substring(a, a+1);
        //    store2 += lines[newRow].substring(a, a+1);
        //  }
        //  lines[i] = store2;
        //  lines[newRow] = store1;
        //  store1="";
        //  store2="";
        //}
        if (promoted) {
          fill(211, 4, 4);
        }
        if (English) {
          text(role, x+30, y+45);
        } else {
          if (promoted) {

            x=x +30;
            y=y +27;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {
                  rect(x + (a*2.6), y+(i*2.4), 2.6, 2.5);
                }
              }
            }
          } else {

            x=x +35;
            y=y +30;
            for (int i = 1; i < lines.length; i++) {
              for (int a = 0; a < lines[i].length(); a++) {
                if (lines[i].charAt(a)=='1') {
                  rect(x + (a*2.2), y+(i*1.9), 2.2, 3.6);
                }
              }
            }
          }
        }
      }
    }
  }
  void animate(int x, int y, int x1, int y1) {
    fly = false;
    accelerationY =0;
    accelerationX = 0;
    animating = true;
    movingCounter = 0;
    displayY = x*100;
    displayX = y*100;
    if(white){
          displayX-=10;

    }
    scaleY = ((x1*100)-(x*100.0))/Stop;
    scaleX = ((y1*100)-(y*100.0))/Stop;
    System.out.println(scaleX + " " + scaleY);
    if (Math.abs(scaleX) > 15 || Math.abs(scaleY) > 15) {
      fly = true;
      if (scaleY == 0) {
        scaleX = 0;
        accelerationX = (2.0*((y1*100.0)-(y*100.0)))/(Stop*Stop);
        System.out.println(accelerationX + " " + accelerationY);
      } else if (scaleX == 0) {
        scaleY = 0;
        accelerationY = (2*((x1*100)-(x*100)))/(Stop*Stop);
      }
    }
    System.out.println(displayX + " " + displayY + " " + scaleX + " " + scaleY);
  }
}
