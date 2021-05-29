Board test;
int row;
int col;
boolean start;

void setup() {
  size(576, 1024);
  start = true;
  //test = new Board(1);
  //test.display();
}

void draw() {
  // starting screen hopefully
  if (start) {
    background(255);
    fill(0);
    noStroke();
    textSize(25); //n needs tweaking
    textAlign(CENTER, CENTER);
    text("PKMN SHUFFLE", width/2, height/4);
    text("Click anywhere to proceed", width/2, height/2);
  }
  else {
    test.display();
  }
}

// orb moving during board
void mousePressed() {
  if (start) {
    boardSetup();
  }
  else {
    if (mouseY >= 448 && mouseY < 1024) { // and if game started
      row = (mouseY - 448) / 96;
      col = mouseX / 96;
      //println(row + ", " + col);
      test.getPokemon(row, col).toggleSelect();
    }
    else if (test.gameOver){
      if (mouseX<=360&&mouseX>=180&&mouseY>=500-100&&mouseY<=580-100){
        test=new Board(99);
        //just for testing, actual game over should probably send to start menu
      }
    }
  }
}

void mouseReleased() {
  if (start) {
    start = false;
  }
  else {
    int prevRow = row;
    int prevCol = col;
    if (mouseY >= 448 && mouseY < 1024) {
      test.getPokemon(row, col).toggleSelect();
      try {
        test.swap(prevRow, prevCol, (mouseY - 448) / 96, mouseX / 96);
        if (!test.check3Combo()) {
          test.swap((mouseY - 448) / 96, mouseX / 96, prevRow, prevCol);
        }
        else {
          test.scoreCalc();
        }
      }
      catch (InterruptedException e) {}
    }
  }
}

void boardSetup() {
  test = new Board(1);
  test.display();
}
