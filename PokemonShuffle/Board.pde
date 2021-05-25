public class Board {
  int[][] board;
  int currentScore;
  int movesLeft;

Board(int moves) {
  board = new int[6][6];
  currentScore = 0;
  movesLeft = moves;
  generateBoard();
}

void generateBoard() {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      board[i][j] = (int) (Math.random() * 4);
    }
  }
}

int getCurrentScore() {
  return currentScore;
}

int getMovesLeft() {
  return movesLeft;
}

void swap(int r1, int c1, int r2, int c2) {
  int temp = board[r1][c1];
  board[r1][c1] = board[r2][c2];
  board[r2][c2] = temp;
}

//"updates" board everytime something happens
//colors for now, might be replaced with PImages later
void display() {
  background(255);
  noStroke();
  fill(0);
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == 0) fill(0);
      if (board[i][j] == 1) fill(60);
      if (board[i][j] == 2) fill(180);
      if (board[i][j] == 3) fill(240);
      rect(0+96*j, 448+96*i, 96, 96);
    }
  }
  
  fill(0);
  textSize(24);
  text("Score: " + getCurrentScore() + "\nMoves Left: " + getMovesLeft(), 0+4, 24+4);
}
}
