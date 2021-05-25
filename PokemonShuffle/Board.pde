public class Board {
  int[][] board;
  int currentScore;
  int movesLeft;

Board(int moves) {
  board = new int[6][6];
  currentScore = 0;
  movesLeft = moves;
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

void swap(int r1, int c1, int r2, int c2) {
  int temp = board[r1][c1];
  board[r1][c1] = board[r2][c2];
  board[r2][c2] = temp;
}

}
